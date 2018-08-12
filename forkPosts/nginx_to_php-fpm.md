**该文章部分有误，请注意辨识，待更新中**

-----
**该文章部分有误，请注意辨识，待更新中**

-----
**该文章部分有误，请注意辨识，待更新中**

-----

# Nginx to PHP-FPM

[Nginx](https://zh.wikipedia.org/wiki/Nginx) 是最早由 俄国人 `Igor Sysoev` 开发的 `Webserver`。我们通常会对 PHP-FPM ， FastCGI 比较熟悉，但是对于 Nginx 、PHP 这对老搭档具体的交互细节并不清楚。

---
我们现在配置了一个这样的环境

* **PHP 7.1.x**
* **Nginx 1.12.x**

Nginx 配置如下：

```nginx
server
    {
        listen 80 default_server;
        index index.php;
        root /home/work/imooc;

        location ~ [^/]\.php(/|$)
        {
            ###########################################
            fastcgi_pass unix:/tmp/php-cgi.sock;     ##← ← ← ← ← ← 注意这一块  
            fastcgi_index index.php;                 ##← ← ← ← ← ← 注意这一块
            include fastcgi.conf;                    ##← ← ← ← ← ← 注意这一块
            ###########################################
        }
        access_log /home/work/logs/imooc.log;

}
```

从上面的 Nginx 配置中可以注意到 `fastcgi*` 开头的一些配置，以及引入的 `fastcgi.conf` 文件。其实在 `fastcgi.conf` 中，也是一堆 `fastcgi*` 的配置项，只是这些配置项相对不常变，通常单独文件保管可以在多处引用。下面是 `fastcgi.conf` 的内容

```nginx
# Nginx 1.12.2
fastcgi_param  QUERY_STRING       $query_string;
fastcgi_param  REQUEST_METHOD     $request_method;
fastcgi_param  CONTENT_TYPE       $content_type;
fastcgi_param  CONTENT_LENGTH     $content_length;

fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;
fastcgi_param  REQUEST_URI        $request_uri;
fastcgi_param  DOCUMENT_URI       $document_uri;
fastcgi_param  DOCUMENT_ROOT      $document_root;
fastcgi_param  SERVER_PROTOCOL    $server_protocol;
fastcgi_param  REQUEST_SCHEME     $scheme;
fastcgi_param  HTTPS              $https if_not_empty;

fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;
fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;

fastcgi_param  REMOTE_ADDR        $remote_addr;
fastcgi_param  REMOTE_PORT        $remote_port;
fastcgi_param  SERVER_ADDR        $server_addr;
fastcgi_param  SERVER_PORT        $server_port;
fastcgi_param  SERVER_NAME        $server_name;

# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param  REDIRECT_STATUS    200;

```

可以看到在 `fastcgi.conf` 中，有很多的 `fastcgi_param` 配置，结合 `nginx server` 配置中的 `fastcgi_pass` 、 `fastcgi_index` ，已经能够想到 `Nginx` 与 `PHP` 之间打交道就是用的 `FastCGI` ，接着让我们探究更加深入的问题。

`CGI` 是 `通用网关协议`，`FastCGI` 则是一种常驻进程的 `CGI` 模式程序。我们所熟知的 `PHP-FPM` 的全称是 `PHP FastCGI Process Manager` ，即 `PHP-FPM` 会通过用户配置来管理一批 `FastCGI` 进程，例如在 `PHP-FPM` 管理下的 `某个FastCGI` 进程挂了，`PHP-FPM` 会根据用户配置来看是否要重启补全，`PHP-FPM` 更像是管理器，而真正衔接 `Nginx` 与 `PHP` 的则是 `FastCGI` 进程。

![](/assets/nginx_to_php-fpm/Nginx.png)

如上图所示, FastCGI 的下游,是 CGI-APP , 在 `Nginx -> PHP` 的案例里, 这个 CGI-APP 就是 PHP 程序。 而 FastCGI 的上级是 Nginx , 他们之间有一个通信载体，即图中的 socket 。

在上面的配置文件中， `fastcgi_pass` 所配置的内容，便是告诉 Nginx 你接收到用户请求以后，你该往哪里转发，在我们图3中是转发到本机的一个 socket 文件，这里 fastcgi_pass 也常配置为一个 HTTP 接口地址（这个可以在 `php-fpm.conf` 中配置）。

```nginx
    fastcgi_pass unix:/tmp/php-cgi.sock;
```

而上图5中的 Pre-fork ，则对应着我们 PHP-FPM 的启动，也就是在我们启动 PHP-FPM 时便会根据用户配置启动诸多 **FastCGI触发器**(`FastCGI Wrapper`)。

---

对 FastCGI 在 `Nginx -> PHP` 的模式中的定位有了一定了解后，我们再来了解下 Nginx 中为何能写很多 `fastcgi_*` 的配置项。这是因为 Nginx 的一个默认内置 module 实现了 FastCGI 的 `Client` 。关于`Module ngx_http_fastcgi_module`的详细文档可以查看这里：[nginx.org/docs](http://nginx.org/en/docs/http/ngx_http_fastcgi_module.html#fastcgi_param)。

下面是从文档中摘取的 `fastcgi_param` 详细描述。( 简单的翻译了下... )

```
句法 : fastcgi_param   parameter   value [if_not_empty];

设置一些需要传递给 FastCGI server 的 参数 , 这里的 value 可以是一个 文本 或 变量 或 文本和变量的组合。 

如果在当前级别没有设置这个变量，他会去继承上一个级别的 parameter

下面的示例显示了 PHP的最低必须设置
    fastcgi_param SCRIPT_FILENAME /home/www/scripts/php$fastcgi_script_name;
    fastcgi_param QUERY_STRING    $query_string;

其中,SCRIPT_FILENAME 用于指定脚本的名字, QUERY_STRING 参数用于传递请求参数

如果需要处理 POST 请求,则需要追加 以下三个参数:
    fastcgi_param REQUEST_METHOD  $request_method;
    fastcgi_param CONTENT_TYPE    $content_type;
    fastcgi_param CONTENT_LENGTH  $content_length;
```

上面文档该部分第一句话可以看到, `fastcgi_param` 所声明的内容,将会被传递给 `FastCGI server`, 也就是 在 `Nginx -> PHP` 模式下的 `PHP-FPM` 所管理的 FastCGI 进程, 或者 说是那个 `socket` 文件载体。

**那么为什么 PHP-FPM 管理的 那些 FastCGI 进程需要关心 Nginx 传过来的这些参数呢？**

我们一起想想我们做 `PHP应用开发` 的时候有没有用到 `$_SERVER` 这个全局变量,它里面包含了很多服务器信息 (当启用 `Xdebug` 断点调试的时候会看的非常清楚) , 比如包含了用户的IP地址. PHP 身处 `Socket` 文件之后,为什么能获得远端用户的IP呢?

我们可以注意到上面的 `fastcgi_param` 配置 `REMOTE_ADDR`, 而我们在 `原生PHP` 中获取用户IP 正是用的 `$_SERVER['REMOTE_ADDR']`

> 之后会追加一个测试,证实确实是这些配置在影响 PHP 是否可以获取到这些信息

```
    fastcgi_param  REMOTE_ADDR        $remote_addr;
    fastcgi_param  REMOTE_PORT        $remote_port;
    fastcgi_param  SERVER_ADDR        $server_addr;
    fastcgi_param  SERVER_PORT        $server_port;
    fastcgi_param  SERVER_NAME        $server_name;
```

确实,Nginx 这个模块里 `fastcgi_param` 参数, 就是考虑后端程序有时需要获取 `Webserver` 外部的变量以及服务器情况, 那么 `ngx_http_fastcgi_module ` 就是做了这件事.

---

那么已经说清楚了 `FastCGI` 是什么, 而且它在 `Nginx -> PHP` 中的定位. 我们回到前面提出的问题, **"它起到衔接 Nginx -> PHP 的什么作用?"**

对 PHP 有一定了解的同学，应该会知道 PHP 提供 SAPI (`Server Application Programming Interface： the API used by PHP to interface with Web Servers`) 面向 `Webserver` 来提供扩展编程。但是这样的方式意味着你要是自主研发一套 `Webserver` ，你就需要学习 `SAPI` ，并且在你的 `Webserver` 程序中实现它。这意味着你的 Webserver 与 PHP 产生了耦合。

在互联网的大趋势下，一般大家都不喜欢看到耦合。譬如 Nginx 在最初研发时候也不是为了和 PHP 组成黄金搭档而研发的，相信早些年的 Nginx 后端程序可能是其他语言开发。那么解决耦合的办法，比较好的方式是 **有一套通用的规范，上下游都兼容它**。那么 CGI 协议便成了 Nginx 、 PHP 都愿意接受的一种方式，而 FastCGI 常住进程的模式又让上下游程序有了高并发的可能。那么， FastCGI 的作用是 Nginx 、 PHP 的接口载体，就像插座与插销，让流行的 WebServer 与 PHP 有了合作的可能。

有了这些基础背景知识与他们的缘由，我们就可以举一反三的做更多有意思的事情。譬如我 (`以下皆指本文原作者`) 在前年曾实现了 Java 程序中按照 `FastCGI Client` 的方式（替代 Nginx）与 PHP-FPM 通信，实现 `Java项目+PHP` 的一种组合搭配，解决的问题是 Java 程序一般来说在代码调整后需要编译过程，而 PHP 可以随时调整代码随时生效，那么让 Java 作为项目外壳，一些易变的代码由 PHP 实现，在需要的时候 Java 程序通过 FastCGI 与 PHP 打交道就好。这套想法也是基于对 `Nginx+PHP` 交互模式的理解之上想到的。

网络中也有一些借助 FastCGI 的尝试与实践，譬如 `《Writing Hello World in FCGI with C++》` 这篇文章，用 C++ 实现一个 FastCGI 的程序，外部依然是某款 Webserver 来处理 HTTP 请求，但具体功能则有 C++ 来实现，他们的中间交互同样适用的 FastCGI 。同学们有兴趣了也可以做些 Geek尝试。

![](/assets/nginx_to_php-fpm/cpp%20%E5%AE%9E%E7%8E%B0%E4%B8%80%E4%B8%AA%20FastCGI%20%E7%A8%8B%E5%BA%8F.png)

> C++ 实现一个 FastCGI 程序

## 尾声
`Nginx+PHP` 的工程模式下，两位主角分工明确，Nginx 负责承载 HTTP 请求的响应与返回，以及超时控制记录日志等 HTTP 相关的功能，而 PHP 则负责处理具体请求要做的业务逻辑，它们俩的这种合作模式也是常见的分层架构设计中的一种，在它们各有专注面的同时， FastCGI 又很好的将两块衔接，保障上下游通信交互，这种通过某种协议或规范来衔接好上下游的模式，在我们日常的 PHP 应用开发中也有这样的思想落地，譬如我们所开发的高性能 API ，具体的 Client 到底是 PC、APP 还是某个其他程序，我们不关心，而这些 PC 、 APP 、第三方程序也不关心我们的 PHP 代码实现，他们按照 API 的规范来请求做处理即可。

---

> 文章源 来自: https://www.imooc.com/article/19278  
> 在此基础上有做 修改 和 编辑

> 转载 注明出处
