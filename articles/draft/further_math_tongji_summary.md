# Further Math tongji Summary Notes

[TOC]

## 基础篇

### 基本初等函数

#### 幂函数

补充幂函数的运算公式

**#### 求导**
$$
\exists f(x)=x^n， \forall f'(x)=n\cdot x^{(n-1)}
$$
**#### 不定积分**
$$
\exists f(x)=x^n，\int f(x)=F(x)=(\frac{1}{n+1})\cdot x^{(n+1)}+C
$$

#### 指数函数

指数函数 和 对数函数 是相对的概念

* If $e^x=b$, then $log_eb=x 或 lnb=x$

// TODO 补充指数函数的运算公式

**#### 求导**

* 通常式

$$
(f(x) = a^x)’ = a^x * ln(a)
$$

*  但为了简化式子,a 是常数,  经常会让 $a=e$, $\because (f(x)=e^x)’ = e^x$, 所以式子会变成下面这样

$$
f(x) = a^x , a=e, f'(x)=(e^x)'=(e^x)'
$$

* 详细的求解过程
  * $(e^x)'=lim_{\Delta x \to 0}\frac{e^{(x+\Delta x)}-e^x}{\Delta x}$
  * $=lim_{\Delta x \to 0}\frac{e^x\cdot e^{\Delta x}-e^x}{\Delta x}$
  * $=lim_{\Delta x \to 0}\frac{e^x(e^{\Delta x}-1)}{\Delta x}$
  * $=e^xlim_{\Delta x \to 0}\frac{e^{\Delta x }-1}{\Delta x}$
  * 根据 e 的定义,$x=e$,   ${\displaystyle \lim _{h\to 0}{\frac {x^{h}-1}{h}}=1}$
  * $\therefore lim_{\Delta x\to 0}\frac{e^{\Delta x}-1}{\Delta x}=1$
  * $\therefore 原式 = e^x$

**#### 不定积分**

* 一般式

$$
∫a^x dx = \frac{a^x }{ln(a)} + C
$$

* when $a=e$

$$
∫e^x dx = \frac{e^x}{lne} =  e^x + C
$$

#### 对数函数

有 $a^x=b$ 时, 对数 $log_a^b=x$可以理解为,  可以理解成 a 的多少次方等于 b, 这里的 x 就是 那个 "多少次方", 所以对数函数和指数函数是相对的概念.

* $log_2x , 称为二进制对数, 缩写成 lbx$
* $log_ex , 称为自然对数, 缩写成 lnx, logx$
* $log_{10}x, 称为 常用对数, 缩写成 lgx, 或者 logx,$

// TODO 补充对数函数的运算公式

**#### 求导**

* 一般式

$$
g(x) = log_a(x)， g'(x) = \frac{1}{x \cdot ln(a)}
$$

* When $a=e$

$$
g(x)=lnx, g'(x)=\frac{1}{x}
$$

**#### 不定积分**

* 自然对数的不定积分

$$
\int lnx dx = xlnx - x + C
$$

* 一般式

$$
∫log_a(x) dx = ∫\frac{ln(x)}{ln(a)} dx = \frac{1}{ln(a)} ∫ln(x) dx\\ = \frac{1}{lna}(xlnx - x) + C,
$$

#### 三角函数

* 三角函数
  * sin
    * 在直角三角形中，正弦值等于对边的长度与斜边的长度的比。在单位圆中，正弦值等于垂直坐标。sin0=0
  * cos
    * 在直角三角形中，余弦值等于邻边的长度与斜边的长度的比。在单位園中，余弦值等于水平坐标。cos0=1
  * tan
    * 在直角三角形中，正切值等于对边的长度与邻边的长度的比。这也等于正弦值除以余弦值。 $tanx=\frac{sinx}{cosx}=\frac{a}{b}$, tanx=0
  * cot
    * $cotx=\frac{1}{tanx}$
  * sec
    * $secx=\frac{1}{cosx}$
  * csc
    * $cscx=\frac{1}{sinx}$

**#### 求导**

* 正弦函数 $sin'x=cosx$
  * 证明
* 余弦函数 $cos'x=-sinx$
* 正切函数 $tan'x=sec^2x$
* 余切函数 $cot'x=-csc^2x$
* 正割函数 $sec'x=secxtanx$
* 余割函数 $csc'x=-cscxcotx$

**#### 不定积分**

#### 反三角函数

**#### 求导**

**#### 不定积分**

## 第一章 函数与极限

* 基本初等函数, 只有五种
  1. 幂函数 $y=x^\mu (\mu\in \mathbb{R})$
  2. 指数函数 $y=a^x (a>0 \text且 a\neq 1)$
  3. 对数函数 $y=log_ax, (a > 0 \text且 \ a \neq 1, 当 a=e 时, 记为 y= lnx ) $
  4. 三角函数 $y=sin x, y=cosx,y=tanx, y=cotx,y=secx,y=cscx $
     * $y=sinx$ 正弦, $y=cscx$ 余割, $sinx * cscx = 1$
     * $y=cosx$ 余弦. $y=secx$ 正割, $cosx * secx = 1$
     * $y = tanx$ 正切, $y=cotx$ 余切, $tanx * cotx = 1$
  5. 反三角函数 上面六个 三角函数的反函数



























## 第二章 导数与微分



## 第三章 微分中值定理



## 第四章 不定积分



## 第五章 定积分



## 第六章 定积分的应用



## 第七章 微分方程



## 第八章 向量代数与空间解析几何



## 第九章 多元函数微分学及应用



## 第十章 重积分



## 第十一章 曲线积分与曲面积分



## 第十二章 级数



