{"title":"ANSI 终端输出瞎搞指北","description":"今天我克里斯就是要在终端上画彩虹猫","category":"Linux","tag":["ANSI","just fun"],"page_image":"/assets/ControlSequences_index.png"}

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

指令原语|实际使用|效果
-|-|-|
ESC c|\x1bc|类似于 Linux 命令 `clear`|
ESC D|\x1bD|换行. 类似于打字机直接向下挪了一行,而没有将打印位置初始化到行首
ESC E|\x1bE|类似于 `\n` , 换行并将打印位置初始化到行首
ESC H|\x1bH|类似于 `\t`
ESC M|\x1bM|翻转换行(Reverse line feed) 正向换行是到下一行,翻转换行则是去到上一行. 还是想象打印机时代XD [What is a reverse line feed - stackoverflow](https://stackoverflow.com/questions/10638382/what-is-a-reverse-line-feed)
**ESC [**|**\x1b[... 或者 \x9d...**|**`将在下面 控制序列(CSI) 的位置介绍`,等价于 `C1 控制字符` 中的 `CSI`**
ESC % G|\x1b%G|选择 UTF-8 作为字符集
ESC # 8|\x1b#8|DEC 屏幕校准测试,使用 `E` 填充整个终端屏幕

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
最终字节|0x40–0x7E|@A–Z[\]^_`a–z{}~

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

更加详细的 `CSI 参数列表` 参见 结尾附录

### SGR 参数

列举常用以及广泛支持的参数,

指令原语|实际使用|效果|更多例子|备注
-|-|-|-|-
0|\x1b[0m|所有属性重设为默认值|`\x1b[38;2;215;84;85m Hello World \x1b[0m`|一般都用这个参数取消对后面字符串样式的影响
1|\x1b[1m|设置粗体|`\x1b[1m Hello World \x1b[0m`|
2|\x1b[2m|将亮度减半|`\x1b[2m Hello World \x1b[0m`例如这样就会看到 `灰色` 的 Hello World|
4|\x1b[4m|设置下划线|`\x1b[4m Hello World \x1b[0m`|文字会带下划线
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

使用 `\x1b[31;102m` 设置 前景色为红色,背景色为亮绿色  

使用 `\x1b[1;5;31;102m` 设置 前景色为红色,背景色为亮绿色, 粗体,并闪烁

3/4 的颜色表如下(照搬 WIKI):

> 部分平台上 可能 30-37 和 90-97 显示的是同一种颜色,因平台而异

![](/assets/ControlSequences_16_color_table.png)
## 8bit (256 色)

可以使用 `\x1b[38;5;51m` 输出前景色为 编号 51 的 `#5f00ff` 的字符串 (大概是紫色)

可以使用 `\x1b[48;5;51m` 输出背景色为 编号 51 的 `#5f00ff` 的字符串

下面是一些例子(直接在 Terminal 中运行即可):
```bash
echo -e "\x1b[38;5;214m\x1b[48;5;239m ssss\x1b[0m"  # 输出 前景色为 256色 214 , 背景色为 256色 239 的样式

```

颜色表如下(来自 WIKI , 链接见文末)

![](/assets/ControlSequences_8bit_color_table.png)

### 24 bit (RGB颜色)

在 `Xterm`,KDE 的 `Konsole`, 以及所有支持 `libvte` 的终端 (包括 GNOME Terminal) 上支持

可以使用 `\x1b[38;2;<r>;<g>;<b> … m` 选择RGB前景色

可以使用 `\x1b[48;2;<r>;<g>;<b> … m` 选择RGB背景色

## END

那么现在可以在终端里好好玩一玩了
![](/assets/ControlSequences_index.png)

参考代码 :
```go
package main

import (
    "fmt"
    "strconv"
)

func main() {
    flag := 0
    str := "KURISU "
    for r := 255; r >= 0; r -= 2 {
        for g, b := 0, 255; g < 255 && b >= 1; g += 1 {
            if flag >= len(str) {
                flag = 0
            }
            a := str[flag]
            flag++
            fmt.Printf("\x1b[48;2;%s;%s;%sm\x1b[38m%s\x1b[0m", strconv.Itoa(r), strconv.Itoa(g), strconv.Itoa(b), string(a))
            b -= 1
        }
        fmt.Printf("\x1bE")
    }
}
```

## 附录

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
CSI `n` ; `m` f | HVP – 水平垂直位置（Horizontal Vertical Position） | 同CUP。
**CSI `n` m** | **SGR – 选择图形再现（Select Graphic Rendition）** | **设置SGR参数，包括文字颜色。CSI后可以是0或者更多参数，用分号分隔。如果没有参数，则视为`CSI 0 m`（重置/常规）**。
CSI 5i | 打开辅助端口 | 启用辅助串行端口，通常用于本地串行打印机
CSI 4i | 关闭辅助端口 | 禁用辅助串行端口，通常用于本地串行打印机
CSI 6n | DSR – 设备状态报告（Device Status Report） | 以`ESC[n;mR`（就像在键盘上输入）向应用程序报告光标位置（CPR），其中`n`是行，`m`是列。
CSI s | SCP – 保存光标位置（Save Cursor Position） | 保存光标的当前位置。
CSI u | RCP – 恢复光标位置（Restore Cursor Position） | 恢复保存的光标位置。

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
