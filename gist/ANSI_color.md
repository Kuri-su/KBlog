# 利用 ANSI 转义序列 玩出不一样的 stdout

平时我们的调试时的输出信息大多都是默认样式，其实如果有一些信息用不一样的颜色标注，会更容易看到问题的所在。我们其实可以依赖 ANSI 支持的样式达到这点。


首先来一个简单的例子，我们在命令行下输出 红底白字的 `Laravel ERROR : Oh My God, this is a bug!!!`
```php
<?php
    echo "\033[41:37m \n Laravel ERROR : Oh My God, this is a bug!!! \n";
```

然后就会出现这个样子的提示
![](https://raw.githubusercontent.com/Kuri-su/My-blog/master/assets/ANSI_color1.png)

是不是还有点意思，我们再多试几个

**超级power的进度条**
```php
<?php
$count = 100;
for ($i = 1; $i <= 100; $i++) {
    usleep(50000);
    $color = $i % 8 + 40;
    $equalStr = str_repeat("\033[{$color};37m=\33[0m", $i);
    $space    = str_repeat(" ", $count - $i);
    echo("\r [$equalStr>$space]($i/$count%)");
}
```

**移动的正方形**
```php
<?php
for ($i = 0; $i < 50; ++$i) {
    usleep(50000);
    $space = str_repeat(" ", $i);
    echo "\33[?25l\033[2J\n";
    echo "$space\033[47;30m  \033[0m\n$space\033[47;30m    \033[0m\n$space\033[47;30m      \033[0m\n$space\033[47;30m        \033[0m";
}
echo "\33[?25h";
# 如果这里要做的完美，需要获取cli的窗口大小
```
你甚至可以在命令行上用这些样式做动画 [link](https://github.com/klange/nyancat)

那么基本就是这些，剩下就是各位发挥才智的时间了www

贴上各个设置代表的意思
```
#跟颜色有关的配置项
# 设置颜色
echo -e "\033[30m 黑色字 \033[0m"
echo -e "\033[31m 红色字 \033[0m"
echo -e "\033[32m 绿色字 \033[0m"
echo -e "\033[33m 黄色字 \033[0m"
echo -e "\033[34m 蓝色字 \033[0m"
echo -e "\033[35m 紫色字 \033[0m"
echo -e "\033[36m 天蓝字 \033[0m"
echo -e "\033[37m 白色字 \033[0m"

# 设置颜色和底色
echo -e "\033[40;37m 黑底白字 \033[0m"
echo -e "\033[41;37m 红底白字 \033[0m"
echo -e "\033[42;37m 绿底白字 \033[0m"
echo -e "\033[43;37m 黄底白字 \033[0m"
echo -e "\033[44;37m 蓝底白字 \033[0m"
echo -e "\033[45;37m 紫底白字 \033[0m"
echo -e "\033[46;37m 天蓝底白字 \033[0m"
echo -e "\033[47;30m 白底黑字 \033[0m"

# 更多配置项
\033[0m 关闭所有属性
\033[1m 设置高亮度
\033[4m 下划线
\033[5m 闪烁
\033[7m 反显
\033[8m 消隐
\033[30m -- \33[37m 设置前景色
\033[40m -- \33[47m 设置背景色
\033[nA 光标上移n行
\033[nB 光标下移n行
\033[nC 光标右移n行
\033[nD 光标左移n行
\033[y;xH设置光标位置
\033[2J 清屏
\033[K 清除从光标到行尾的内容
\033[s 保存光标位置
\033[u 恢复光标位置
\033[?25l 隐藏光标
\033[?25h 显示光标 

ref: http://blog.51cto.com/onlyzq/546459
```

-----
如果发现文章有误,欢迎给 [link](https://github.com/Kuri-su/KBlog/blob/master/gist/ANSI_color.md) 提交 pull request