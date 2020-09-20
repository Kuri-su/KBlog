
[TOC]

双拼是汉语拼音输入法的一种编码方案。相对于全拼而言，使用双拼输入汉字时只需输入一个代表声母的字母，一个代表韵母的字母，就可以打出任意一个中文单字了。(来自 Wiki)

双拼相比全拼有明显的输入速度上的优势, 以 `窗` 这个字为例, 全拼 需要将 `chuang` 分六次输入才能 打出来 窗 这个字, 而 双拼只需要 `il`, 两次输入就可以打出来.

但代价也是显而易见的, 有较高的上手成本, 通常 双拼有一个键位图, 说明各个键和 要输入的单元之间的 键位关系. 各个双拼方案之间不一样, 下面这个是小鹤双拼方案的 键位图

![](https://upload.wikimedia.org/wikipedia/commons/9/94/FlyPY_Double_Pinyin_Scheme.png)

在形成肌肉记忆之后, 输入速度会有明显的提升, 特别是在 大量文字输入的场景下.

## Get Start

因为笔者日常工作的平台主要在 Linux Desktop 上, 输入法用 fctix-rime , 所以, 下面就只介绍在 rime 下如何安装并切换到小鹤双拼.

这里顺路给 Rime 输入法 打个广告, ~~高贵的~~ 开源输入法, 全平台适配, Rime 中文全称叫做 `中州韻輸入法引擎` ,Windows 下的实现叫 `小狼毫(Weasel)`, MacOS 的实现叫 `鼠鬚管(Squirrel)`, Linux 有分别基于 ibus 和 fctix 的两种实现. 此外还有 Android 版本, 详情可以访问 [Rime 官网](rime.im)

特点在于完全开源, 相关配置用户可以高度自定义, 缺点也很明显, 配置复杂. 不过即便你不配置也可以很快乐的使用 XD

### Install

这里只演示 `小鹤双拼`, 其他例如 `自然码` 之类的 方案也是类似

```shell
# Arch || Manjaro 已经自带双拼方案 
# Ubuntu
$ sudo apt-get insatll librime-data-double-pinyin
# 别的平台应该是 下载安装包即可, 详情可以自行 Google :)
```

### Config File

可以参考 rime 主要维护者的 [Gist Link](https://gist.github.com/lotem/2309739), 下面设置将为你打开 小鹤双拼方案 的切换选项.

Linux 下在 `~/.config/ibus/rime/default.custom.yaml` 中添加如下 配置, 如果你是 Windows , 配置文件在 **%APPDATA%\Rime\default.custom.yaml**, MacOS 在 **~/Library/Rime/default.custom.yaml**

```yaml
patch:
  schema_list:
    - schema: luna_pinyin          # 朙月拼音
    - schema: luna_pinyin_simp     # 朙月拼音 简化字模式
    - schema: luna_pinyin_tw       # 朙月拼音 臺灣正體模式
    - schema: terra_pinyin         # 地球拼音 dì qiú pīn yīn
    - schema: double_pinyin_flypy  # 小鶴雙拼
#    - schema: bopomofo             # 注音
#    - schema: bopomofo_tw          # 注音 臺灣正體模式
#    - schema: jyutping             # 粵拼
#    - schema: cangjie5             # 倉頡五代
#    - schema: cangjie5_express     # 倉頡 快打模式
#    - schema: quick5               # 速成
#    - schema: wubi86               # 五笔 86
#    - schema: wubi_pinyin          # 五笔拼音混合輸入
#    - schema: double_pinyin        # 自然碼雙拼
#    - schema: double_pinyin_mspy   # 微軟雙拼
#    - schema: double_pinyin_abc    # 智能 ABC 雙拼
#    - schema: wugniu        # 吳語上海話（新派）
#    - schema: wugniu_lopha  # 吳語上海話（老派）
#    - schema: sampheng      # 中古漢語三拼
#    - schema: zyenpheng     # 中古漢語全拼
#    - schema: ipa_xsampa    # X-SAMPA 國際音標
#    - schema: emoji         # emoji 表情
```

### Use

切换到 Rime 输入法, 然后按下键盘上的按键 `F4`, 就会弹出一个方案选择, 翻页找到 小鹤双拼 即可

## What's Next

切换好之后, 就是练习的时间, 你可以找一些网站, 练习 双拼打字, 或者 把 双拼 键位图摆在旁边来写博客 之类的.

在形成肌肉记忆之后, 享受飞速打字的快感吧~

> 虽然这篇文章还是用 全拼 打出来的 2333