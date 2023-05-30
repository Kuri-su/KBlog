+++
date = "2019-07-17"
title = "Ubuntu Proxy 设置简略指北"
slug = "ubuntu-proxy-lojdq"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

本文以 Ubuntu 为基础, 分别说明 `Terminal 模式` 和 `图形化界面下的 Chrome/Firefox` , 设置代理的方法

## Terminal 模式

原理是设置 `http_proxy`, `https_proxy` 等的环境变量, 推荐使用如下方法,

```bash
touch ~/enableProxy && tee ~/enableProxy <<-'EOF'
export http_proxy="http://ip:port"
export https_proxy="http://ip:port"
EOF

# 通常设置上面 http_proxy 和 https_proxy 即可
# export ftp_proxy=""
# export socks_proxy=""

# 如果代理的协议使用的是 socks5 协议, 则将协议头改成 socks5 即可, 如下所示:
# export http_proxy="http://ip:port"
# export https_proxy="http://ip:port"


# 然后使用 source 命令 运行该脚本 以 应用这些环境变量
source ~/enableProxy
```

上面的代码的意思就是在 `~/enableProxy` 文件中写入 export 两条指令, 如果你觉得这样分开设置麻烦, 可以直接设置 `ALL_PROXY` 环境变量, 如下所示

```bash
touch ~/enableProxy && tee ~/enableProxy <<-'EOF'
export ALL_PROXY="http://ip:port" # socks5 同理
EOF
source ~/enableProxy
```

这样就完成并设置了代理, 接着我们来验证以下是否可以正常使用

```bash
curl -L http://ip.cn
```

如果出现的是你使用的 代理的 IP 即可.

#### 通常来讲, 不要将这个 export 终端初始化自动执行

可能很多的教程里会告诉你可以写到 .zshrc 或者 .bashrc 甚至 /etc/profile 中, 用意就是可以初始化终端时, 就自动应用这个配置, 但是这样自动应用 proxy 会带来很多问题. 

比如 在 Terminal 中 请求 本地的资源时, 必然会访问失败, 因为请求已经被代理到外部. 再比如有些程序不支持 proxy 的设置, 会导致失败. 所以建议如果需要使用的 Proxy 的话, 直接 `Ctrl+Alt+T` 唤出 Terminal, 执行 Source ~/enableProxy , 让这个终端可以通过代理访问即可.

## 图形化界面下的 Chrome/Firefox

#### 全局设置

这个相对简单, Chrome 可以打开 Ubuntu 图形化界面的 网络设置进行设置,

![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/ubuntu_proxy_setting2.png)

Firefox 则可以通过, 设置页面的 Network Setting 中的 Proxy 进行设置, 和 Chrome 的设置类似, 这里就不过多赘述


### 智能 (伪) 代理

Chrome 中可以利用 `Proxy SwitchyOmega` 这个扩展来达成,

[pac link](https://raw.githubusercontent.com/wiki/FelisCatus/SwitchyOmega/GFWList.bak)
