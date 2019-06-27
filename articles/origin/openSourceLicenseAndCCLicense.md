{"title": "程序员的 开源许可 和 CC 许可 说明书","description": "开源许可 和 CC 许可 简易介绍和使用教程","category": "linux","tag": ["License"],"page_image":"/assets/open_source_license_and_CC_license_main_image.png"}

# 程序员的 开源许可 和 CC 许可 说明书

## Copyright

Copyright 也就是 ` 版权 `, 我们拥有我们创作的软件的全部内容的版权, 都归属于 创作者 所有. 这意味着 别人想要 复制 / 分发 / 修改 你的软件都需要你的许可. 但是可能有些情况下我们完全不 Care 这个软件的版权, 或者我们乐意看到别人在我们的基础上进行修改和翻译. 但又不希望每一次都需要进行对话来授权, 所以就有了 `Copyleft`.

<center>
<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Copyright.svg/1024px-Copyright.svg.png"/>
</center>
Copyleft 的提出 源自 ` 自由软件运动 `, 是一种利用现有 著作权 体制来保障用户软件自由使用的许可方式. 用简单的话说 Copyleft 就是 ` 用户可以在创作者的许可许可下, 自由的 使用 / 分发 / 修改 `, 这样就免去了很多的沟通成本, 并且最重要的是, 这在 不反对 原有的著作权法的基础上, 进一步的促进**创作自由**, 与保障著作内容的传播.

<center>
<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/8b/Copyleft.svg/1024px-Copyleft.svg.png"/>
</center>

Copyleft 起初是在由 `GNU 项目 ` 提出并使用, 到实际使用中也就是我们在开源软件时候所选择的各种许可, 例如 `GPLv3`, `MIT`, `Mozilla Public License 2.0` 等等. 这里比较有意思的是, `Copyleft` 不仅名字和 版权的英文 `CopyRight` 是反过来的, 图标 也是 版权标志的 C 朝向左边.

<center>
<image style="height: 300px;" src="https://w.wallhaven.cc/full/n6/wallhaven-n6gv2l.jpg"/>
</center>

在 2001 年, 拥有和 Copyleft 同样理念的 CC 许可 (Creative Commons)出现, 提倡 ` 著作物可以更广的流通和修改, 可使他人据以创作及共享, 并以所提供的许可方式保障以上理念 `, 目前常用于 公开的文章 的版权声明.


<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/86/CC-logo.svg/1920px-CC-logo.svg.png"/>

---

下面详细的介绍 CC 许可 和 常见的开源许可 :


## 常见的开源许可

此处介绍的开源许可都有以下特性, 
* 没有使用限制
    * 用户可以使用代码，做任何想做的事情。
* 没有担保
    * 不保证代码质量，用户自担风险。
* 披露要求
    * 用户必须披露原始作者

此处参考 阮一峰老师 的观点, 根据使用条件的不同, 将 开源许可 分成两大类
* `宽松式 (permissive) 许可`
* `Copyleft 许可`

### 宽松式 许可

#### MIT

MIT 许可许可 来自 麻省理工学院, 与GPL兼容, 可以与 GPL 作品融合

用户只需要遵守这一个义务, 就可以任意的使用该软件, 甚至可以使用原作者的名字来进行软件促销,又或者是可以修改源码后闭源.
* 所有的副本中都要包含该 License 文件 (Wiki 上说是包括著作权声明和本许可声明, 但是其实他们都写在了这个 License 文件里, 例如末尾的 MIT 样例)

同时 最初作者(版权者) 可以根据自己的需求修改 License 原文的内容再发布, 这和 GPL 系列等许可很不同, GPL 系列许可 是不允许 版权者 修改 License 原文内容的.
但是因为这个特性, 所以有可能 版权者 会在 License 中添加更多的约束, 出现很多变种. 例如 FSF 为 [ncurses](https://github.com/mirror/ncurses/blob/master/COPYING) 的 X11 许可(MIT 变种)中, 就不允许 使用 原作者的名字作为广告宣传或者促销. 所以对使用 MIT 许可的项目, 可能需要检查一下他的 License 内容.

到 2015 年为止, 是 Github 上最受欢迎的 许可方式, 使用过 MIT License 的项目包括 `Node.js`, `Nim`, `Ruby on Rails` 等

#### BSD 

BSD 开源许可的全称 是 `Berkeley Software Distribution` , 来自 加州大学伯克利分校, BSD 有 3 目前还在使用的许可,以及 1 种已经消失在历史的长河中的许可, 
* 已经不再使用的许可
    * BSD-4-Clause License (BSD 四句许可)
* 目前还在使用的许可
    * BSD-3-Clause License (BSD 三句许可)
    * BSD-2-Clause License (BSD 二句许可)
    * BSD-0-Clause License (BSD 零句许可)

BSD 许可后面的序号代表的是这个许可有几句,例如 BSD 4 的许可就长这样.

```
* Copyright (c) 1982, 1986, 1990, 1991, 1993
* 著作权由加州大学董事会所有。著作权人保留一切权利。
* 
* 这份授权条款，在使用者符合以下四条件的情形下，授予使用者使用及再散播本
* 软件包装原始码及二进位可执行形式的权利，无论此包装是否经改作皆然：
* 
* 1. 对于本软件源代码的再散播，必须保留上述的版权宣告、此四条件表列，以
*    及下述的免责声明。
* 2. 对于本套件二进位可执行形式的再散播，必须连带以文件以及／或者其他附
*    于散播包装中的媒介方式，重制上述之版权宣告、此四条件表列，以及下述
*    的免责声明。
* 3. 所有提及本软件功能或是本软件使用之宣传材料，都必须包还含下列之交
*    待文字：
*        “本产品内含有由柏克莱加州大学及其软件贡献者所开发的软件。”
* 4. 未获事前取得书面许可，不得使用柏克莱加州大学或本软件贡献者之名称，
*    来为本软件之衍生物做任何表示支持、认可或推广、促销之行为。
* 
* 免责声明：本软件是由加州大学董事会及本软件之贡献者以现状（"as is"）提供.... <省略>

```

这个许可看起来其实就是MIT许可再增加第三条和第四条, 但是正是因为其中的第三条导致该许可遭到反对. `所有提及本软件功能或是本软件使用之宣传材料，都必须本产品内含有由柏克莱加州大学及其软件贡献者所开发的软件`, 如果这个程序只拥有 一个 BSD-4 许可的依赖倒还好, 只需要一行致谢. 但是如果是依赖了大量 BSD-4 许可的软件, 那致谢名单简直就是灾难了.... 想象一下, 网站最下方很长很长的一段都是致谢名单,并且, 这些致谢名单需要程序员自己通过脚本或者肉眼统计并添加.

1997年的NetBSD版本中统计了75个这样的致谢.同时 这个条款于 GNU GPL 不兼容.所以在 1999 年, 很多的 BSD 许可的版权者删除了 BSD-4 中的第三句, 新的许可被称为 BSD-3(-Clause) 或者 BSD-new.

之后在 FreeBSD 中使用的是更简单的 BSD-2 许可, 在原本 BSD-3 的基础上删除了第三句, 也就是上面 BSD-4 中的第四句. 这一版本的 BSD 许可和 MIT 许可基本一致.

在此之后也出现了 BSD-0, 不过较少人使用该许可. BSD-0 在 BSD-2 的基础上删除了许可的第一句和第二句, 仅保留版权声明和免责声明. 

以上就是 BSD 的发展过程, BSD-4许可 修改后的 BSD-3 和 BSD-2 是与GPL相容的许可

#### Apache

Apache 许可来自 `Apache软件基金会` , 起初作为 Apache 基金会下所有项目的开源许可, 后来许多非 Apache 基金会项目也是用了 Apache 许可.

Apache 许可和我们刚刚提到的各种许可相比相对严格, 它允许用户 自由使用/分发/商用/修改 软件,  但是需要遵守下面的规范.

首先 Apache Public License 的声明不是写在 License 文件中, 所以你需要在每个文件的开头添加一份通告,否则就不是有效的声明 类似于下面这样:
```
Copyright [yyyy] [name of copyright owner]
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

或者你也可以参考 Swoole 项目, 使用自定义的通告,
/*
  +----------------------------------------------------------------------+
  | Swoole                                                               |
  +----------------------------------------------------------------------+
  | This source file is subject to version 2.0 of the Apache license,    |
  | that is bundled with this package in the file LICENSE, and is        |
  | available through the world-wide-web at the following url:           |
  | http://www.apache.org/licenses/LICENSE-2.0.html                      |
  | If you did not receive a copy of the Apache2.0 license and are unable|
  | to obtain it through the world-wide-web, please send a note to       |
  | license@swoole.com so we can mail you a copy immediately.            |
  +----------------------------------------------------------------------+
  | Author: Tianfeng Han  <mikan.tenny@gmail.com>                        |
  +----------------------------------------------------------------------+
*/
```

其次, 除了要在根目录下放置 License 文件外, 还需要放置一个 NOTICE 文件, 放置 通告声明以及项目中用到的全部的第三方库的名字, 最好可以加上作者名字和项目地址. 同时你必须验证这些第三方库的许可和 Apache 2.0 相容.同时如果你修改了这些第三方库, 则要指出进行了何种修改.

最后如果你需要修改再发布一个 Apache 许可的软件, 你需要明确指出进行了何种修改.


### 题外话

#### Do What The F*ck You Want To Public License

介绍完 `宽松式许可` 后, 如果还没看累的话, 这里介绍一个比较有意思的许可, `Do What The F*ck You Want To Public License`, 翻译成 中文就是, `你TXD的想干嘛就干嘛公共许可证` :joy: , 该许可只包含版权声明, 以及一条约束
* 如果修改了本许可, 必须修改许可名称

该许可基本就等于直接贡献到 公有领域. 该许可与 GPL 相容.

笔者的[毕设](https://github.com/Kuri-su/CAPTCHA_Reader) 最初用的 MIT 许可, 在看到这个有趣的许可后就转到该许可了:joy:.

### Copyleft 许可

#### GPL

GPL 系列许可 来自 FSF (自由软件基金会), 初衷是给予终端用户 运行|学习|共享|修改 软件的自由, 极力的避免自由软件私有化. 同时 GPL 许可也包含 免责条款 以及 不为软件提供品质担保.

<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/GPLv3_Logo.svg/200px-GPLv3_Logo.svg.png"/>

GPL 许可相比 前面提到的 MIT 和 BSD 许可 复杂很多(毕竟一篇几百行的文章:joy:). 总结一下, GPL 有三个特点:
1. 任何软件, 只要使用了 GPL 许可保护的软件(或者第三方库), 且向非开发人员发布时, 软件本身也就自动成为受 GPL 保护并且约束的. (GPL 许可原文第 5 部分, 描述集合的那段)
1. 如果对 GPL 许可保护下的源代码进行修改, 则修改后发布的源代码必须也使用 GPL 许可,而且不允许附加其他限制.
1. 使用 GPL 许可保护的软件向非开发人员发布(二进制包)时, 必须公开源码.(GPL 许可原文第 6 部分)

除了这三点之外, GPL 的 License 文本是不允许修改的. 所以如果在你的项目要使用 GPL 协议的话,也需要像 Apache 许可 那样, 在每个文件中添加类似于这样子的内容的版权声明. 你需要修改下文 尖括号的部分 的部分.

```go
/*
    # 版权声明
    This file is part of <Foobar>.
    Copyright (C) <year>  <name of author>

    # 使用 GPL 许可声明
    <Foobar> is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
```

所以 只要使用了 GPL 的包 , 就必须公开源代码, 而且也会变成 GPL 的一员. 这也就是被吐槽的 GPL许可 是一种丧尸病毒 :joy:.

![ex](http://xkcd.in/resources/compiled_cn/00dbc7dec5e18740909f4cf1b0f9c6db.png) 

除此之外, GPL 不限制商用. 甚至允许在 转发完整副本 时, 可以选择收取一定金额, 也可以选择提供技术支持或品质担保以换取收入.

我们看到 对于 软件分发模式 的商业模式(例如微软), GPL 可以很好的约束. 但是随着 Google,AWS 等云服务商的兴起, GPL 开始出现漏洞. 因为他们本身不发布软件, 而是利用软件在云端提供服务,但 GPL 生效的前提是 `发布` 软件, 这种方式绕开了 GPL 所定义的约束. 因此为了避免这个漏洞, 而提出了 AGPL 许可.

##### AGPL

AGPL 的全称是 `GNU Affero General Public License` , 是对 GPL 的一个补充, 他避免了 GPL 和 LGPL 的一个漏洞. 主要针对各种云服务商.

<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/AGPLv3_Logo.svg/200px-AGPLv3_Logo.svg.png"/>

AGPL 由 Affero 公司发起, 目前发展到 v3, 和 GPL 的版本对应. AGPL 继承了 GPL 全部的条款, 同时在此基础上增加了一条.

```
如果其许可下的软件与用户通过网络进行交互，那么就需要提供源代码给用户，所有的修改也同样要提供给用户。
```

在自己的项目中使用 AGPL 许可发布, 基本和 使用 GPL 许可发布一样, 唯一的不同是 License 需要使用 [AGPL](https://www.gnu.org/licenses/agpl.txt) 的 License.

##### LGPL

LGPL 全称 `GNU Lesser General Public License`, 顾名思义, 是一个弱化的 GPL 许可. LGPL 允许软件通过类库引用(link)方式使用 LGPL 类库而不需要开源软件的代码. 除此之外, 在其他部分保持和 GPL 一致.

通过这种方式, LGPL 减低了 传染性.

使用 LGPL 的方式和 GPL 类似, 不过你需要复制一份 [LGPL](https://www.gnu.org/licenses/lgpl.txt) 的纯文本版, 放在叫做 COPYING.LESSER 的文件中.(也就是说, 总体上你需要复制两份文件, 一份 GPL 许可的纯文本版, 一份 LGPL 的纯文本版)

<image style="height: 100px;" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/LGPLv3_Logo.svg/160px-LGPLv3_Logo.svg.png"/>


### 总结

除了上面到的这些,还有 BSL, MPL, EPL 等的开源许可.

## CC 许可 (Creative Commons 常简称 CC 许可)

我们常常会在一些网站上看到 类似于下图这样的图标.

![ex](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)

它就是 CC 许可 声明, CC 许可是一种 ` 公共著作权许可许可 ` , CC 许可规定了四种 基本元素

* 署名 (BY)
    * 用户在使用该作品的同时, 需要 ` 按照作者指定的方式对作品进行许可 `
* 非商业使用 (NC)
    * 用户在使用该作品的同时, 不得以商业目的使用该作品
* 禁止演绎 (ND)
    * 用户在使用该作品的同时, 不得修改该作品
* 相同方式共享 (SA)
    * 用户在使用该作品的同时, 如果你修改 (派生) 了该作品, 在散播派生作品的同时需要遵守许可,

可以使用以上四种元素进行任意组合, 得到多种许可许可, 不过因为 ND 和 SA 是互斥的两种许可, 所以通常只有 11 种有效许可.

同时外加一种 `CC 0` 许可, 采用该许可即代表作者宣布放弃该作品的一切版权，该作品进入共有领域。:joy:

### 关于 CC 许可的版本

细心的同学会注意到, 这个博客的博文也使用了 CC 许可, 后面带有 4.0 的字样. 是的, CC 许可也存在版本, 不过对于使用者来说基本没有太大区别.

最新的 4.0 版（于 2013 年 11 月 25 日发布）不需要移植就可以适用于各地的法律，4.0 版并不鼓励移植，而是希望能作为一个全球通用的许可方式。有兴趣的话可以查看各个版本原文, 这里给出 `by-nc-sa` 各版本的 CC 许可的原文链接.

* [1.0](https://creativecommons.org/licenses/by-nc-sa/1.0/legalcode)
* [2.0](https://creativecommons.org/licenses/by-nc-sa/2.0/legalcode)
* [3.0](https://creativecommons.org/licenses/by-nc-sa/3.0/legalcode)
* [4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode)


### 一些小技巧

如果你需要在你的网站挂上 CC 许可的图标, 只需要修改下面这个 URL 的许可种类部分即可, 也就是 `by-nc-sa` , 通常的顺序是 by -> nc -> nd/sa ,
```
https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png
```

## 结

网络上有非常多的关于开源许可和CC许可的介绍,不过个人感觉介绍的有些片面而且分散,且自己理解的不是很明白,  希望自己能总结并记录下来, 也希望读者可以根据这篇文章比较系统的了解到开源许可和他们之间的不同,在为自己的项目挑选许可的时候不再犹豫.

由于作者并不是法律专业, 对于这些许可的了解来自互联网, 难免有错误的理解和疏漏. 有任何的错误,欢迎到 [kuri-su/KBlog](https://github.com/Kuri-su/KBlog/issues) 提　Issue 敦促作者修改.

这篇文章写的相当累...主要自己不太懂..然后各种资料也比较少...大段的都是法律文书类的..看的非常费劲....

> PS: 
> 撸完这篇文章, 也算是了了个心结... 每次自己的开源项目选开源许可的时候, 不重要的选 MIT, 重要的选 GPL_V3 , 文章的 CC 许可写 by-nc-nd-sa :joy:, 终于可以肯定的选择自己需要的许可了 (擦眼泪).

> Ref:
> 
> https://opensource.org/licenses/alphabetical
>
> https://opensource.org/licenses/category
>
> https://zh.wikipedia.org/wiki/%E8%91%97%E4%BD%9C%E6%AC%8A
>
> https://zhuanlan.zhihu.com/p/20641764
>
> https://creativecommons.org/choose/
>
> https://zh.wikipedia.org/wiki/%E7%9F%A5%E8%AF%86%E5%85%B1%E4%BA%AB
>
> https://zh.wikipedia.org/wiki/%E7%9F%A5%E8%AF%86%E5%85%B1%E4%BA%AB%E8%AE%B8%E5%8F%AF%E5%8D%8F%E8%AE%AE#cite_note-3
>
> https://zh.wikipedia.org/wiki/Copyleft
>
> http://freetstar.com/e79086e8a7a3e78988e69d83e5928ce8aeb8e58fafe58d8fe8aeae
>
> https://choosealicense.com/
>
> https://www.zhihu.com/question/51222514
>
> https://zh.wikipedia.org/wiki/Affero%E9%80%9A%E7%94%A8%E5%85%AC%E5%85%B1%E8%AE%B8%E5%8F%AF%E8%AF%81
>
> https://zh.wikipedia.org/wiki/MIT%E8%A8%B1%E5%8F%AF%E8%AD%89
>
> https://en.wikipedia.org/wiki/Apache_License
>
> https://univasity.iteye.com/blog/1292658
>
> https://www.eclipse.org/legal/epl-2.0/
>
> https://en.wikipedia.org/wiki/BSD_licenses
>
> https://zh.wikipedia.org/wiki/GNU%E9%80%9A%E7%94%A8%E5%85%AC%E5%85%B1%E8%AE%B8%E5%8F%AF%E8%AF%81
>
> https://zh.wikipedia.org/wiki/WTFPL
>
> https://www.rt-thread.org/qa/thread-411-1-1.html
>
> https://softwareengineering.stackexchange.com/questions/307702/looking-for-an-example-of-using-code-with-apache-license-version-2-0
>
> https://www.osehra.org/wiki/how-apply-apache-20-license-your-software-project
>
> https://zh.wikipedia.org/wiki/Mozilla%E5%85%AC%E5%85%B1%E8%AE%B8%E5%8F%AF%E8%AF%81
>
> https://adoyle.me/blog/how-to-apply-the-apache-2-0-license-to-your-project.html
>
> https://doc.yonyoucloud.com/doc/sfd-gpl/gplv3.html
> 
> https://baike.baidu.com/item/GPL/2357903
> 
> https://jxself.org/translations/gpl-3.zh.shtml (GPL 许可的中文译本, 翻译的十分流畅, 推荐阅读, 本博客已备份该文章)
> 
> https://www.gnu.org/licenses/gpl-howto.html ( 如何使用 GPL 的 Gnu.org 官方教程)
> 

## 附录

```
MIT License

Copyright (c) 2019 Amatist_Kurisu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```