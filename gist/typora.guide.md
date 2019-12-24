
## Install

### Mac

直接下载此 dmg 即可 <https://www.typora.io/download/Typora.dmg>

### Windows

直接下载 exe 即可

* x64
	* <https://www.typora.io/windows/typora-setup-x64.exe>
* x32
	* <https://www.typora.io/windows/typora-setup-ia32.exe>

### Linux

**Ubuntu**

```shell
# or run:
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
wget -qO - https://typora.io/linux/public-key.asc | sudo apt-key add -
# add Typora's repository
sudo add-apt-repository 'deb https://typora.io/linux ./'
sudo apt-get update
# install typora
sudo apt-get install typora
```

**Arch**
```shell
$ sudo pacman -S typora
```

**Other**

download tar package
```shell
$ wget https://typora.io/linux/Typora-linux-x64.tar.gz
$ tar -zxvf Typora-linux-x64.tar.gz
$ cd Typora-linux-x64 && ln -s ./Typora /usr/local/bin/Typora
```

## What && How

在遇到 `typora` 之前, 一直使用 vscode 上的 `Markdown Preview Enhanced` 插件, 搭配 `why not add a space between Chinese and English` 脚本, 已经基本满足需求, 但因为 `Markdown Preview Enhanced` 始终只是预览插件, 再加上偶尔的 Preview 与 Editor 的不同步, 导致时不时有些硌手.

然后在尝试 typora 之后, 这个应该就是我想要的东西. 

1. typora 的整个界面给人的感觉很简洁, 使用时注意力相当 focus, 
2. typora 支持所见即所得的书写方式, 但它并不是那种白痴式的所见即所得, 例如输入光标在图片附近时, 他会显示处图片的原始地址, 例如这样 `![foo](http://foo.image.com/1.png)` , 并且在 title 附近时, 会显示出当前标题的等级, 例如 h4 , 这种处于所见即所得的模式但也有一些源文件编辑感的特性, 在用的时候感觉非常清晰. 另外 typora 也支持 切换到源代码编辑模式.
3. typora 可以将 `files`(文件列表) 切换成 outline(大纲) 用于显示 文章的标题和层级, 这个简直是用这一帮 Markdown 编辑器写文章时候的极度痛点, 有的编辑器不支持 `[TOC]` 标签, 又有一些编辑器例如 IDEA, 我得打开 Alt+7 来查看 标题层级, 这个将 files list 切换成 outline 的方式, 实在是深得我心 XD 

虽然 空格方面依旧需要依赖 vscode 上的 `why not add a space between Chinese and English` 脚本. 

最后, 对 Typora 无数语言的描述在实际上手之前都会显得十分苍白. 由于 typora 的安装十分简单, 并且有 PC 三平台支持, 强烈建议有空的朋友可以上手体验一番!