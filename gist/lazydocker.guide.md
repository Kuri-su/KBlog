
# LazyDocker

https://github.com/jesseduffield/lazydocker

一款用于 Docker 和 Docker-compose 的 client dashboard , 基于 `gocui` 编写

![](https://github.com/jesseduffield/lazydocker/raw/master/docs/resources/demo3.gif)

## Install
**Mac**
```shell
$ brew install jesseduffield/lazydocker/lazydocker
```

**Arch**
```shell
$ git clone https://aur.archlinux.org/lazydocker.git ~/lazydocker
$ cd ~/lazydocker
$ makepkg --install
```

**Golang**
```shell
$ go get github.com/jesseduffield/lazydocker
```

**Bin**

前往 [release page](https://github.com/jesseduffield/lazydocker/releases) 下载对应平台的可执行文件, 例如 `AMD64`

## What's

LazyDocker 是一款 Docker Client Dashboard , 正如它的名字所讲, 这个工具的初衷是 用简单的 点击 和 UI控制等功能来替代 管理 Docker 容器的复杂的 命令行操作  . LazyDocker 也做到了这点, 

它支持 对 Containers 和 Images 以及 Volumes 来进行操作, 你可以使用鼠标或者键盘 来选择想要查看的目标 , 除了可以查看他们的 Config 外, 对于 Container 类型的目标, 还可以查看 Logs 和 Stats 以及 进程列表(top), 除此之外, 按`x` 键, 可以呼出 Menu, 来对 目标进行操作, 例如 对Containers 进行 delete 或者 restart  .

## How

操作也很简单

* `PgUp/PgDn` : 滚动屏幕, 通常用于查看 logs 或者 Config 
* `b`  打开批量管理选项, 目前只有三个
  * 停止全部容器
  * 删除全部容器
  * 删除 exited 状态的容器
* `esc/q` 退出
* `x` 打开 menu
* `方向键` 切换修改对象 以及 类别