
关于 Git 使用 Proxy , 网上很多教程讲的都是 如何设置 Http 下 Git 使用 Proxy , 但是并没有提到 SSH 下如何使用 Proxy . 即便有些文章讲到了, 也有不少是 Windows 平台下的, Linux 平台下的很少提及, 所以这里就记录一下, 如何在 Ubuntu 中, 使用 Git 在 SSH 协议下应用代理.

```shell
# 如何设置 git http proxy
$ git config --global http.proxy http://127.0.0.1:1080
$ git config --global https.proxy http://127.0.0.1:1080
$ cat ~/.gitconfig
[http]
    proxy = http://127.0.0.1:1080
[https]
    proxy = http://127.0.0.1:1080
```

## Ncat

首先你需要 安装一个 Ncat 工具, 在 Ubuntu 下这样安装即可,

```shell
$ sudo apt install ncat -y
```

ncat 和 nc 类似, 都是用于在两台电脑之间建立连接并返回数据, nc 是 netcat 的 OpenBSD 实现, 而 ncat 是从 nmap 项目抽离出来的 netcat 实现.

如果想看更加详细的介绍, 可以点击下面的链接 或者 在 Google 查询

> [10 个例子教你学会 ncat (nc) 命令](https://linux.cn/article-9190-1.html)
>
> [What are the differences between ncat, nc and netcat?](https://unix.stackexchange.com/questions/368155/what-are-the-differences-between-ncat-nc-and-netcat)
>
> [Linux每天一个命令：nc/ncat](https://www.cnblogs.com/chengd/p/7565280.html)

## 为 SSH 设置代理,

为 Git 以 ssh 的方式拉取项目设置代理的实质, 其实就是为 ssh config 中的 `github.com` 设置代理, 那么说到为ssh设置代理, 自然绕不开 ~/.ssh/config,

我们需要在 ~/.ssh/config 中加入如下内容:

```ruby
Host github.com
User git
Hostname github.com
ProxyCommand  /usr/bin/ncat --proxy 127.0.0.1:1080 --proxy-type http %h %p
# 如果你的代理使用的协议是 socks4/5 , 修改 --proxy-type 后面的协议即可, 例如
# --proxy-type socks4
# --proxy-type socks5
```

接着尝试用 git 用户 SSH 连接 Github.com 

```shell
$ ssh -T git@github.com
# 如果输出以下内容则代表成功.
Hi Kuri-su! You've successfully authenticated, but GitHub does not provide shell access.
```

**Success** !!

Part of the content reference from

> https://blog.systemctl.top/2017/2017-09-28_set-proxy-for-git-and-ssh-with-socks5/