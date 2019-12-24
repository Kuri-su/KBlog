
# Linux 下 IDEA 2019.3 以后版本无法唤出输入法

我的版本是 Ubuntu 19.10 / IDEA 2019.3.1

你可以点击 在菜单栏的这个位置 `Help | Edit Custom VM Options`这个位置, 它将打开一个 `.vmoptions` 文件, 在末尾追加如下 内容

```
-Dauto.disable.input.methods=false
```

然后重启 IDEA, 即可

`GoLand`/`PhpStorm`/`Clion`/`PyCharm` 这些全家桶成员应该也适用 :joy: .

ref: 
> https://youtrack.jetbrains.com/issue/JBR-2003