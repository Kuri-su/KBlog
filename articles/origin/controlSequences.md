{"title":"ANSI 终端输出瞎搞指北","description":"今天我克里斯就是要在终端上画彩虹猫","category":"Linux","tag":["ANSI","just fun"],"page_image":"/assets/ControlSequences.png"}

# Terminal Control Sequences 终端控制转义序列

Author: Amatist Kurisu

## 前言

最早由 一篇游玩性质的 gist 文章 [利用 ANSI 转义序列 玩出不一样的 stdout](https://kuricat.com/gist/ansi-stdout-6s4pi), 引起了对 `ANSI 转义序列` 之类的兴趣. 后因为需要使用 Go 实现 终端清屏 的小功能, 在尝试了使用 `clear` 命令后, 发现使用 `\x1b[2J` 也可以实现清屏终端, 故便对此深挖.

下文介绍的主要是基于 `ANSI` 的转义序列, 可能会和 `VT102` 等模式有细微不同. 目前(2019)的类 Unix 系统对于各种标准皆有实现, 可不必担心.

下文中的 `ANSI` 皆代表 `ANSI 转义序列` , 防止与 ANSI (美国国家标准协会) 弄混. 

> 来自 Ubuntu 的 man 手册
>
> The  Linux  console implements a large subset of the `VT102` and `ECMA-48` or `ISO 6429` or `ANSI X3.64` terminal controls, plus certain private-mode sequences for  changing  the  color palette, character-set  mapping,  and  so on  
> 
> via: http://manpages.ubuntu.com/manpages/bionic/en/man4/console_codes.4.html  
>
> #### 注释
> 
> * `ECMA-48` 是 ANSI 系列的第一个标准 
> * // 1976 通过  
> *
> * AESC (美国国家标准学会, 1969 更名为 ANSI, 为防止弄混, 此处称为 AESC) 采用 `ECMA-48` 作为 `ANSI X3.64` 
> * // 1979  
> * 
> * 由 `AESC X3L2(ANSI X3L2)` 委员会 和 `ECMA TC 1` 委员会 将两份几乎一样的标准, 合并为 `ISO 6429` 国际标准 
> * // [1992](https://www.iso.org/standard/12782.html)   
> *  
> * AESC (ANSI) 取消了其标准, 以支持 `ISO 6429` 国际标准
> * // 1994  

## ANSI 和 ASCII

首先介绍 ANSI 和 ASCII 的关系, 笔者此前经常将二者弄混... , 甚至有时候写出 `ANSII` 这样的神奇搭配..

### ANSI 

`ANSI 转义序列` 是一种 带内信号(`In-band Signaling`) 的 转义序列(`escape sequence`) 标准 , 用来控制 终端上的 `光标位置`, `颜色`, 以及 `其它选项`.

在文本中嵌入 `ANSI 转义序列`, 终端会把这些 ANSI 转义序列 解释为相应的指令, 而不是普通的字符.

例如运行这个例子, 将会输出RGB颜色为 R:215,G:84,B:85 (大体是 <font color="#D75455">粉红色</font>) 的 `Hello World` 在终端中 <font color="#D75455">Hello World</font>

```c
printf("\x1b[38;2;215;84;85m Hello World")
```

### ANSI 和 ASCII 关系

ASNI 是为了解决 各家厂商都提出自家标准而造成市场十分混乱 的问题而提出的 (大部分沿用到现代的标准似乎都是这个理由XD).

标准制定了一种 所有终端共享的指令集,并要求采用 `ASCII` 的数字字符 传递所有的信息.

## ANSI 转义序列

所有序列都以 ASCII 字符 `ESC` (OCT \033 HEX \x1b)开头,例如上面输出粉红色字的例子

除 `ESC(\x1b)` 之外的 `C0 控制字符` 在输出时也有时会产生与一些 ANSI 转义序列 相似的效果

例如 `\n(\x0a)` 也就是我们常看到的 `LF` 和 `ESC E(\x1bE)` 会有相似的效果

```c
print("Hello World")
printf("\n")
printf("Hello World \n\n")
// output :
// Hello World
// Hello World

print("Hello World")
printf("\x0a")
printf("Hello World \n\n")
// output :
// Hello World
// Hello World

print("Hello World")
printf("\x1bE")
printf("Hello World \n\n")
// output :
// Hello World
// Hello World
```

### ESC - but not CSI-sequences
那么下面简单列举一下 `ESC 非控制转义序列(ESC - but not CSI-sequences)`  
不常用的就不列举了,可以前往参考源的第一个和第二个链接查阅

指令原语|实际使用|效果|更多例子|备注
-|-|-|-|-
ESC c|\x1bc|类似于 Linux 命令 `clear`||
ESC D|\x1bD|换行. 类似于打字机直接向下挪了一行,而没有将打印位置初始化到行首|`printf("\x1bD Hel\x1bD lo Wor\x1bD ld")`|
ESC E|\x1bE|类似于 `\n` , 换行并将打印位置初始化到行首||
ESC H|\x1bH|类似于 `\t`||
ESC M|\x1bM|翻转换行(Reverse line feed),正向换行是到下一行,翻转换行则是去到上一行. 还是想象打印机时代XD||[What is a reverse line feed - stackoverflow](https://stackoverflow.com/questions/10638382/what-is-a-reverse-line-feed)
**ESC [**|**\x1b[... 或者 \x9d...**|**`将在下面 控制序列(CSI) 的位置介绍`,等价于 `C1 控制字符` 中的 `CSI`**||
ESC % G|\x1b%G|选择 UTF-8 作为字符集||
ESC # 8|\x1b#8|DEC 屏幕校准测试,使用 `E` 填充整个终端屏幕||

### 控制序列- CSI(Control Sequence Introducer)

CSI 序列 由 `ESC [` 以及若干个 `参数字节` 和 若干个`中间字节` 以及 一个 `最终字节` 组成.

> 笔者注:
> CSI 其实也可以用 `\x9d` 来表示, [出处](https://zh.wikipedia.org/wiki/C0%E4%B8%8EC1%E6%8E%A7%E5%88%B6%E5%AD%97%E7%AC%A6#CSI)
> 但是 笔者在 GNOME 终端下使用 `printf("\x9b38;2;215;84;85m Hello World")` 始终无法得到想要的结果....
> 然后 切换到 `tty3` 之类的非图形化界面后,就可以使用 `printf("\x9b38;2;215;84;85m Hello World")` 输出 粉红色的 Hello world , 具体原因未知...

组成部分|字符范围|ASCII
-|-|-
参数字节|0x30–0x3F|0–9:;<=>?
中间字节|0x20–0x2F|空格、!"#$%&'()*+,-./
最终字节|0x40–0x7E|@A–Z[\]^_`a–z{|}~

**下面就直接 Copy wiki的表格.. 重要的是 SGR 部分, 也就是CSI `n` m , 不过别的也都很好玩就是了XD**

 代码 | 名称 | 作用
-|-|-
 CSI `n` A | CUU – 光标上移（Cursor Up） |  光标向指定的方向移动`n`（默认1）格。如果光标已在屏幕边缘，则无效。
 CSI `n` B | CUD – 光标下移（Cursor Down）|  光标向指定的方向移动`n`（默认1）格。如果光标已在屏幕边缘，则无效。
 CSI `n` C | CUF – 光标前移（Cursor Forward）|  光标向指定的方向移动`n`（默认1）格。如果光标已在屏幕边缘，则无效。
 CSI `n` D | CUB – 光标后移（Cursor Back）|  光标向指定的方向移动`n`（默认1）格。如果光标已在屏幕边缘，则无效。
 CSI `n` E | CNL – 光标移到下一行（Cursor Next Line） | 光标移动到下面第`n`（默认1）行的开头。
 CSI `n` F | CPL – 光标移到上一行（Cursor Previous Line） | 光标移动到上面第`n`（默认1）行的开头。
 CSI `n` G | CHA – 光标水平绝对（Cursor Horizontal Absolute）}} | 光标移动到第`n`（默认1）列。
 CSI `n` ; `m` H | CUP – 光标位置（Cursor Position） | 光标移动到第`n`行、第`m`列。值从1开始，且默认为`1`（左上角）。例如`CSI ;5H`和`CSI 1;5H`含义相同；`CSI 17;H`、`CSI 17H`和`CSI 17;1H`三者含义相同。
 CSI `n` J | ED – 擦除显示（Erase in Display） | 清除屏幕的部分区域。如果`n`是0（或缺失），则清除从光标位置到屏幕末尾的部分。如果`n`是1，则清除从光标位置到屏幕开头的部分。如果`n`是2，则清除整个屏幕（在DOS ANSI.SYS中，光标还会向左上方移动）。如果`n`是3，则清除整个屏幕，并删除回滚缓存区中的所有行（这个特性是[[xterm]]添加的，其他终端应用程序也支持）。
 CSI `n` K | EL – 擦除行（Erase in Line） | 清除行内的部分区域。如果`n`是0（或缺失），清除从光标位置到该行末尾的部分。如果`n`是1，清除从光标位置到该行开头的部分。如果`n`是2，清除整行。光标位置不变。
 CSI `n` S | SU – 向上滚动（Scroll Up） | 整页向上滚动`n`（默认1）行。新行添加到底部。（非ANSI.SYS）
 CSI `n` T | SD – 向下滚动（Scroll Down） | 整页向下滚动`n`（默认1）行。新行添加到顶部。（非ANSI.SYS）
| CSI `n` ; `m` f | HVP – 水平垂直位置（Horizontal Vertical Position） | 同CUP。
| **CSI `n` m** | **SGR – 选择图形再现（Select Graphic Rendition）** | **设置SGR参数，包括文字颜色。CSI后可以是0或者更多参数，用分号分隔。如果没有参数，则视为`CSI 0 m`（重置/常规）**。
| CSI 5i | 打开辅助端口 | 启用辅助串行端口，通常用于本地串行打印机
| CSI 4i | 关闭辅助端口 | 禁用辅助串行端口，通常用于本地串行打印机
| CSI 6n | DSR – 设备状态报告（Device Status Report） | 以`ESC[n;mR`（就像在键盘上输入）向应用程序报告光标位置（CPR），其中`n`是行，`m`是列。
| CSI s | SCP – 保存光标位置（Save Cursor Position） | 保存光标的当前位置。
| CSI u | RCP – 恢复光标位置（Restore Cursor Position） | 恢复保存的光标位置。

### SGR 参数
列举常用以及广泛支持的参数,

指令原语|实际使用|效果|更多例子|备注
-|-|-|-|-
0|\x1b[0m|所有属性重设为默认值|`\x1b[38;2;215;84;85m Hello World \x1b[0m`|一般都用这个参数取消对后面字符串样式的影响
1|\x1b[1m|设置粗体|`\x1b[1m Hello World \x1b[0m`|
2|\x1b[2m|将亮度减半|`\x1b[2m Hello World \x1b[0m`例如这样就会看到 `灰色` 的 Hello World|
4|\x1b[4m|设置下划线|`\x1b[4m Hello World \x1b[0m`||文字会带下划线
5|\x1b[5m|设置闪烁|`\x1b[5m Hello World \x1b[0m`|
7|\x1b[7m|反显,前景色与背景色交换|`\x1b[7m Hello World \x1b[0m`|
8|\x1b[8m|隐藏,前景色和背景色一样|`\x1b[8m Hello World \x1b[0m`|(官方说未受广泛支持,但是在`Gnome Terminal 3.28.2` 上可以看到效果)
9|\x1b[9m|划掉, 类似于 markdown 中 ~~AAAA~~ 划掉的效果|`\x1b[7m Hello World \x1b[0m`|(官方说未受广泛支持,但是在`Gnome Terminal 3.28.2` 上可以看到效果)
22|\x1b[22m|将前面 `2` 设置的亮度重置为正常亮度|`\x1b[2m Hello \x1b[22m World \x1b[0m`|
24|\x1b[24m|关闭下划线|`\x1b[4m Hello \x1b[24m World \x1b[0m`|
25|\x1b[25m|关闭闪烁|`\x1b[5m Hello \x1b[25m World \x1b[0m`|
27|\x1b[27m|关闭反显|`\x1b[7m Hello \x1b[27m World \x1b[0m`|
28|\x1b[28m|关闭隐藏|`\x1b[8m Hello \x1b[28m World \x1b[0m`|
29|\x1b[29m|关闭划掉|`\x1b[9m Hello \x1b[29m World \x1b[0m`|
30~37|-|3/4位色 设置前景色,参照下方颜色表||
38|-|设置前景色(与 8bit 和 24bit 颜色设置有关)||参照下方颜色表
40~47|-|3/4位色 设置背景色,参照下方颜色表||
48|-|设置背景色(与 8bit 和 24bit 颜色设置有关)||参照下方颜色表
53|\x1b[53m|上划线|`\x1b[53m Hello World \x1b[0m`|
55|\x1b[55m|关闭上划线|`\x1b[53m Hello \x1b[55m World \x1b[0m`|
90~97|-|3/4位色 设置明亮的前景色,参照下方颜色表||
100~107|-|3/4位色 设置明亮的背景色,参照下方颜色表||

## 颜色

### 3/4 位色

你可以使用 `\x1b[31m` 设置 为红色字体,  
<font color="#CC0000">Hello World</font>

使用 `\x1b[31;102m` 设置 前景色为红色,背景色为亮绿色  
<span style="background-color:#8AE234"><font color="#CC0000">Hello World</font></span>

使用 `\x1b[1;5;31;102m` 设置 前景色为红色,背景色为亮绿色, 粗体,并闪烁   
<span style="background-color:#8AE234"><font color="#EF2929"><b>Hello Worl</b></font></span>

3/4 的颜色表如下(照搬 WIKI):

> 部分平台上 可能 30-37 和 90-97 显示的是同一种颜色,因平台而异

颜色名称|前景色代码|背景色代码|样式|
-|-|-|-
黑|30|40|<font color="black">◆</font>|
红|31|41|<font color="#de382b">◆</font>|
绿|32|42|<font color="#39b54a">◆</font>|
黄|33|43|<font color="#ffc706">◆</font>|
蓝|34|44|<font color="#006fb8">◆</font>|
品红|35|45|<font color="#762671">◆</font>|
青|36|46|<font color="#2cb5e9">◆</font>|
白|37|47|<font color="#cccccc">◆</font>|
亮黑（灰）|90|100|<font color="#808080">◆</font>|
亮红|91|101|<font color="#ff0000">◆</font>|
亮绿|92|102|<font color="#00ff00">◆</font>|
亮黄|93|103|<font color="#ffff00">◆</font>|
亮蓝|94|104|<font color="#0000ff">◆</font>|
亮品红|95|105|<font color="#ff00ff">◆</font>|
亮青|96|106|<font color="#00ffff">◆</font>|
亮白|97|107|<font color="#ffffff">◆</font>|

## 8bit (256 色)

可以使用 `\x1b[38;5;21m` 输出前景色为 编号 21 的 `#0000ff` 的字符串

可以使用 `\x1b[48;5;21m` 输出前景色为 编号 21 的 `#0000ff` 的字符串

颜色表如下(来自 WIKI , 链接见文末)

<table class="collapsible" style="text-align:center;font-size:80%;width:100%;background:#f6f6f6;cursor:default;" cellpadding="0" cellspacing="1" id="collapsibleTable0">


<tr>
<td colspan="18" ><font color="black">标准色</font>
</td>
<td colspan="18"><font color="black">高强度色</font>
</td></tr>
<tr>
<td colspan="36">
<table style="width:100%;text-align:center;font-weight:bold;">

<tbody><tr>
<td style="color:#ffffff;background:#000000;" title="#000000">&nbsp;0&nbsp;
</td>
<td style="color:#ffffff;background:#800000;" title="#800000">&nbsp;1&nbsp;
</td>
<td style="color:#ffffff;background:#008000;" title="#008000">&nbsp;2&nbsp;
</td>
<td style="color:#ffffff;background:#808000;" title="#808000">&nbsp;3&nbsp;
</td>
<td style="color:#ffffff;background:#000080;" title="#000080">&nbsp;4&nbsp;
</td>
<td style="color:#ffffff;background:#800080;" title="#800080">&nbsp;5&nbsp;
</td>
<td style="color:#ffffff;background:#008080;" title="#008080">&nbsp;6&nbsp;
</td>
<td style="color:#ffffff;background:#c0c0c0;" title="#c0c0c0">&nbsp;7&nbsp;
</td>
<td style="width:1em;">
</td>
<td style="color:#000000;background:#808080;" title="#808080">&nbsp;8&nbsp;
</td>
<td style="color:#000000;background:#ff0000;" title="#ff0000">&nbsp;9&nbsp;
</td>
<td style="color:#000000;background:#00ff00;" title="#00ff00">10
</td>
<td style="color:#000000;background:#ffff00;" title="#ffff00">11
</td>
<td style="color:#000000;background:#0000ff;" title="#0000ff">12
</td>
<td style="color:#000000;background:#ff00ff;" title="#ff00ff">13
</td>
<td style="color:#000000;background:#00ffff;" title="#00ffff">14
</td>
<td style="color:#000000;background:#ffffff;" title="#ffffff">15
</td></tr></tbody></table>
</td></tr>
<tr>
<td colspan="36"><font color="black">216色</font>
</td></tr>
<tr>
<td style="color:#ffffff;background:#000000;" title="#000000">16
</td>
<td style="color:#ffffff;background:#00005f;" title="#00005f">17
</td>
<td style="color:#ffffff;background:#000087;" title="#000087">18
</td>
<td style="color:#ffffff;background:#0000af;" title="#0000af">19
</td>
<td style="color:#ffffff;background:#0000d7;" title="#0000d7">20
</td>ANSI
<td sANSI;" title="#0000ff">21
</td>ANSI
<td sANSI;" title="#005f00">22
</td>
<td style="color:#ffffff;background:#005f5f;" title="#005f5f">23
</td>
<td style="color:#ffffff;background:#005f87;" title="#005f87">24
</td>
<td style="color:#ffffff;background:#005faf;" title="#005faf">25
</td>
<td style="color:#ffffff;background:#005fd7;" title="#005fd7">26
</td>
<td style="color:#ffffff;background:#005fff;" title="#005fff">27
</td>
<td style="color:#ffffff;background:#008700;" title="#008700">28
</td>
<td style="color:#ffffff;background:#00875f;" title="#00875f">29
</td>
<td style="color:#ffffff;background:#008787;" title="#008787">30
</td>
<td style="color:#ffffff;background:#0087af;" title="#0087af">31
</td>
<td style="color:#ffffff;background:#0087d7;" title="#0087d7">32
</td>
<td style="color:#ffffff;background:#0087ff;" title="#0087ff">33
</td>
<td style="color:#000000;background:#00af00;" title="#00af00">34
</td>
<td style="color:#000000;background:#00af5f;" title="#00af5f">35
</td>
<td style="color:#000000;background:#00af87;" title="#00af87">36
</td>
<td style="color:#000000;background:#00afaf;" title="#00afaf">37
</td>
<td style="color:#000000;background:#00afd7;" title="#00afd7">38
</td>
<td style="color:#000000;background:#00afff;" title="#00afff">39
</td>
<td style="color:#000000;background:#00d700;" title="#00d700">40
</td>
<td style="color:#000000;background:#00d75f;" title="#00d75f">41
</td>
<td style="color:#000000;background:#00d787;" title="#00d787">42
</td>
<td style="color:#000000;background:#00d7af;" title="#00d7af">43
</td>
<td style="color:#000000;background:#00d7d7;" title="#00d7d7">44
</td>
<td style="color:#000000;background:#00d7ff;" title="#00d7ff">45
</td>
<td style="color:#000000;background:#00ff00;" title="#00ff00">46
</td>
<td style="color:#000000;background:#00ff5f;" title="#00ff5f">47
</td>
<td style="color:#000000;background:#00ff87;" title="#00ff87">48
</td>
<td style="color:#000000;background:#00ffaf;" title="#00ffaf">49
</td>
<td style="color:#000000;background:#00ffd7;" title="#00ffd7">50
</td>
<td style="color:#000000;background:#00ffff;" title="#00ffff">51
</td></tr>
<tr>
<td style="color:#ffffff;background:#5f0000;" title="#5f0000">52
</td>
<td style="color:#ffffff;background:#5f005f;" title="#5f005f">53
</td>
<td style="color:#ffffff;background:#5f0087;" title="#5f0087">54
</td>
<td style="color:#ffffff;background:#5f00af;" title="#5f00af">55
</td>
<td style="color:#ffffff;background:#5f00d7;" title="#5f00d7">56
</td>
<td style="color:#ffffff;background:#5f00ff;" title="#5f00ff">57
</td>
<td style="color:#ffffff;background:#5f5f00;" title="#5f5f00">58
</td>
<td style="color:#ffffff;background:#5f5f5f;" title="#5f5f5f">59
</td>
<td style="color:#ffffff;background:#5f5f87;" title="#5f5f87">60
</td>
<td style="color:#ffffff;background:#5f5faf;" title="#5f5faf">61
</td>
<td style="color:#ffffff;background:#5f5fd7;" title="#5f5fd7">62
</td>
<td style="color:#ffffff;background:#5f5fff;" title="#5f5fff">63
</td>
<td style="color:#ffffff;background:#5f8700;" title="#5f8700">64
</td>
<td style="color:#ffffff;background:#5f875f;" title="#5f875f">65
</td>
<td style="color:#ffffff;background:#5f8787;" title="#5f8787">66
</td>
<td style="color:#ffffff;background:#5f87af;" title="#5f87af">67
</td>
<td style="color:#ffffff;background:#5f87d7;" title="#5f87d7">68
</td>
<td style="color:#ffffff;background:#5f87ff;" title="#5f87ff">69
</td>
<td style="color:#000000;background:#5faf00;" title="#5faf00">70
</td>
<td style="color:#000000;background:#5faf5f;" title="#5faf5f">71
</td>
<td style="color:#000000;background:#5faf87;" title="#5faf87">72
</td>
<td style="color:#000000;background:#5fafaf;" title="#5fafaf">73
</td>
<td style="color:#000000;background:#5fafd7;" title="#5fafd7">74
</td>
<td style="color:#000000;background:#5fafff;" title="#5fafff">75
</td>
<td style="color:#000000;background:#5fd700;" title="#5fd700">76
</td>
<td style="color:#000000;background:#5fd75f;" title="#5fd75f">77
</td>
<td style="color:#000000;background:#5fd787;" title="#5fd787">78
</td>
<td style="color:#000000;background:#5fd7af;" title="#5fd7af">79
</td>
<td style="color:#000000;background:#5fd7d7;" title="#5fd7d7">80
</td>
<td style="color:#000000;background:#5fd7ff;" title="#5fd7ff">81
</td>
<td style="color:#000000;background:#5fff00;" title="#5fff00">82
</td>
<td style="color:#000000;background:#5fff5f;" title="#5fff5f">83
</td>
<td style="color:#000000;background:#5fff87;" title="#5fff87">84
</td>
<td style="color:#000000;background:#5fffaf;" title="#5fffaf">85
</td>
<td style="color:#000000;background:#5fffd7;" title="#5fffd7">86
</td>
<td style="color:#000000;background:#5fffff;" title="#5fffff">87
</td></tr>
<tr>
<td style="color:#ffffff;background:#870000;" title="#870000">88
</td>
<td style="color:#ffffff;background:#87005f;" title="#87005f">89
</td>
<td style="color:#ffffff;background:#870087;" title="#870087">90
</td>
<td style="color:#ffffff;background:#8700af;" title="#8700af">91
</td>
<td style="color:#ffffff;background:#8700d7;" title="#8700d7">92
</td>
<td style="color:#ffffff;background:#8700ff;" title="#8700ff">93
</td>
<td style="color:#ffffff;background:#875f00;" title="#875f00">94
</td>
<td style="color:#ffffff;background:#875f5f;" title="#875f5f">95
</td>
<td style="color:#ffffff;background:#875f87;" title="#875f87">96
</td>
<td style="color:#ffffff;background:#875faf;" title="#875faf">97
</td>
<td style="color:#ffffff;background:#875fd7;" title="#875fd7">98
</td>
<td style="color:#ffffff;background:#875fff;" title="#875fff">99
</td>
<td style="color:#ffffff;background:#878700;" title="#878700">100
</td>
<td style="color:#ffffff;background:#87875f;" title="#87875f">101
</td>
<td style="color:#ffffff;background:#878787;" title="#878787">102
</td>
<td style="color:#ffffff;background:#8787af;" title="#8787af">103
</td>
<td style="color:#ffffff;background:#8787d7;" title="#8787d7">104
</td>
<td style="color:#ffffff;background:#8787ff;" title="#8787ff">105
</td>
<td style="color:#000000;background:#87af00;" title="#87af00">106
</td>
<td style="color:#000000;background:#87af5f;" title="#87af5f">107
</td>
<td style="color:#000000;background:#87af87;" title="#87af87">108
</td>
<td style="color:#000000;background:#87afaf;" title="#87afaf">109
</td>
<td style="color:#000000;background:#87afd7;" title="#87afd7">110
</td>
<td style="color:#000000;background:#87afff;" title="#87afff">111
</td>
<td style="color:#000000;background:#87d700;" title="#87d700">112
</td>
<td style="color:#000000;background:#87d75f;" title="#87d75f">113
</td>
<td style="color:#000000;background:#87d787;" title="#87d787">114
</td>
<td style="color:#000000;background:#87d7af;" title="#87d7af">115
</td>
<td style="color:#000000;background:#87d7d7;" title="#87d7d7">116
</td>
<td style="color:#000000;background:#87d7ff;" title="#87d7ff">117
</td>
<td style="color:#000000;background:#87ff00;" title="#87ff00">118
</td>
<td style="color:#000000;background:#87ff5f;" title="#87ff5f">119
</td>
<td style="color:#000000;background:#87ff87;" title="#87ff87">120
</td>
<td style="color:#000000;background:#87ffaf;" title="#87ffaf">121
</td>
<td style="color:#000000;background:#87ffd7;" title="#87ffd7">122
</td>
<td style="color:#000000;background:#87ffff;" title="#87ffff">123
</td></tr>
<tr>
<td style="color:#ffffff;background:#af0000;" title="#af0000">124
</td>
<td style="color:#ffffff;background:#af005f;" title="#af005f">125
</td>
<td style="color:#ffffff;background:#af0087;" title="#af0087">126
</td>
<td style="color:#ffffff;background:#af00af;" title="#af00af">127
</td>
<td style="color:#ffffff;background:#af00d7;" title="#af00d7">128
</td>
<td style="color:#ffffff;background:#af00ff;" title="#af00ff">129
</td>
<td style="color:#ffffff;background:#af5f00;" title="#af5f00">130
</td>
<td style="color:#ffffff;background:#af5f5f;" title="#af5f5f">131
</td>
<td style="color:#ffffff;background:#af5f87;" title="#af5f87">132
</td>
<td style="color:#ffffff;background:#af5faf;" title="#af5faf">133
</td>
<td style="color:#ffffff;background:#af5fd7;" title="#af5fd7">134
</td>
<td style="color:#ffffff;background:#af5fff;" title="#af5fff">135
</td>
<td style="color:#ffffff;background:#af8700;" title="#af8700">136
</td>
<td style="color:#ffffff;background:#af875f;" title="#af875f">137
</td>
<td style="color:#ffffff;background:#af8787;" title="#af8787">138
</td>
<td style="color:#ffffff;background:#af87af;" title="#af87af">139
</td>
<td style="color:#ffffff;background:#af87d7;" title="#af87d7">140
</td>
<td style="color:#ffffff;background:#af87ff;" title="#af87ff">141
</td>
<td style="color:#000000;background:#afaf00;" title="#afaf00">142
</td>
<td style="color:#000000;background:#afaf5f;" title="#afaf5f">143
</td>
<td style="color:#000000;background:#afaf87;" title="#afaf87">144
</td>
<td style="color:#000000;background:#afafaf;" title="#afafaf">145
</td>
<td style="color:#000000;background:#afafd7;" title="#afafd7">146
</td>
<td style="color:#000000;background:#afafff;" title="#afafff">147
</td>
<td style="color:#000000;background:#afd700;" title="#afd700">148
</td>
<td style="color:#000000;background:#afd75f;" title="#afd75f">149
</td>
<td style="color:#000000;background:#afd787;" title="#afd787">150
</td>
<td style="color:#000000;background:#afd7af;" title="#afd7af">151
</td>
<td style="color:#000000;background:#afd7d7;" title="#afd7d7">152
</td>
<td style="color:#000000;background:#afd7ff;" title="#afd7ff">153
</td>
<td style="color:#000000;background:#afff00;" title="#afff00">154
</td>
<td style="color:#000000;background:#afff5f;" title="#afff5f">155
</td>
<td style="color:#000000;background:#afff87;" title="#afff87">156
</td>
<td style="color:#000000;background:#afffaf;" title="#afffaf">157
</td>
<td style="color:#000000;background:#afffd7;" title="#afffd7">158
</td>
<td style="color:#000000;background:#afffff;" title="#afffff">159
</td></tr>
<tr>
<td style="color:#ffffff;background:#d70000;" title="#d70000">160
</td>
<td style="color:#ffffff;background:#d7005f;" title="#d7005f">161
</td>
<td style="color:#ffffff;background:#d70087;" title="#d70087">162
</td>
<td style="color:#ffffff;background:#d700af;" title="#d700af">163
</td>
<td style="color:#ffffff;background:#d700d7;" title="#d700d7">164
</td>
<td style="color:#ffffff;background:#d700ff;" title="#d700ff">165
</td>
<td style="color:#ffffff;background:#d75f00;" title="#d75f00">166
</td>
<td style="color:#ffffff;background:#d75f5f;" title="#d75f5f">167
</td>
<td style="color:#ffffff;background:#d75f87;" title="#d75f87">168
</td>
<td style="color:#ffffff;background:#d75faf;" title="#d75faf">169
</td>
<td style="color:#ffffff;background:#d75fd7;" title="#d75fd7">170
</td>
<td style="color:#ffffff;background:#d75fff;" title="#d75fff">171
</td>
<td style="color:#ffffff;background:#d78700;" title="#d78700">172
</td>
<td style="color:#ffffff;background:#d7875f;" title="#d7875f">173
</td>
<td style="color:#ffffff;background:#d78787;" title="#d78787">174
</td>
<td style="color:#ffffff;background:#d787af;" title="#d787af">175
</td>
<td style="color:#ffffff;background:#d787d7;" title="#d787d7">176
</td>
<td style="color:#ffffff;background:#d787ff;" title="#d787ff">177
</td>
<td style="color:#000000;background:#d7af00;" title="#d7af00">178
</td>
<td style="color:#000000;background:#d7af5f;" title="#d7af5f">179
</td>
<td style="color:#000000;background:#d7af87;" title="#d7af87">180
</td>
<td style="color:#000000;background:#d7afaf;" title="#d7afaf">181
</td>
<td style="color:#000000;background:#d7afd7;" title="#d7afd7">182
</td>
<td style="color:#000000;background:#d7afff;" title="#d7afff">183
</td>
<td style="color:#000000;background:#d7d700;" title="#d7d700">184
</td>
<td style="color:#000000;background:#d7d75f;" title="#d7d75f">185
</td>
<td style="color:#000000;background:#d7d787;" title="#d7d787">186
</td>
<td style="color:#000000;background:#d7d7af;" title="#d7d7af">187
</td>
<td style="color:#000000;background:#d7d7d7;" title="#d7d7d7">188
</td>
<td style="color:#000000;background:#d7d7ff;" title="#d7d7ff">189
</td>
<td style="color:#000000;background:#d7ff00;" title="#d7ff00">190
</td>
<td style="color:#000000;background:#d7ff5f;" title="#d7ff5f">191
</td>
<td style="color:#000000;background:#d7ff87;" title="#d7ff87">192
</td>
<td style="color:#000000;background:#d7ffaf;" title="#d7ffaf">193
</td>
<td style="color:#000000;background:#d7ffd7;" title="#d7ffd7">194
</td>
<td style="color:#000000;background:#d7ffff;" title="#d7ffff">195
</td></tr>
<tr>
<td style="color:#ffffff;background:#ff0000;" title="#ff0000">196
</td>
<td style="color:#ffffff;background:#ff005f;" title="#ff005f">197
</td>
<td style="color:#ffffff;background:#ff0087;" title="#ff0087">198
</td>
<td style="color:#ffffff;background:#ff00af;" title="#ff00af">199
</td>
<td style="color:#ffffff;background:#ff00d7;" title="#ff00d7">200
</td>
<td style="color:#ffffff;background:#ff00ff;" title="#ff00ff">201
</td>
<td style="color:#ffffff;background:#ff5f00;" title="#ff5f00">202
</td>
<td style="color:#ffffff;background:#ff5f5f;" title="#ff5f5f">203
</td>
<td style="color:#ffffff;background:#ff5f87;" title="#ff5f87">204
</td>
<td style="color:#ffffff;background:#ff5faf;" title="#ff5faf">205
</td>
<td style="color:#ffffff;background:#ff5fd7;" title="#ff5fd7">206
</td>
<td style="color:#ffffff;background:#ff5fff;" title="#ff5fff">207
</td>
<td style="color:#ffffff;background:#ff8700;" title="#ff8700">208
</td>
<td style="color:#ffffff;background:#ff875f;" title="#ff875f">209
</td>
<td style="color:#ffffff;background:#ff8787;" title="#ff8787">210
</td>
<td style="color:#ffffff;background:#ff87af;" title="#ff87af">211
</td>
<td style="color:#ffffff;background:#ff87d7;" title="#ff87d7">212
</td>
<td style="color:#ffffff;background:#ff87ff;" title="#ff87ff">213
</td>
<td style="color:#000000;background:#ffaf00;" title="#ffaf00">214
</td>
<td style="color:#000000;background:#ffaf5f;" title="#ffaf5f">215
</td>
<td style="color:#000000;background:#ffaf87;" title="#ffaf87">216
</td>
<td style="color:#000000;background:#ffafaf;" title="#ffafaf">217
</td>
<td style="color:#000000;background:#ffafd7;" title="#ffafd7">218
</td>
<td style="color:#000000;background:#ffafff;" title="#ffafff">219
</td>
<td style="color:#000000;background:#ffd700;" title="#ffd700">220
</td>
<td style="color:#000000;background:#ffd75f;" title="#ffd75f">221
</td>
<td style="color:#000000;background:#ffd787;" title="#ffd787">222
</td>
<td style="color:#000000;background:#ffd7af;" title="#ffd7af">223
</td>
<td style="color:#000000;background:#ffd7d7;" title="#ffd7d7">224
</td>
<td style="color:#000000;background:#ffd7ff;" title="#ffd7ff">225
</td>
<td style="color:#000000;background:#ffff00;" title="#ffff00">226
</td>
<td style="color:#000000;background:#ffff5f;" title="#ffff5f">227
</td>
<td style="color:#000000;background:#ffff87;" title="#ffff87">228
</td>
<td style="color:#000000;background:#ffffaf;" title="#ffffaf">229
</td>
<td style="color:#000000;background:#ffffd7;" title="#ffffd7">230
</td>
<td style="color:#000000;background:#ffffff;" title="#ffffff">231
</td></tr>


<tr>
<td colspan="36"><font color="black">灰度色</font>
</td></tr>
<tr>
<td colspan="36">
<table style="width:100%;text-align:center;font-weight:bold;">

<tbody><tr>
<td style="color:#ffffff;background:#080808;" title="#080808">232
</td>
<td style="color:#ffffff;background:#121212;" title="#121212">233
</td>
<td style="color:#ffffff;background:#1c1c1c;" title="#1c1c1c">234
</td>
<td style="color:#ffffff;background:#262626;" title="#262626">235
</td>
<td style="color:#ffffff;background:#303030;" title="#303030">236
</td>
<td style="color:#ffffff;background:#3a3a3a;" title="#3a3a3a">237
</td>
<td style="color:#ffffff;background:#444444;" title="#444444">238
</td>
<td style="color:#ffffff;background:#4e4e4e;" title="#4e4e4e">239
</td>
<td style="color:#ffffff;background:#585858;" title="#585858">240
</td>
<td style="color:#ffffff;background:#626262;" title="#626262">241
</td>
<td style="color:#ffffff;background:#6c6c6c;" title="#6c6c6c">242
</td>
<td style="color:#ffffff;background:#767676;" title="#767676">243
</td>
<td style="color:#000000;background:#808080;" title="#808080">244
</td>
<td style="color:#000000;background:#8a8a8a;" title="#8a8a8a">245
</td>
<td style="color:#000000;background:#949494;" title="#949494">246
</td>
<td style="color:#000000;background:#9e9e9e;" title="#9e9e9e">247
</td>
<td style="color:#000000;background:#a8a8a8;" title="#a8a8a8">248
</td>
<td style="color:#000000;background:#b2b2b2;" title="#b2b2b2">249
</td>
<td style="color:#000000;background:#bcbcbc;" title="#bcbcbc">250
</td>
<td style="color:#000000;background:#c6c6c6;" title="#c6c6c6">251
</td>
<td style="color:#000000;background:#d0d0d0;" title="#d0d0d0">252
</td>
<td style="color:#000000;background:#dadada;" title="#dadada">253
</td>
<td style="color:#000000;background:#e4e4e4;" title="#e4e4e4">254
</td>
<td style="color:#000000;background:#eeeeee;" title="#eeeeee">255
</td></tr></tbody></table>
</td></tr></tbody></table>

### 24 bit (RGB颜色)

`Xterm`,KDE 的 `Konsole`, 以及所有支持 `libvte` 的终端(包括 GNOME Terminal) 上支持

可以使用 `\x1b[38;2;<r>;<g>;<b> … m` 选择RGB前景色

可以使用 `\x1b[48;2;<r>;<g>;<b> … m` 选择RGB背景色

## END

那么现在可以在终端里好好玩一玩了
![](/assets/ControlSequences.png)

## 参考源

1. [GNU Control Sequences](https://www.gnu.org/software/screen/manual/html_node/Control-Sequences.html)  
1. [ubuntu manpages console_codes.4](http://manpages.ubuntu.com/manpages/bionic/zh_CN/man4/console_codes.4.html)  
1. [字符编解码的故事（ASCII，ANSI，Unicode，Utf-8区别）](http://www.imkevinyang.com/2009/02/%E5%AD%97%E7%AC%A6%E7%BC%96%E8%A7%A3%E7%A0%81%E7%9A%84%E6%95%85%E4%BA%8B%EF%BC%88ascii%EF%BC%8Cansi%EF%BC%8Cunicode%EF%BC%8Cutf-8%E5%8C%BA%E5%88%AB%EF%BC%89.html)  
1. [关于字符编码，你所需要知道的（ASCII,Unicode,Utf-8,GB2312…）](http://www.imkevinyang.com/2010/06/%E5%85%B3%E4%BA%8E%E5%AD%97%E7%AC%A6%E7%BC%96%E7%A0%81%EF%BC%8C%E4%BD%A0%E6%89%80%E9%9C%80%E8%A6%81%E7%9F%A5%E9%81%93%E7%9A%84.html)  
1. [zh wikipedia ANSI转义序列](https://zh.wikipedia.org/wiki/ANSI%E8%BD%AC%E4%B9%89%E5%BA%8F%E5%88%97)   
1. [en wikipedia ANSI escape code](https://en.wikipedia.org/wiki/ANSI_escape_code)  
1. [DukeAnt/ANSI转义码](https://zh.wikipedia.org/wiki/User:DukeAnt/ANSI%E8%BD%AC%E4%B9%89%E7%A0%81)
1. [C0与C1控制字符](https://zh.wikipedia.org/wiki/C0%E4%B8%8EC1%E6%8E%A7%E5%88%B6%E5%AD%97%E7%AC%A6)
1. [console_codes (4) - Linux Man Pages](https://www.systutorials.com/docs/linux/man/4-console_codes/)
1. [ISO/IEC 2022](https://zh.wikipedia.org/wiki/ISO/IEC_2022)

Author: Amatist Kurisu