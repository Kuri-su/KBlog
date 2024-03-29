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

* 通常式 // TODO 补充详细的证明过程

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

* 一般式 // TODO 补充详细的证明过程

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

// TODO 添加三角函数的运算公式

**#### 求导**

* 正弦函数 $sin'x=cosx$ 
  * 证明: 
  
    * 证明 $sin'x=cosx 需要先证明 lim_{x\to 0}\frac{sinx}{x}=1$
  
      * 证明: $lim_{x\to 0}\frac{sinx}{x}=1$
      * <iframe src="https://www.geogebra.org/calculator/hkupv8dw?embed" width="800" height="600" allowfullscreen style="border: 1px solid #e4e4e4;border-radius: 4px;" frameborder="0"></iframe>
      * ![image-20230621135117362](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230621135117362.png)
  
      * A, B 是单位圆上的两个点, C 是圆外一点, x 是 AB两点 与 圆心 O 形成的夹角, $0<x<\frac{\pi}{2}$
      * 这样可以得到两个三角形$\triangle AOB$,$RT\triangle AOC$ 以及 一个以 O 为圆心的扇形 $AOB$
  
           * 显然三者面积 满足如下不等式 $S_{\triangle AOB} \lt S_{扇AOB} \lt S_{RT\triangle AOC}$
             * $S_{\triangle AOB}=\frac{1}{2}AO\cdot BD=\frac{1}{2}\cdot 1 \cdot sinx$
               * $sinx=\frac{BD}{OB}=\frac{BD}{1}$
               * $\therefore BD=sinx$
             * $S_{扇AOB}=\pi r^2\cdot \frac{x}{2\pi}=\frac{1}{2}x$
             * $S_{RT\triangle AOC}=\frac{1}{2}AO\cdot AC=\frac{1}{2}tanx$
               * $tanx=\frac{CA}{OA}=\frac{CA}{1}$
               * $\therefore CA=tanx$
  
      * $\therefore 得到等式 \frac{1}{2}sinx\lt \frac{1}{2}x\lt \frac{1}{2}tanx$
          * $化简之后得到 1\lt \frac{x}{sinx}\lt \frac{1}{cosx}$, 距离目标已经很近, 证明 $\frac{x}{sinx}$在 x=0 的去心邻域内连续后, 使用夹逼定理即可得到  $lim_{x\to 0}\frac{sinx}{x}=1$
  
    * 接着使用导数的原始定义 求导 sinx
  
      * $sin'x=lim_{\Delta x\to 0}\frac{sin(x+\Delta x)-sinx}{\Delta x}$
      * 利用 sin 的和差公式, 可以把 把 sin(a+b) 进一步化简
      * $=lim_{\Delta x \to 0}\frac{sinxcos\Delta x+sin\Delta xcosx-sinx}{\Delta x}$
      * $=lim_{\Delta x \to 0}\frac{sinx(cos\Delta x-1)+sin\Delta x cosx}{\Delta x}$
      * $=sinx\cdot lim_{\Delta x \to 0}\frac{(cos\Delta x-1)}{\Delta x}+lim_{\Delta x\to 0}\frac{sin\Delta xcosx}{\Delta x}$
      * 由于 $\Delta x \to 0 的时候 (cos\Delta x) \to 1$, 所以$sinx\cdot lim_{\Delta x \to 0}\frac{(cos\Delta x-1)}{\Delta x}=0$,
      * 又由于 $lim_{\Delta x\to 0}\frac{sinx}{x}=1$,
      * $\therefore sin'x=cosx$ 
* 余弦函数 $cos'x=-sinx$
* 正切函数 $tan'x=sec^2x$

  * 证明这个需要用到一个 另一个推论 $h(x)=\frac{g(x)}{f(x)}$,$h'(x)=\frac{g'(x)f(x)-g(x)f'(x)}{f(x)^2}$
    * 证明: 
      * $h'(x)=lim_{\Delta x \to 0}\frac{h(x+\Delta x)-h(x)}{\Delta x}$
        * $=lim_{\Delta x\to 0}\frac{\frac{g(x+\Delta x)}{f(x+\Delta x)}-\frac{g(x)}{f(x)}}{\Delta x}$
        * $=lim_{\Delta \to 0 }\frac{\frac{g(x+\Delta x) f(x)-g(x)f(x+\Delta x)}{f(x+\Delta x)f(x)}}{\Delta x}$
        * 分母稍微换一下
        * $=lim_{\Delta \to 0 }\frac{\frac{g(x+\Delta x) f(x)-g(x)f(x+\Delta x)}{\Delta x}}{f(x+\Delta x)f(x)}$
        * 往分子上加一个 $g(x)f(x) $再减掉一个 $g(x)f(x)$
        * $=lim_{\Delta \to 0 }\frac{\frac{g(x+\Delta x) f(x)-g(x)f(x)+g(x)f(x)-g(x)f(x+\Delta x)}{\Delta x}}{f(x+\Delta x)f(x)}$ , 然后化简之
        * $=lim_{\Delta \to 0 }\frac{\frac{f(x)(g(x+\Delta x) -g(x))+g(x)(f(x)-f(x+\Delta x))}{\Delta x}}{f(x+\Delta x)f(x)}$
        * $=lim_{\Delta \to 0 }\frac{\frac{f(x)(g(x+\Delta x) -g(x))}{\Delta x}+\frac{g(x)(f(x)-f(x+\Delta x))}{\Delta x}}{f(x+\Delta x)f(x)}$ , 使用 然后这里 用求导的定义来化简
        * $=lim_{\Delta x \to 0}\frac{g'(x)f(x)-g(x)f'(x)}{f(x+\Delta x)f(x)}$, 由于 $\Delta x\to 0$
        * $\therefore 原式= =lim_{\Delta x \to 0}\frac{g'(x)f(x)-g(x)f'(x)}{f(x)^2}$

    * 然后接着就拿这个结论按部就班去求 剩下的四个三角函数的导数即可

* 余切函数 $cot'x=-csc^2x$
* 正割函数 $sec'x=secxtanx$
* 余割函数 $csc'x=-cscxcotx$

**#### 不定积分**

* ∫sin(x) dx = -cos(x) + C
* ∫cos(x) dx = sin(x) + C
* ∫tan(x) dx = ln|sec(x)| + C
* ∫cot(x) dx = ln|sin(x)| + C
* ∫sec(x) dx = ln|sec(x) + tan(x)| + C
* ∫csc(x) dx = ln|csc(x) - cot(x)| + C

#### 反三角函数

反三角函数是三角函数的反函数, 在已知对边比例的情况下求角度

* $sin^{-1} = arcsin=\frac{1}{sin}$
* $cos^{-1}=arccos=\frac{1}{cos}$
* $tan^{-1}=arctan=\frac{1}{tan}$

**#### 求导**

* $arcsin'(x) = \frac{1}{\sqrt{1-x^2}}$
* $arccos'(x) = -\frac{1}{\sqrt{1-x^2}}$
* $arctan'(x) = \frac{1}{1+x^2}$

**#### 不定积分**

- $\int arcsin(x) dx = x \cdot arcsin(x) + \sqrt{1 - x^2} + C$
- $\int arccos(x) dx = x \cdot arccos(x) - \sqrt{1 - x^2} + C$
- $\int arctan(x) dx = x \cdot arctan(x) - \frac{1}{2} \ln |1 + x^2| + C$

#### 常数 $e$ (欧拉数)

1. 定义: 
   * $e=lim_{n\to \infty}(1+\frac{1}{n})^n$
   * $e=lim_{t\to 0}(1+t)^{\frac{1}{t}}$
2. 等价定义
   * $lim_{h\to 0}\frac{e^h-1}{h}=1$
   * 



## 第一章 函数与极限

### 第一节 映射和函数

* 反函数
  * $y=f(x) \Rightarrow  x= g(y) $ , 这里的 g 就是 f 的反函数, 也就是 $g = f^{-1}$
  * $f(x) * f^{-1}(x) = x$

* <u>**基本**</u>初等函数, 只有五种
  1. 幂函数 $y=x^\mu (\mu\in \mathbb{R})$
  2. 指数函数 $y=a^x (a>0 \text且 a\neq 1)$
  3. 对数函数 $y=log_ax, (a > 0 \text且 \ a \neq 1, 当 a=e 时, 记为 y= lnx ) $
  4. 三角函数 $y=sin x, y=cosx,y=tanx, y=cotx,y=secx,y=cscx $
     * $y=sinx$ 正弦, $y=cscx$ 余割, $sinx * cscx = 1$, $cscx=\frac{1}{sinx}$
     * $y=cosx$ 余弦. $y=secx$ 正割, $cosx * secx = 1$, $secx=\frac{1}{secx}$
     * $y = tanx$ 正切, $y=cotx$ 余切, $tanx * cotx = 1$ , $cotx=\frac{1}{tanx}$
  5. 反三角函数 上面六个 三角函数的反函数
* 初等函数
  * 由 **常数** 和 **基本初等函数** 经过 **四则运算** 和 **复合运算**  而成的式子. (课本上的定义: 由常数和基本初等函数经过 有限次的四则运算 和 有限次的函数复合步骤 所构成并可用一个式子表示的函数, 称为 **初等函数**) 

* 初等性质
  1. 奇偶性
  2. 单调性
  3. 有界性
  4. 周期性

### 第二节 数列极限

* 性质
  1. 唯一性 ,  数列有界限必唯一, 
  2. (有界性) if $lim_{n\to\infty}a_n=A$, 则 $\exists M>0$, 使 $|a_n|\le M$ , 反之则不成立
  3. (保号性)  if $\lim_{n\to\infty}a_n=A \begin{cases} >0 \\ <0 \end{cases} $   , 则 $\exists N>0, 当 n>N时$, $a_n\begin{cases} >0\\<0 \end{cases}$

### 第三节 函数极限

* 定义$(\epsilon-\delta)$

  * 在 x 在 位于 a点周围 $\delta$ 的去心邻域内,  总能找到一个$\epsilon$ 使 $|f(x)-A|<\epsilon$, 则称 当 $x\to a  时, A 为 f(x)的极限$
  *  Note
    1. $x\to a 时, x\ne a;$
    2. $x\to a, 含 \begin{cases} x\to a^- \\ x\to a^+ \end{cases} \ ;$  
    3. $\{x| 0< |x-a|< \delta  \}\triangleq \mathring{U}(a,\delta) $ , a 的 去心 $\delta$ 领域
    4. $lim_{x\to a }f(x) 与 f(a) 无关$
    5. $若\forall \epsilon > 0 , \exists \delta >0,$ $\exists lim_{x\to a}f(x) \Leftrightarrow \exists f(a-0) \& \exists f(a+0) 且相等$

* 定义 $(\epsilon-x)$ , 当 x 趋近于 $\infty$ 的情况

  1. Case1: If $\forall\epsilon>0, \exists X>0, 当 x> X 时$,
     * $|f(x)-A|< \epsilon $
     * 记 $lim_{x\to+\infty}=A$
  2. Case2: If $\forall \epsilon > 0, \exists X>0, 当 x<-X 的时候, $
     * $|f(x)-A|<\epsilon $
     * 记 $lim_{x\to-\epsilon}f(x)=A$
  3. Case3: If $\forall\epsilon>0,\exists X>0,当 |x|>X 时$
     * $|f(x)-A|<\epsilon$
     * 记 $lim_{x\to\infty}f(x)=A$

* 性质

  1. (唯一性) 

     * 函数有极限必唯一

  2.  (局部有界)

     * $ 设 limx→af(x)=A $, $则 当时∃δ>0,M>0,当0<|x−a|<δ时,$  $|f(x)|\le M$

  3.  (保号性)

     * $设 lim_{x\to a }f(x)=A \begin{cases}>0\\<0\end{cases}, 则 \exists \delta >0, 当0<|x-a|<\delta 时,  f(x)\begin{cases}>0\\<0\end{cases} $  

     * 极限为负, 则 函数值也为负

### 第四节 无穷小 和 无穷大

#### 无穷小

























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



