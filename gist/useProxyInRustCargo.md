+++
date = "2020-08-02"
title = "use Proxy In Rust Cargo"
slug = "use-proxy-in-rust-cargo-c45q6"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "Rust Cargo 使用 Proxy"
+++

# Rust Cargo 使用 Proxy 

[TOC]

由于有一些 Rust Cargo 包需要从 github 下载, 没有 Proxy 会很慢, 遂开始寻找 代理的方法, 在 Rust docs 里找到相关介绍. 

任何环境下都可以 在 `$HOME/.cargo` 下创建 config 文件 (刚刚安装 Cargo 是没有 config 文件的, 不用紧张), 然后填入如下内容

```ini 
[http]
proxy = "127.0.0.1:1234"

[https]
proxy = "127.0.0.1:1234"
```