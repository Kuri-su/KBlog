
## What 

如果不想每次使用 `Nginx` 部署新站点的时候都需要去 Copy 以前的 Nginx 配置, 那么 `nginxconfig.io` 会是你的不二选择. 直接访问 <https://nginxconfig.io> 即可使用.

## How

首先我们访问到 <https://nginxconfig.io> , 可以看到如下页面

![](/assets/nginxconfig-io.guide.1.webp)

假设我们需要搭建的一个 PHP 的 Laravel 服务, 最简单的方式, 我们仅仅需要在 Server 的 Domain 中输入我们的 域名, 然后 在 Global 指定 Nginx 与 PHP-FPM 的通信位置, socket 方式或者 TCP 的方式都可以, 这里我们就改成 以 TCP 的方式在 127.0.0.1:9000 进行通信, 即如下图这样设置, 

![](/assets/nginxconfig-io.guide.2.webp) 

接着如果你不需要 HTTPS , 到 HTTPS 标签下 把 HTTPS 对应的 enabled 去掉,接着我们点 ` Generated config (.zip)` 即可.

然后使用 ftp/scp 等命令将里面的文件文件分别放到对应的文件夹内, 如果你没有设置 HTTPS , 那么此时直接 `nginx -t && nginx -s reload` 即可让 Nginx 应用配置.

如果你需要设置 , 那么 HTTPS 你还需要按照此处的流程走完 SSL 的初始化与 证书配置 (CertBot/acme.sh).

![](/assets/nginxconfig-io.guide.3.webp) 

