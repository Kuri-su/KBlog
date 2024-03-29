+++
date = "2018-07-30"
title = "在命令行上输出进度条"
slug = "5ev18"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++

今天在 Laravel-china 看到一个帖子[link](https://laravel-china.org/articles/14927/php-implementation-of-terminal-progress-bar) ,然后自己以前就想过要做这种效果，就了解了下

首先先贴一份简陋的代码
```php
<?php
$count = 100;
for ($i = 1; $i <= 100; $i++) {
    usleep(50000);
    //str_repeat 函数的作用是重复这个符号多少次
    $equalStr = str_repeat("=", $i);
    $space    = str_repeat(" ", $count - $i);
    echo("\r [$equalStr>$space]($i/$count%)");
}
```

这份代码其实没有什么特别的，只是构造一个进度条的样子而已，一切的关键在 echo 函数中开头的 `\r`。

我们先看一点历史:
> 在计算机还没有出现之前，有一种叫做电传打字机（Teletype Model 33，Linux/Unix下的tty概念也来自于此）的玩意，每秒钟可以打10个字符。但是它有一个问题，就是打完一行换行的时候，要用去0.2秒，正好可以打两个字符。要是在这0.2秒里面，又有新的字符传过来，那么这个字符将丢失。
>
> 于是，研制人员想了个办法解决这个问题，就是在每行后面加两个表示结束的字符。一个叫做“回车”，告诉打字机把打印头定位在左边界；另一个叫做“换行”，告诉打字机把纸向下移一行。这就是“换行”和“回车”的来历，从它们的英语名字上也可以看出一二。
>
> 后来，计算机发明了，这两个概念也就被般到了计算机上。那时，存储器很贵，一些科学家认为在每行结尾加两个字符太浪费了，加一个就可以。于是，就出现了分歧。
>
> 在Windows中：
>
> '\r' 回车，回到当前行的行首，而不会换到下一行，如果接着输出的话，本行以前的内容会被逐一覆盖；
>
> '\n' 换行，换到当前位置的下一行，而不会回到行首；
>
> Unix系统里，每行结尾只有“<换行>”，即"\n"；Windows系统里面，每行结尾是“<回车><换行>”，即“\r\n”;  
> Mac系统里，每行结尾是“<回车>”，即"\r"；。一个直接后果是，Unix/Mac系统下的文件在Windows里打开的话，所有文字会变成一行；
> 而Windows里的文件在Unix/Mac下打开的话，在每行的结尾可能会多出一个^M符号。
> 
> from : <https://www.cnblogs.com/xiaotiannet/p/3510586.html>


那么看完应该就知道原理了，每次 echo 出来的时候自动回到行首覆盖上一次的输出，仅此而已。

[myGist](https://gist.github.com/Kuri-su/230316b812ac3e0e9af451ac78b4d72f)