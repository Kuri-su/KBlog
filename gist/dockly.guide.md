
# Dockly

## Install

### npm

```shell
$ sudo npm install -g dockly
```

## What

一个可以用于终端操作的 Docker Dashboard, 使用 Node.js 编写, 可以完成基本的 container 管理工作, 例如

* 启动 / 暂停 / 删除 容器
* exec 到容器中
* 查看容器日志

对容器做基本的管理, 如果需求不多的话可以考虑 `Dockly`, 毕竟安装也方便

## How

![](https://cloud.githubusercontent.com/assets/316371/25682867/c5212216-3027-11e7-8f36-72d38516d2af.gif)

然后这个是 dockly 的演示,  左边是 container list, 右边是~~意义不明的~~ 图表指示, 然后下方是  container 的标准输出显示.

在 `dockly` 中的快捷键比较少, 很容易使用

* `=` 用于刷新页面
* `i` 显示选中容器的Info, 等价于 `docker inspect`指令
* `enter` 会将该容器的 log 显示在 下方的 container Log 框中
* `l` exec 进入选中容器
* `r` 重启容器
* `s` 暂停容器
* `m` 弹出用于批量 stop 和 remove 的菜单 , 有如下选项可供选择
  * 暂停全部容器
  * 删除所选容器
  * 删除全部容器
  * 删除全部镜像
* `/` 对容器列表做一个过滤 
* `q` 退出 dockly

>  ps: exec 到容器的功能其实不是很好用...不过纵向比较下, 别的工具也没做的很好用, 所以还是推荐 直接 `docker exec` 以进入容器

虽然 `Dockly` 的功能不多, 不过如果你的需求只是基本够用就行, 那么 Dockly 其实也是不错的工具, 比如笔者也是用了很长一段时间的 dockly, 后面渐渐管理需求增多, 才切换到其他工具, 如果对其他工具有兴趣, 可以查看这篇文章 [//TODO]() 