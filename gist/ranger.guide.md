+++
date = "2019-12-08"
title = "Ranger"
slug = "ranger-74auz"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

![](https://camo.githubusercontent.com/92ea356bac374f6c662f3046cf061c501a049cf9/68747470733a2f2f72616e6765722e6769746875622e696f2f72616e6765725f6c6f676f2e706e67)

## Install

```shell
# Ubuntu / Debian
$ sudo apt install ranger -y
# Centos/ RHEL
$ sudo yum install ranger -y
# Arch/Manjaro
$ sudo pacman -S ranger --noconfirm
```

安装之后建议 使用如下命令 `初始化配置文件`

```shell
$ ranger --copy-config=all
```

初始化 配置后, 你将在 `~/.config/ranger` 中找到各种配置.

## What

`ranger` 是一个在 Terminal 中使用的文件管理器，以 Python 编写。不同层级的目录分别在一个面板的三列中进行展示. 可以通过快捷键, 书签, 鼠标以及历史命令在它们之间移动. 当选中文件或目录时, 会自动显示文件或目录的内容.

![](https://raw.githubusercontent.com/ranger/ranger-assets/master/screenshots/screenshot.png)

ranger 的主要特性有

1. Vi 风格的快捷键
1. 书签
1. 选择
1. 标签
1. 选项卡
1. 命令历史
1. 创建 `符号链接` 的能力
1. 多种终端模式
1. 任务视图
1. 可定制的命令和快捷键

和 ranger 相似的工具还有

* [vifm](https://github.com/vifm/vifm)
  ![](https://github.com/vifm/vifm/raw/master/data/graphics/screenshot.png)
* [Midnight Commander(mc)](https://github.com/MidnightCommander/mc)
  ![](https://www.linode.com/docs/tools-reference/tools/how-to-install-midnight-commander/midnight-commander-full-screen.png)

如有兴趣可以自行了解

## How

### 快捷键

ranger 的快捷键有很多, 大部分你都可以在 `~/.config/ranger/rc.conf` 中找到, 如下便是摘自 [Mike的分享空间](http://www.mikewootc.com/wiki/linux/usage/ranger_file_manager.html) 以及笔者对部分预设常用快捷键的罗列, 如果有兴趣, 你也可以自行查看并添加快捷键.例如 zsh 下的常用插件 `z`, 以及 `DD` 直接删除文件

(注: 虽然当按下类似与 d 的时候, ranger 会列出很多快捷键, 但是实际上他们的相同点只有快捷键同只有 d 开头而已)

#### 基本功能

> `?` 查看帮助
>
> `q` 和 `ZZ` 和 `ZQ` 都是 退出的意思, 同样你也可以使用 C-c(ctrl+c) 的方式退出
>
> `:` 和 `;` 和 `!` 和 `@` 和 `#`  都可以呼出 Vim 风格的命令输入, 具体的命令可以在输入 ? 后继续输入 c 查看 commands
>
> `f` 直接进入搜索模式, 在当前文件夹下搜索
>
> `:mkdir foo` 新建文件夹

#### 修改行模式显示

> `Mf` 显示 `文件的名字`/`大小`
>
> `Mi` 显示 `文件的名字`/`文件的类型`
>
> `Mm` 显示 `文件的名字`/`文件的修改事件(modify)`
>
> `Mp` 显示 `文件的权限`/`文件所属用户` / `文件所属组` / `文件名字`
>
> `Ms` 显示 `文件的名字`/`文件的大小`/`文件的修改事件`
>
> `Mt` 和 Mf 类似

详细示例如下所示, 下面以 /etc 文件夹下的部分文件为例

**Mf**

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ranger/ranger-mf.png)

**Mi**

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ranger/ranger-mi.png)

**Mm**

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ranger/ranger-mm.png)

**Mp**

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ranger/ranger-mp.png)

**Ms**

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ranger/ranger-ms.png)

#### 浏览


> `gg`  跳到顶端
>
> `G`   跳到底端
>
> `C-f` 上一页
>
> `C-b` 下一页
>
> `C-d` 和 `J`  上半页
>
> `C-u` 和 `K`  下半页
>
> `gh` alias cd ~
>
> `ge` alias cd /etc
>
> `gu` alias cd /usr
>
> `gd` alias cd /dev
>
> `gl` alias cd -r .
>
> `gL` alias cd -r %f
>
> `go` alias cd /opt
>
> `gv` alias cd /var
>
> `gm` alias cd /media
>
> `gM` alias cd /mnt
>
> `gs` alias cd /srv
>
> `gp` alias cd /tmp
>
> `gr` & `g/` alias cd /
>
#### 文件系统操作

> `E` 呼出系统默认编辑器进行编辑
>
> `du` 对当前文件夹下进行 du 操作查看大小
>
> `dU` 在 du 的基础上会对大小进行排序
>
>
>
> `<space>` (空格键) 选择文件
>
> `yy` 复制文件
>
> `uy` 取消复制
>
> `dd` 剪切文件
>
> `ud` 取消剪切
>
> `dD` 删除文件
>
> `pp` 复制文件
>
> `pL` 创建软链, 指向被复制文件的绝对路径
>
> `pl` 和 pL 类似, 但是 pl 创建的是 相对路径
>
> `phl` 创建硬链接
>
> `cw` 重命名
>
> `A` 在当前名称基础上重命名
>
> `I` 类似于 `A`, 但是光标会调到起始位置

#### 书签

> `m` 新建书签
>
> `\`` 打开书签
>
> `um` 删除书签

#### 标签

(类似于 多窗口 或 者多工作区)

> `C-n` 和 `gn` 都可以创建标签, 或者叫工作区
>
> `C-w` 和 `gc` 都可以关闭标签
>
> `<TAB>` 正序切换标签
>
> `<S+TAB>` 也就是 shift + TAB, 逆序切换标签
>
> `a-<num>` 也就是 alt + num 键, 例如 alt+1 标示切换到第一个工作区

#### 排序

> `on`/`ob`   根据文件名进行排序(natural/basename)
>
> `oc`      根据改变时间进行排序 (Change Time 文件的权限组别和文件自身数据被修改的时间)
>
> `os`      根据文件大小进行排序(Size)
>
> `ot`      根据后缀名进行排序 (Type)
>
> `oa`      根据访问时间进行排序 (Access Time 访问文件自身数据的时间)
>
> `om`      根据修改进行排序 (Modify time 文件自身内容被修改的时间)
>
#### 其他

> `C-h` 和 `zh` 显示隐藏文件(也就是. 和其他符号开头的文件)
>
> `zp` 打开/关闭 文件预览功能
>
> `zP` 打开目录预览功能
>
> `zm` 打开/关闭 鼠标可用
>
> `zf` 过滤文件名
>
> `S` 在当前文件夹下打开 Terminal
>
> `z(*)` 改变设置, * 代表在弹出的选项中的选择
>
> `o(*)` 改变排序方式
>
> `!` 和 `s` 弹出使用 shell 指令的console
>
> `:` 弹出使用 ranger 的命令的console
>
> `:set colorscheme xxx` 标示设置ranger 的主题, 内置四种主题 : `default`, `jungle`, `snow` and `solarized`, 不过改不改差别不大, 社区里可能有一些优秀的魔改主体

### 定制

#### 增加快捷键

在 `~/.config/ranger/rc.conf` 中照猫画虎即可, 例如要加一个  DD 的快捷键用于删除

```bash
# 在末尾加上这一句即可
map DD delete
```

#### 增加自定义命令

在 `~/.config/ranger/commands.py` 文件中, 添加自定义的代码和方法, 即可添加功能, 如果你不熟悉 Python 的写法, 你也可以利用 Python 去调 Shell 脚本或者其他二进制程序包从而完成自定义


ref:

> [linux终端文件管理器ranger使用详解-Mike的分享空间](http://www.mikewootc.com/wiki/linux/usage/ranger_file_manager.html)
>
> [archlinux.org](https://wiki.archlinux.org/index.php/Ranger_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))
>
> [ranger/ranger](https://github.com/ranger/ranger)