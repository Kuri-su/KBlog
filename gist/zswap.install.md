+++
date = "2020-08-20"
title = "zswap install"
slug = "zswap-install-2zs4z"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

## Ubuntu
```shell
# 在 GRUB_CMDLINE_LINUX_DEFAULT 的内容里添加 zswap.enabled=1
$ vi /etc/default/grub
# before
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash "
# after
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash zswap.enabled=1"
# ------
$ sudo update-grub
```

最后重启即可

## Manjore || Arch

一般默认开启, 如果没有可以使用下面命令开启

```shell
$ sudo pacman -S systemd-swap --noconfirm
$ sudo systemctl enable systemd-swap
$ sudo systemctl start systemd-swap
$ cat /sys/module/zswap/parameters/enabled
Y
```


