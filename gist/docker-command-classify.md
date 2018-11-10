# Docker Command Classify

梳理和记录 docker 的命令和 Dockerfile 的关键字

## Dockerfile

大部分指令都有两种格式
* shell 格式 : CMD <命令>
* exec 格式 : CMD ["可执行文件","参数1","参数2"]


### FROM
指定基础镜像
eg:
```Dockerfile
FROM nginx
```

### RUN
执行命令，每执行一次即为一层

```Dockerfile
RUN apt update
    && apt install -y gcc make libc6-dev
    && ...
```

### COPY
将构建的指定位置的相对路径的文件复制到容器中
```Dockerfile
COPY composer.json .
# 改变文件所属用户和组
COPY --chown=10:11  hello.sh /var/www/
```

### ADD
在 COPY 的基础上添加了复制 URL 的功能，同时如果为 `tar` 的压缩文件的话，压缩格式是 `gzip`,`bzip2`,`xz` 的情况下，ADD 会自动解压到指定的目录中去。
```Dockerfile
ADD ubuntu-xenial-core-cloudimg-amd64-root.tar.gz /
# 改变文件所属用户和组
ADD --chown=10:11 hello.sh /var/www
```

### CMD
RUN 和 CMD 的区别
* RUN 执行命令并创建新的镜像层，RUN 经常用于安装软件包
* CMD 设置容器启动后默认执行的命令及其参数，但 CMD 能够被 docker run 后面跟的命令行参数替换。

CMD 使用 shell 格式时，实际命令会包装为 sh -c 的参数形式执行
```Dockerfile
CMD echo $HOME
# 实际运行
CMD ["sh","-c","echo $HOME" ]
```
eg:
```Dockerfile
CMD systemctl restart nginx
#实际运行的是
CMD ["sh","-c","systemctl restart nginx"]
#需要将nginx作为前台运行
CMD ["nginx","-g","daemon off;"]
```

### ENTRYPOINT
作用和 CMD 类似，不过在 指定了 ENTRYPOINT 后，
eg:
```Dockerfile
ENTRYPOINT ["curl","-s","http://ip.cn"]
```

### ENV
定义环境变量
eg:
```Dockerfile
ENV NODE_VERSION 7.2.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs
```

### ARG
设置构建环境时的环境变量

### VOLUME
挂载匿名卷
eg:
```Dockerfile
VOLUME /data
```
但是感觉 在 docker run 的 -v 参数中 xxxx:/xx/x 更加方便，而且写在 Dockerfile 中这样容易出问题

### EXPOSE 
声明端口，仅仅只是声明容器打算使用什么端口而已，并不会自动在宿主进行端口映射
eg:
```Dockerfile
EXPOSE 5000,6000
```

### WORKDIR
更改之后每一层的工作位置

### USER
更改之后每一层使用的用户，用户必须预先建好，否则无法切换

在以root运行期间希望切换身份，建议使用 `gosu`
```Dockerfile
# 建立 redis 用户，并使用 gosu 换另一个用户执行命令
RUN groupadd -r redis && useradd -r -g redis redis
# 下载 gosu
RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true
# 设置 CMD，并以另外的用户执行
CMD [ "exec", "gosu", "redis", "redis-server" ]
```

### HEALTHCHECK 
容器健康检查
使用 `HEALTHCHECK [option] <CMD>`中的CMD进行健康检查，0成功，1失败

支持以下三个变量
* --interval=xx **两次健康检查的间隔，默认30秒** 
* --timeout=xx **健康检查超时时间，默认30秒**
* --retries=xx **连续失败xx次后，将容器标记为unhealthy，默认3次**

eg:
```Dockerfile
FROM nginx
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
HEALTHCHECK --interval=5s --timeout=3s  CMD curl -fs http://localhost/ || exit 1
```

### ONBUILD 
当该镜像作为基础镜像时才会执行


## 多阶段构建
**注意from后面的 as**
```Dockerfile
FROM golang:1.9-alpine as builder

RUN apk --no-cache add git

WORKDIR /go/src/github.com/go/helloworld/

RUN go get -d -v github.com/go-sql-driver/mysql

COPY app.go .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest as prod

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=0 /go/src/github.com/go/helloworld/app .

CMD ["./app"]
```