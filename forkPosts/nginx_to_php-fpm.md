# Nginx to PHP-FPM

[Nginx](https://zh.wikipedia.org/wiki/Nginx)是最早由 俄国人 `Igor Sysoev` 开发的 Webserver。我们通常会对PHP-FPM，FastCGI比较熟悉，但是对于Nginx、PHP这对老搭档具体的交互细节并不清楚。

---
我们现在配置了一个这样的环境

* **PHP 7.1.x**
* **Nginx 1.13.x**

Nginx 配置如下：

```nginx
server
    {
        listen 80 default_server;
        index index.php;
        root /home/work/imooc;

        location ~ [^/]\.php(/|$)
        {
            fastcgi_pass unix:/tmp/php-cgi.sock;     #← ← ← ← ← ← 注意这一块  
            fastcgi_index index.php;                 #← ← ← ← ← ← 注意这一块
            include fastcgi.conf;                    #← ← ← ← ← ← 注意这一块
        }
        access_log /home/work/logs/imooc.log;

}
```

从上面的 Nginx 配置中可以注意到 fastcgi* 开头的一些配置



`updating`



> 文章源 来自: https://www.imooc.com/article/19278  
> 在此基础上有做 修改 和 编辑
