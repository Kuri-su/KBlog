+++
date = "2019-03-14"
title = "Ubuntu 18.04 vbox /sbin/vboxconfig 无法启动虚拟机问题"
slug = "waitforupdate-dw5jm"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++


Ubuntu 18.04 启动虚拟机,类似于提示 `Please reinstall the kernel module by executing '/sbin/vboxconfig' as root.`

重装 `dkms` balabala 什么的都尝试过了,都不太行

最后在 `stackoverflow` 上看到可能通过关闭 `BIOS` 中的 `Secure Boot` 解决这个问题

问题解决