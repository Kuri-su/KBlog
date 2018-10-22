slug: from Nginx to PHPApp

# 从 百草Nginx 到 三味PHP-Application

> 因为网络上对 `CGI` ， `FASTCGI` ， `PHP-FPM` 的解释非常多，而且相互之间有些存在自相矛盾，而在下又未曾看过这些实现的源码，所以以下的文字会尽量标明出处。  
> 
> 目前认为可信的源如下：
> - Wikipedia
> - php.net
> - tools.ietf.org 上 的 RPC 文档
> - www.mit.edu 上的 FASTCGI Specification 文档

我们知道，如果我们从0开始配置一台服务器的时候，安装了 Nginx 但是没有安装 PHP-FPM ，我们的服务器将只能响应静态资源的请求，而无法对动态内容的请求做出响应，例如我们没有办法去响应一条查询当前天气的请求。而这，就是早期的互联网。

当然，这样并不能满足日益增长的需求。于是 `CGI` 便诞生了。 

## CGI (Common Gateway Interface) 
> Common Gateway Interface 通用接口网关

![CGI logo](https://upload.wikimedia.org/wikipedia/en/c/cd/CGIlogo.gif) `CGI LOGO`

如果用一句话概括， **CGI 是 Web Server 和 Web Application 之间数据交换的一种协议**$^{[1][2]}$。就像 logo 上画的那样。

CGI 并不是一段代码，它是 Web-Application 与 Web Server 之间进行数据交换的一种协议。是实现这种功能的一个定义，一种规范。并且 CGI 要求与语言无关，可以用任何语言编写$^{[?]}$。

它是一切的基础，此后的无论是 FASTCGI 还是 WSIG 都是在这个协议的思考上建立起来的。

但是 CGI 协议有一个比较大的缺陷，它的实现会为以 fork 自身的方式为每一个请求创建一个子进程去调用 Web-Application$^{[3]}$，这样在性能上会有很大的问题。`FASTCGI` 便是为了解决这个问题而诞生的。

## FASTCGI (Fast Common Gateway Interface)
> Fast Common Gateway Interface 快速通用接口网关

FASTCGI协议 是一个开放性拓展版的 CGI 协议$^{[4]}$ 。
> FastCGI is an open extension to CGI that provides high performance for all Internet applications without the penalties of Web server APIs.

FastCGI 协议要求在多个独立的 FastCGI 请求之间复用单个进程进行传输，也就是请求来了的时候得复用，而不能像 CGI 那样，来一个请求fork一个进程去处理$^{[4]}$ 。这样其实就是一个进程池的概念。

所以这里总结一下其实很简单，首先一开始 我们需要 Web-App(就是一些PHP文件) 和 

## PHP-CGI

> PHP-CGI


## PHP-FPM


----
## 引用
> [1] https://en.wikipedia.org/wiki/Common_Gateway_Interface   
> [2] https://tools.ietf.org/html/rfc3875  
> [3] https://tools.ietf.org/html/rfc3875#section-9.5  
> [4] http://www.mit.edu/~yandros/doc/specs/fcgi-spec.html#S1  

## 参考



https://www.awaimai.com/371.html  
http://blog.51reboot.com/cgi-fastcgi-wsgi/  
https://tools.ietf.org/html/rfc3875  
https://en.wikipedia.org/wiki/Common_Gateway_Interface  



在讲述一条请求从 `Nginx` 到 `PHP-App` 的过程之前，我们需要先尝试讲清楚 `CGI` ， `FASTCGI` ， `PHP-FPM` 这三者之间的关系。
   
