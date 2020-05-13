# Go-callvis Guide

## What's

// TODO

## Install

```shell
$ go get -u github.com/ofabry/go-callvis
# or
$ git clone https://github.com/ofabry/go-callvis.git
$ cd go-callvis && make install
```

## Use

### Options

因为该工具的参数有点复杂, 笔者第一次看例子中的参数的时候是完全无法理解的状态, 所以为了能够熟练使用这个工具, 所以这里这里先对一些参数进行简单的描述和介绍.

* `-focus string`
  *  聚焦于具体的包或者 import Path 上 (default "main")
* `-group string`
  * 使用 `包(pkg)` 或者 `类型(type)` 进行聚合, 以逗号分隔, 可以同时使用 pkg 和 type, 详情请参阅例子 
* `-ignore string`
  * 排除一些包, 包路径之间 使用 逗号分隔 ,
  * example: ignore: github.com/A/B/config,github.com/A/B/pkg/config 
* `-include string`
  * 引入具有指定前缀的包, 使用逗号分隔
* `-limit string`
  * 将包的路径限制为给定前缀, 使用逗号分隔
* `-minlen uint`
  * 最小边长(用于更宽的输出)( default 2)
* `-nodesep float`
  * 最小节点间距, 同一等级中两个节点之间的最小间距( default 0.35)
* `-nointer`
  * bool, 忽略对未导出函数的调用
* `-nostd`
  * bool , 忽略对标准库的引用
* `-tags []string`
  * go build tags 
* `-tests`
  * bool, 引入测试代码
* `-file`
  * output filename 
* `-format`
  * 输出文件格式, `[svg | png | jpg ]` (default svg)
* `-debug`
  * 输出大量日志

### Example

之后的例子都将主要以 `github.com/Kuri-su/confSyncer` 这个包作为例子, 使用这个项目作为 演示的原因有二.

一是这个项目比较小, 在使用 `go-callvis` 时候不会有很大的性能负担, 另外它也有一个简单的结构来提供演示.

二是给这个项目打个广告 ; )

接下来,首先进行准备工作, 安装 `go-callvis`,并拉取该项目

```shell
$ cd /tmp
# install go-callvis
# 在 go get 的时候, go-callvis 会被编译到 $GOPATH/bin 下. 需要将该目录加入 PATH 中
$ go get -u github.com/ofabry/go-callvis
# clone repo
$ git clone git@github.com:Kuri-su/confSyncer.git
# 由于 go-callvis 当前(2020-05) 的实现必须从 main 包开始
# (无法从 Tests测试用例等的其他位置开始 ),所以我们这里先来到 main 包所在的位置 
$ cd confSyncer/cmd/confsyncer
```

#### basic

```shell
$ go-callvis . # 注意这后面还有一个. ,表示当前目录
```

// TODO  Image

#### focus

```shell
$ go-callvis \ 
  -focus pkg/unit . 
  # 这个参数的用处主要是 集中在 选定的这个包上, 对于其他的包的输出会减少, 
  # 我们可以对比此处的输出和上面 basic 的输出
```

// TODO Image

#### group

```shell
$ go-callvis \
  -group pkg,type . 
  # 这个参数主要是针对 pkg 和 type 进行聚合, 大多数情况下是标配变量, 使用时都会带                     #上 , 具体可以和 上面 Baisc 例子的输出惊醒对比.
```

// TODO Image

#### nostd

```shell
$ go-callvis \
  -nostd . 
  # 这个参数也是一个常用的参数, 使用这个参数后将在输出的 图片中展示对 Golang 标准库的调用
```

// TODO Image

#### ignore

```shell
$ go-callvis \
  -focus pkg/unit \
  -ignore github.com/fatih/color . 
  # ignore 参数有时也会和 focus 参数搭配使用, 
  # foucus 是将目光聚焦到一个单独的子包上, 
  # 但有时仍然会不想让一些包出现在输出的图片中,
  # (例如这里的 color 包,这个包只是负责渲染 terminal 中的
  # 文字颜色, 我们根本不关心它是否有被调用) 这时,
  # 我们就可以使用 ignore 参数将其屏蔽掉
```

// TODO Image

#### minlen && nodesep

```shell
$ go-callvis \
  -minlen 3  \
  -nodesep 1 . 
  # 在观察复杂包结构的时候, 这两个参数会比较有用, 
  # 当我们观察复杂包结构的时候, 调用的线条和主体的数量会急剧上升, 
  # 这样会导致图片中线条扭在一起, 极度的难以观察, 所以你可以使用这两个参数, 
  # 所以你可以使用这两个参数将被调用者之间的间隔加大, 让线条散开
  #
  # 另外, 通常遇到上述情况会搭配 focus 和 ignore 参数进行使用.
```

// TODO Image

### Other Example

在了解完上述参数之后, 我们就可以来回头来看 `go-callvis 作者` 在 `readme.md` 中书写的例子了

~~(虽然我好像一个都没跑通[2020-05] :joy:)~~

#### Projects
- [Syncthing](https://github.com/syncthing/syncthing)
- [Docker](https://github.com/docker/docker)
- [Travis CI Worker](https://github.com/travis-ci/worker)


#### Syncthing

[![syncthing example](../images/syncthing.png)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/syncthing.png)

```shell
$ go get -u github.com/syncthing/syncthing/
$ cd $GOPATH/src/github.com/syncthing/syncthing

# Syncthing needs a special build process, so don't forget to call build.sh
$ ./build.sh
```

```shell
# Generate graph and launch webserver
$ go-callvis \ 
    -focus upgrade \
    -group pkg,type \
    -limit github.com/syncthing/syncthing \
    -ignore github.com/syncthing/syncthing/lib/logger \
    github.com/syncthing/syncthing/cmd/syncthing
```

[![syncthing example output](../images/syncthing_focus.png)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/syncthing_focus.png)

```shell
# Focusing package upgrade
$ go-callvis \
    -format=png \
    -file=syncthing_focus \
    -focus upgrade \
    -limit github.com/syncthing/syncthing \
    github.com/syncthing/syncthing/cmd/syncthing
```

[![syncthing example output pkg](../images/syncthing_group.png)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/syncthing_group.png)

```sh
# Generate graph focused on module 'upgrade', output to PNG file
$ go-callvis \
    -format=png \
    -file=syncthing_group \
    -focus upgrade \
    -group pkg \
    -limit github.com/syncthing/syncthing \
    github.com/syncthing/syncthing/cmd/syncthing
```

[![syncthing example output ignore](../images/syncthing_ignore.png)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/syncthing_ignore.png)

```sh
# Generate graph focused on module 'upgrade' and ignoring 'logger', output to webserver
$ go-callvis \
    -focus upgrade \
    -group pkg \
    -ignore github.com/syncthing/syncthing/lib/logger \
    -limit github.com/syncthing/syncthing \
    github.com/syncthing/syncthing/cmd/syncthing
```
#### Docker

[![docker example](../images/docker.png)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/docker.png)

```shell
$ go-callvis \
    -format=png \
    -file=docker \
    -limit github.com/docker/docker \
    -ignore github.com/docker/docker/vendor \
    github.com/docker/docker/cmd/docker | dot -Tpng -o docker.png
```
#### Travis CI Worker

[![travis-example](../images/travis_thumb.jpg)](https://raw.githubusercontent.com/ofabry/go-callvis/master/images/travis.jpg)

```shell
$ go-callvis \
    -format=svg \
    -file=travis \
    -minlen 3 \
    -nostd -group type,pkg \
    -focus worker \
    -limit github.com/travis-ci/worker \
    -ignore github.com/travis-ci/worker/vendor \
    github.com/travis-ci/worker/cmd/travis-worker && exo-open travis.svg
```

## 缺陷 (当下 2020-5)

// TODO