+++
date = "2019-09-11"
title = "use sed regex change camel-case to underline"
slug = "use-sed-regex-change-camel-case-to-underline-dy7bl"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

驼峰转下划线(大小驼峰都适用)

```shell
echo "HelloWorldKurisu" | sed -E 's/([A-Z])/_\1/g' | sed -E 's/^_//g' | tr 'A-Z' 'a-z'
```

利用正则匹配的方式, sed 的 -E 参数开启正则, 然后 sed 语法中, \n(例如 \1) 代表 正则中的 () 包含的内容, 序号从1开始, 比如 上文中, `/([A-Z])/_\1/` 指的就是 在 匹配到的 A-Z 前面加上 _, 
