# Manual installation of K8s experience

> 从编译到部署, 再到源码阅读.

[TOC]

## 背景

 平时部署 K8s 方式基本都屏蔽了太多细节, `Kubeadm` / `XKE(RKE, QKE, )`, 或者`直接使用云服务厂商 的托管服务`. 然后日前需要定位一个调度器 调度不均的问题, 感觉无从下手.......遂开始希望从手动安装 到 阅读源码, 逐步抽丝剥茧来调试.

## 目标

手动在 九个 Docker 容器中, 搭建一个如下集群

* etcd worker * 4
* k8s  master node * 2 (主备)
* k8s worker node * 3 

## 编译

### 编译 Kubernetes 组件

主要的可运行组件都在 Kubernetes repo 下, 首先 拉取代码

```shell
$ git clone git@github.com:kubernetes/kubernetes.git 
```

基本所有的代码入口都在 cmd 下, 不过先不急看代码, 先编译, kubernetes 默认使用 makefile 来组织编译命令,  在 repo 的根目录 下执行编译命令

```shell
$ make 
# or
$ make all

# 如果想使用容器环境进行编译, 可以使用如下
$ make release # 会交叉编译所有平台, 并执行单元测试, 会比较久
# or
$ make quick-release # 仅仅编译当前平台, 并略过单元测试.
```

编译完成后, 你可以在 kubernetes repo 的 `_output/bin` 目录下看到所有编译出来的内容

```shell
$ ll -s
total 1889584
     4 drwxrwxr-x 2 kurisu kurisu      4096 Sep 21 12:28 ./
     4 drwxrwxr-x 3 kurisu kurisu      4096 Sep 21 12:23 ../
 63452 -rwxr-xr-x 1 kurisu kurisu  64974848 Sep 21 12:28 apiextensions-apiserver*
  7824 -rwxr-xr-x 1 kurisu kurisu   8011776 Sep 21 12:24 conversion-gen*
  7460 -rwxr-xr-x 1 kurisu kurisu   7639040 Sep 21 12:23 deepcopy-gen*
  7468 -rwxr-xr-x 1 kurisu kurisu   7647232 Sep 21 12:23 defaulter-gen*
139392 -rwxr-xr-x 1 kurisu kurisu 142734472 Sep 21 12:28 e2e_node.test*
160136 -rwxr-xr-x 1 kurisu kurisu 163978632 Sep 21 12:28 e2e.test*
 65880 -rwxr-xr-x 1 kurisu kurisu  67460272 Sep 21 12:28 gendocs*
238524 -rwxr-xr-x 1 kurisu kurisu 244245456 Sep 21 12:28 genkubedocs*
247028 -rwxr-xr-x 1 kurisu kurisu 252953936 Sep 21 12:28 genman*
  4728 -rwxr-xr-x 1 kurisu kurisu   4841472 Sep 21 12:28 genswaggertypedocs*
 65864 -rwxr-xr-x 1 kurisu kurisu  67443504 Sep 21 12:28 genyaml*
  8716 -rwxr-xr-x 1 kurisu kurisu   8925184 Sep 21 12:28 ginkgo*
  3300 -rwxrwxr-x 1 kurisu kurisu   3375959 Sep 21 12:23 go2make*
  2096 -rwxr-xr-x 1 kurisu kurisu   2146304 Sep 21 12:28 go-runner*
 43224 -rwxr-xr-x 1 kurisu kurisu  44261376 Sep 21 12:28 kubeadm*
 61364 -rwxr-xr-x 1 kurisu kurisu  62836736 Sep 21 12:28 kube-aggregator*
122168 -rwxr-xr-x 1 kurisu kurisu 125100032 Sep 21 12:28 kube-apiserver*
116340 -rwxr-xr-x 1 kurisu kurisu 119132160 Sep 21 12:28 kube-controller-manager*
 44512 -rwxr-xr-x 1 kurisu kurisu  45580288 Sep 21 12:28 kubectl*
 62516 -rwxr-xr-x 1 kurisu kurisu  64016240 Sep 21 12:28 kubectl-convert*
153852 -rwxr-xr-x 1 kurisu kurisu 157542976 Sep 21 12:28 kubelet*
150552 -rwxr-xr-x 1 kurisu kurisu 154164224 Sep 21 12:28 kubemark*
 41408 -rwxr-xr-x 1 kurisu kurisu  42401792 Sep 21 12:28 kube-proxy*
 46952 -rwxr-xr-x 1 kurisu kurisu  48078848 Sep 21 12:28 kube-scheduler*
  5644 -rwxr-xr-x 1 kurisu kurisu   5779456 Sep 21 12:28 linkcheck*
  1728 -rwxr-xr-x 1 kurisu kurisu   1769472 Sep 21 12:28 mounter*
 10016 -rwxr-xr-x 1 kurisu kurisu  10256384 Sep 21 12:24 openapi-gen*
  7432 -rwxr-xr-x 1 kurisu kurisu   7610368 Sep 21 12:23 prerelease-lifecycle-gen*
```

里面除了如下 Kuberentes 核心组件外,

* kube-apiserver
* Kube-controller-manager
* kubelet
* kubectl
* kube-scheduler
* kube-proxy

还包括如下 若干代码生成器

* conversion-gen (自动生成 Convert 函数, 用于 资源对象的 版本转换函数)
* deepcopy-gen (自动生成 DeepCopy 函数, 用于 资源对象的 深拷贝)
* defaulter-gen (自动生成 资源对象的默认值函数)
* go-bindata (自动将资源文件嵌入 go 代码中, 类似于 go 1.16 中的 embed 特性) 
* Openapi-gen (自动生成 OpenAPI 文件的生成器)
* ...

以 deepcopy-gen 为例, 每个代码文件中会使用 go 的 tag 来表明该文件中的所有 Struct 都需要生成 深拷贝方法.

```go
// +k8s:deepcopy-gen=true
```

他们都是基于 k8s.io/gengo pakcage 实现的,  gengo 也是使用 go 标准库的 go/ast 包来对 每个文件进行分析, 然后进行生成代码. 这里的逻辑和大部分生成的工具实现方法类似.

### 编译 etcd

拉取源代码

```shell
$ git clone git@github.com:etcd-io/etcd.git
$ make build # 编译
```

编译完成后在 etcd 根目录的 bin 文件夹下可以看到三个文件

```shell
$ ll
total 73M
-rwxrwxr-x 1 kurisu kurisu 31M Sep 21 12:58 etcd
-rwxrwxr-x 1 kurisu kurisu 24M Sep 21 12:58 etcdctl
-rwxrwxr-x 1 kurisu kurisu 20M Sep 21 12:58 etcdutl
```

## 启动实验环境

这里我们用三个 Docker Container 作为实验环境, 实验镜像为 `kurisux/ubuntu-sshd-ex:18.04`

```shell
$ docker pull kurisux/ubuntu-sshd-ex:18.04
$ docker run -d  --name=knode-0 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-1 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-2 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-3 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-4 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-5 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-6 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-7 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-8 kurisux/ubuntu-sshd-ex:18.04; \
 docker run -d  --name=knode-9 kurisux/ubuntu-sshd-ex:18.04
```

使用 docker-compose 启动实验环境

```yaml
// TODO
```

// TODO

## 准备配置文件

主要都是一些 systemd 的 config, 里面要关注的点主要是启动命令的参数

### k8s

// TODO

#### master 主备

### etcd

## 启动 

### etcd

### k8s

## 安装 k8s 网络组件

### cilium



