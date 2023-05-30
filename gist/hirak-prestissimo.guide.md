+++
date = "2019-11-04"
title = "hirak/prestissimo"
slug = "hirakprestissimo-xexco"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "hirak/prestissimo"
+++


## Install

```shell
$ composer global require hirak/prestissimo
```

## What

在使用 Composer 下载依赖时, 会依次下载并安装每一个依赖, 这种方式在小型项目上没有什么问题, 但是较大的项目上体验就会变得比较差.

而 hirak/prestissimo 可以在 require 的一开始就 并行的去  Download 所有的 依赖资源, 然后再依次进行安装, 这样极大的减少了浪费在下载 依赖包上的时间, 这里放上一个 作者的效果演示图:

![ex](https://cloud.githubusercontent.com/assets/835251/12534815/55071302-c2ad-11e5-96a4-72e2c8744d5f.gif)

項目源地址: 

https://github.com/hirak/prestissimo

## How

在全局安裝了 hirak/prestissimo 之後, 在項目中使用 composer 引入第三方库即可看到效果.