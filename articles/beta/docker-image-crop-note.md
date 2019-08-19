{"title": "","description": "","category": "","tag": [""],"page_image": "/assets/"}

# 一次 Docker 镜像 瘦身实记

[TOC]

笔者在此之前完全没有在意过 Docker 镜像的大小...

(或许 副标题可以取成 《如何将你的 Docker 镜像大小缩减 99%!!XD》:joy: 太羞耻了233 )

## 缘起

在书写 Dockerfile 放到 Kubernetes 中的之后, 发现 Node 的磁盘容量被消耗的很快, 发现是 Pod 内的 Docker Container 过大导致. 一个仅仅 用于运行 micro/micro 的 Micro Api 的 Container 占地面积 1G+ ...., 让人有些汗颜, 遂开始尝试 对 Container 的 镜像 进行瘦身.


## 第一个尝试 (删除剩余缓存)

如下面这个 DockerFile 所示, 让我们看看构建后, 构建出来的 Image 占多少空间

```dockerfile
FROM alpine:latest

USER root

RUN apk update && apk add go git musl-dev

# 添加 go 环境变量
RUN echo "export PATH=\$PATH:/root/go/bin" >> /etc/profile \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile  \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
    && source /etc/profile

# 安装 micro
RUN cd \
    && go get -u -v github.com/micro/micro \
    && go install github.com/micro/micro

EXPOSE 8080

CMD ["micro","api"]
```

构建 Docker Image

```bash
$ docker build . --tag=micro:v1.01
# 查看镜像大小
$ docker image ls | grep micro
micro    v1.01    2b1330a05f90   27 seconds ago   948MB
```

ok, 我们看到 `948MB`, 都快接近 1 个 G 的占地面积了, 但是 go 编译的二进制文件顶多才几十 M 才对鸭, 肯定是有一些不必要的占用, 那么接下来我们进入容器看看主要的空间占用集中在哪些位置

```bash
$ docker run -it --rm micro:v1.01 /bin/sh
# 因为 busybox 的 du 命令版本较低, 这里使用 ncdu
/  apk add ncdu
```

然后我们可以观察到 大小主要集中在

* /root/go/src  471+MB
* /root/go/bin  36+MB   // micro 编译出来二进制文件, 我们所需要的
* /usr/lib      320+MB
* /usr/libexec  66+MB
* ...

简单分析一下, 主要是我们上面 apk 命令安装的 软件 和 lib , 以及 go 编译 micro 所需的 依赖, 而我们编译好的 Micro 二进制文件完全不需要这些也可以运行. 所以我们改造一下上面的 Dockerfile , 将 apk 安装的软件卸载掉, 把 go 和依赖全部删掉, 以缩小镜像体积

```dockerfile
FROM alpine:latest

USER root

# 添加 go 环境变量
RUN echo "export PATH=\$PATH:/root/go/bin" >> /etc/profile \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
    && source /etc/profile

# 安装 micro
RUN apk update && apk add go git musl-dev \
    && cd \
    && go get -u -v github.com/micro/micro \
    && go install github.com/micro/micro \
    && apk del go git musl-dev \
    ; rm /root/go/pkg -rf \
    ; rm /root/go/src -rf \
    ; rm /root/.cache -rf \
    ; rm -rf /var/cache/apk/* /tmp/*

EXPOSE 8080

CMD ["micro", "api"]
```

我们构建看看效果.

```bash
$ docker build . --tag=micro:v1.02
# 查看镜像大小
$ docker image ls | grep micro
micro    v1.02    03e65f4ba3ed    8 seconds ago    44.1MB
```

好的, 这次的优化效果显著 , 构建后的镜像大小 `44.1MB`, 仅为原来的 % ! 第一阶段工作完成!

这里有个小插曲, 第一次优化的时候犯傻 X.... 我把 dockerfile 写成了这样...

```dockerfile
FROM alpine:latest

USER root

## 安装 软件环境
RUN apk update && apk add go git musl-dev

# 添加 go 环境变量 并 安装 micro
RUN echo "export PATH=\$PATH:/root/go/bin" >> /etc/profile \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
    && source /etc/profile \
    && go get -u -v github.com/micro/micro \
    && go install github.com/micro/micro \

# 删除不必要的东西
RUN cd \
    &&
    && apk del go git musl-dev \
    ; rm /root/go/pkg -rf \
    ; rm /root/go/src -rf \
    ; rm /root/.cache -rf \
    ; rm -rf /var/cache/apk/* /tmp/*

EXPOSE 8080

CMD ["micro", "api"]
```

咋眼一看可能感觉没啥问题, 逻辑清晰明了, 但是构建之后, 镜像体积完全没有缩小, 那么问题出现在呢?

问题就出现在这清晰明了上 :joy:, 由如下两个原因组合而成:

1. Docker 使用 aufs, 也就是联合文件系统
1. Dockerfile 中, 一个 命令 即为一层

那么也就是说, 在这个 Dockerfile 中, 我们妄图在下面的层删除上面的层的东西, 这样当然是删不到的: joy:

## 第二个尝试 (采用多阶段构建)

上一阶段中, 我们将大小 镜像的大小控制到 44+MB , 效果不错. 但是有个很不优雅的问题, 也很麻烦. 就是我们每次构建镜像都要这样子手动删除, 而且还得写到一坨么.

答案是 ` 否定 ` 的.

在 `Docker 17.05` 版本之后, 支持 ` 多阶段构建 (multistage builds)`, 容器仅仅保存最后一个阶段构建的内容, 我们在前面的阶段可以随便写, 安装十个软件写十一个 `Run apk add foo` 都行: joy:(开玩笑的). 那么我们就把 Dockerfile 改造成了这样.

```dockerfile
FROM alpine:latest

USER root

# 添加 go 环境变量 和 alpine 镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
    && source /etc/profile

# 安装 micro
RUN apk update && apk add go git musl-dev xz binutils \
    && cd \
    && go get -u -v github.com/micro/micro \
    && go install github.com/micro/micro


#1 ----------------------------
FROM alpine:latest

COPY --from=0 /root/go/bin/micro /usr/local/bin/

EXPOSE 8080

CMD ["micro", "api"]
```

让我们构建镜像验证一下

```bash
$ docker build . --tag=micro:v1.03
# 查看镜像大小
$ docker image ls | grep micro
micro    v1.03    8529f0d7aaca    7 seconds ago    43.7MB
```

我们看到, 容器体积和前面差不多, 甚至更小了. 基本达到我们的预期, 但是还有没有办法变得更小呢, 当然是有的!!!!

以下方法针对 Go 这种编译型语言, PHP/Python 这种动态语言可能需要用其他思路.

## 第三个尝试 (缩小二进制文件体积)

经过 Google 的检索, 我们知道了 `strip` 和 `upx` 两种工具.

这里简单介绍一下 strip 和 upx

strip 通过删除可执行文件中 ELF 头的 typchk 段、符号表、字符串表、行号信息、调试段、注解段、重定位信息等来实现缩减程序体积的目的。简而言之, 你可以直译理解成给程序脱衣服...

UPX 本来是一个 BIN 文件加壳器, 但是他有一种 叫做 UCL 的压缩算法, 可以进一步减小体积, 运行时先在内存中解压, 对性能影响非常小 (副作用是 会增加程序的启动时间, 建议谨慎使用)

我们接下来把 strip + upx 应用到我们的  Dockerfile 中.

```dockerfile
FROM alpine:latest

USER root

# 添加 go 环境变量 和 alpine 镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && echo "export GO111MODULE=on" >> /etc/profile \
    && echo "export GOPATH=/root/go" >> /etc/profile \
    && echo "export GOPROXY=https://mirrors.aliyun.com/goproxy/" >> /etc/profile \
    && source /etc/profile

# 安装 micro
RUN apk update && apk add go git musl-dev xz binutils \
    && cd \
    && go get -u -v github.com/micro/micro \
    && go install github.com/micro/micro

# 压缩 和 加壳
RUN wget https://github.com/upx/upx/releases/download/v3.95/upx-3.95-amd64_linux.tar.xz \
    && xz -d upx-3.95-amd64_linux.tar.xz \
    && tar -xvf upx-3.95-amd64_linux.tar \
    && cd upx-3.95-amd64_linux \
    && chmod a+x ./upx \
    && mv ./upx /usr/local/bin/ \
    && cd /root/go/bin \
    && strip --strip-unneeded micro \
    && upx micro \
    && chmod a+x ./micro \
    && cp micro /usr/local/bin

#1 ----------------------------
FROM alpine:latest

COPY --from=0 /usr/local/bin/micro /usr/local/bin/

EXPOSE 8080

CMD ["micro", "api"]

```

让我们构建镜像看看效果

```bash
$ docker build . --tag=micro:v1.04
# 查看镜像大小
$ docker image ls | grep micro
micro    v1.04    1d22ac38352c    5 seconds ago    14.2MB
```

镜像的体积进一步下降到 14.2 MB, 让我们进入 容器看看 编译出来的 micro 二进制文件大小,

```bash
$ docker run -it --rm micro:v1.04 /bin/sh
/ ls -hal /usr/local/bin/micro
-rwxr-xr-x    1 root     root        8.2M Aug 12 07:59 micro
```

缩小到了 8.2M, 那么让我们算一下, 还有那些多余的体积.

使用 docker image 命令看看我们的基础镜像 Alpine 的大小

```bash
$ docker image ls | grep alpine
alpine                                                   latest              b7b28af77ffe        5 weeks ago         5.58MB
```

`8.2 + 5.58 = 13.78 MB` , 也就是 还有 `14.2 - 13.78 = 0.42 MB` 的多余占用, 我们已经基本接近极致. 优化工作可以到此基本告一段落.


## 后记 - 未了的事

到目前为止, 我们将容器镜像体积从一开始的 948MB 降到 14+MB, 减少了将近 98.5% :joy: 的镜像体积, 可喜可贺!

但是我们也看到还有 0.42MB 的多余占用等待着我们去优化, 可能是 计算错误 或者是对 Docker 的 多阶段构建以及 aufs 的理解不够到位, 导致认为有多余的占用空间, 这便是未了的事.

(我也想像 Docker 镜像一样，瘦的这么快鸭:joy:)
