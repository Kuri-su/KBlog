+++
date = "2019-08-18"
title = "在 Ubuntu 终端下, 使用命令打开图形化文件管理"
slug = "ubuntu-urkwn"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

```shell
# 打开文件夹 
nautilus /var

# 打开当前文件夹 
nautilus .

# 打开 $HOME 文件夹
nautilus

# 类似的命令还有:
# 使用 chrome 打开 html文件
google-chrome a.html

# 使用 vs-code 打开文本文件
code a.md
# 使用 vs-code 打开文件夹
code /var

# 大部分的软件都可以使用这样的方式, 问题仅仅只是需要找到相应的命令而已, 这里就不一一列举了
```

Jetbrains 系列软件, 例如 Goland, IDEA, 则需要在 `Tools > Create command-line Launcher` 中设置

最新版本(2019.2)中, 该功能已经挪到 Toolbox 中的 `Generate shell scripts` 开关上. (Jetbrains Toolbox 1.11版本特性)