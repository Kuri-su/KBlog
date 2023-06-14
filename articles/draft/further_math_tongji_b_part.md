# Further Mathematic lecture (tongji) (B part) cross Jiafeng Tang

[TOC]



## 第三章 微分中值定理与导数的应用

### 第一节 微分中值定理 (part A)

* 引导: 
  * 极值点 - $y=f(x)(x\in \mathbb{D}),x_0\in \mathbb{D}$
    1. If $\exists \delta >0, 当 0<|x-x_0|<\delta 时 , (x_0-\delta )<x_0< (x_0+\delta)$
       * $f(x)>f(x_0)$
       * $称 x_0 为 f(x) 的 极小点$
    2. If $\exists \delta > 0 , 当 0< |x-x_0|<\delta 时$
       * $f(x) < f(x_0)$
       * $x=x_0 称 f(x) 的 极大点 $
  * $f'(a)\begin{cases} >0 \\<0\\=0\\不存在 \end{cases}$
    * 当 $f'(a)>0$
      * $f'(a)\triangleq lim_{x\to a}\frac{f(x)-f(a)}{x-a}>0$
      * $\exists \delta > 0, 当 0< |x-a|< \delta , \frac{f(x)-f(a)}{x-a}>0$
      * $\begin{cases} f(x)<f(a) & x\in (a-\delta,a) \\ f(x)>f(a) & x\in (a,a+\delta) \end{cases}$
      * $\therefore f'(a)>0 \Rightarrow 左小右大 (x=a 不是 极值点)$
    * 当 $f'(a)<0$
      * $f'(a)=lim_{x\to a}frac{f(x)-f(a)}{x-a}<0$
      * $\exists \delta >0, 当 0<|x-a|<\delta 时, \frac{f(x)-f(a)}{x-a}<0$
      * $\begin{cases} f(x) > f(a) & x\in (a-\delta, a) \\ f(x)<f(a)& x\in (a,a+\delta) \end{cases}$
      * $f'(a)<0 \Rightarrow 左大右小 (x=a 不是 极值点)$
    * 结论:
      1. $f(x) 在 x=a 取极值 \Rightarrow f'(a)=0 或 f'(a) 不存在$
      2. $f(x) 在 x=a 取 极值且 可导 \Rightarrow f'(a)=0$
      3. 上述两个结论 反之则不对
         * 反例1 : 
           * $y=x^3, y'=3x^2, y'(0)=0$
           * $但 x=0 不是 y=x^3 的 极值点$
         * 反例2: 
           * $y=f(x)=\begin{cases} x & x<0 \\ 2x & x\geq0 \end{cases}$
           * $f_-'(0)=lim_{x\to0^-}\frac{f(x)-f(0)}{x-0}=1$
           * $f_+'(0)=lim_{x\to 0^+}\frac{f(x)-f(0)}{x-0}=2$
           * $\because f_-'(0) \ne f_+'(0), \therefore f'(0) 不存在, 但 x=0 不是极值点$

#### Rolle

* ⭐️ Rolle 中值定理
  * 定理: 
    * 当满足如下三个条件的时候, 定理 $\exists \xi \in (a,b) , 使 f'(\xi)=0$
      1. $f(x)\in C[a,b]$ ,  
         * 注意这里要求闭区间内连续
      2. $f(x)在 (a,b) 内可导$, 
         * 注意这里只要求开区间内可导
      3. $f(a)=f(b)$ 
         * ⭐️ 注意这个条件,  Rolle 是 Lagrange 中值定理的 特例
    *  证明: 
      * $f(x)\in C[a,b] \Rightarrow f(x) 在 [a,b]上 取到 最小值 m 和 最大值 M$
        * 1 m=M , m<M
        * $\because f(a)=f(b)$
        * $\therefore 如果 f(a)=m, 则 f(b)=m$
          * $\Rightarrow M 在 (a,b) 内 取到;$
        * If $f(a)=M, 则 f(b)=M $
          * $\Rightarrow M 在 (a,b) 内取到$
        * $\therefore m,M 至少一个在 (a,b) 内取到$
        * 设 $\exists \xi \in (a,b), 使 f(\xi)=m$
          * $\Rightarrow f'(\xi)=0 或 f'(\xi)不存在$
          * $\because f(x) 在 (a,b) 内 可导$
          * $f'(\xi)=0$
  * 例题: 
    * 1
      * $f(x)\in C[0,2], (0,2) 内 可导, f(0)=-1,f(1)=2,f(2)=-2$, 证明 $\exists \xi \in (0,2), 使 f'(\xi)=0$
      * 证: 
        * $\because f(0)f(1)<0, \therefore \exists c_1\in (0,1), 使 f(c_1)=0;$
        * $又 \because f(1)f(2)<0, \therefore \exists c_2\in(1,2), 使 f(c_2)=0$
        * $\because f(x)\in C[c_1,c_2], f(x) 在 (c_1,c_2)内可导$
        * 又 $\because f(c_1)=f(c_2)=0$
        * $\therefore \exists \xi \in C(c_1,c_2) \subset (0,2), 使 f'(\xi)=0$
    * 2
      * $f(x)\in C[0,2], (0,2) 内 可导, 且 f(0)=1, f(1)+2f(2)=3. 证明: \exists \xi \in (0,2), 使 f'(\xi)=0$
      * 证:  
        1. 步骤1: 
           * $\because f(x)\in C[1,2], \therefore f(x) 在 [1,2] 上 取到 m 和 M$
           * $3m\le f(1)+2f(2)\le 3M$
           * $\therefore m\le 1 \le M$
           * $\therefore \exists c\in [1,2], 使 f(c)=1$
        2. 步骤2: 
           * $\because f(0)=f(c)=1$
           * $\therefore \exists \xi \in (0,c) \subset (0,2)$
           * $使 f'(\xi)=0$

### 第一节 微分中值定理 (part B)

#### Largrange

* ⭐️ Lagrange 中值定理
  * 定理
    * 当 如下条件同时满足的时候, 式子$\exists \xi (a,b), 使 f'(\xi) = \frac{f(b)-f(a)}{b-a}$, 成立 
      1. $f(x)\in C[a,b]$
      2. $f(x) 在 (a,b) 内可导$
         1. 开区间内可导
    * 可以看到 Lagrange 中值定理 比 Rolle 中值定理少了 $f(a)=f(b) $ 的限制, 所以 Rolle 是 Lagrange 中值定理的 一种特殊情况
  * 分析: 
    * $L: y=f(x)$
    * $L_{AB}: y-f(a)=\frac{f(b)-f(a0)}{b-a}\cdot (x-a)$
    * $即 L_{AB}: y=f(a)+\frac{f(b)-f(a)}{b-a}(x-a)$
  * 证明: 
    * 令 $\varphi (x)= 曲-直 = f(x)-f(a)-\frac{f(b)-f(a)}{b-a}(x-a)$
    * $\varphi (x) \in C[a,b], \varphi (x) 在 (a,b) 内可导, 且 \varphi (a)=\varphi(b)=0$
    * $\exists \xi \in (a,b), 使 \varphi ' (\xi )=0$
    * $而 \varphi'(x)=f'(x)-\frac{f(b)-f(a)}{b-a}$
    * $\therefore f'(\xi)=\frac{f(b)-f(a)}{b-a}$
  * Notes: 
    1. If $f(a)=f(b), 则 L\Rightarrow R$
    2. $等价形式$
       * $f'(\xi)=\frac{f(b)-f(a)}{b-a} \Leftrightarrow f(b)-f(a)=f'(\xi)(b-a) (a<\xi<b)$
       * $\Leftrightarrow f(b)-f(a)=f'[a+(b-a)\theta](b-a), (0<\theta<1)$
  * 例子
    * 1
      * $f(x)\in C[a,b], (a,b) 内可导, f(a)=0. f(b)=0,a<c<b, 且 |f'(x)|\le M,$
      * $证明: |f(c)\le M(b-a)|$
      * 证: 
        * 步骤一: 
          * $f(c)-f(a)=f'(\xi_1)(c-a)(a<\xi_1<c)$
          * $f(b)-f(c)=f'(\xi_2)(b-c)(c<\xi_2<b)$
        * 步骤二: 
          * $\because f(a)=0, f(b)=0$
          * $\therefore f(c)=f'(\xi_1)(c-a), -f(c)=f'(\xi_2)(b-c)$
          * $\therefore \begin{cases} |f(c)|=|f'(\xi_1)|(c-a)\le M(c-a) \\  |f(c)|=|f'(\xi_2)|(b-c)\le M(b-cs) \end{cases}$
          * $\Rightarrow 2|f(c)|\le M (b-a) \Rightarrow |f(c)|\le \frac{M}{2}(b-a)$
    * 2
      * $a<b, 证: arctanb-arctana \le b-a$
      * 证: 
        * 令 $f(x)=arctanx , f'(x)=\frac{1}{1+x^2}$
        * $arctan b - arctan a = f(b)-f(a)=f'(\xi)(b-a) (a<\xi < b)$
        * $=\frac{1}{1+\xi^2}\cdot (b-a)$
        * $\because \frac{1}{1+\xi^2}\le 1$
        * $\therefore arctan b - arctan a = \frac{1}{1+\xi^2}\cdot (b-a) \le b-a$
  * 推论
    * 若 $f(x)\in C[a,b], f(x) 在 (a,b), 且 f'(x)=0. 则 f(x) \equiv C$
    * 证: 
      * $\forall x_1, x_2 \in [a,b] 且 x_1<x_2$
      * $f(x_2)-f(x_1)=f'(\xi)(x_2-x_1) (x_1<\xi<x_2)$
      * $\because f'(x)\equiv 0$
      * $\therefore f(x_2)-f(x_1)=0 \Rightarrow f(x_1)=f(x_2)$
      * $\therefore f(x)\equiv C_0 (a\le x\le b)$
      * 

#### Canchy

* ⭐️ Canchy 中值定理
  * 定理: 当 如下条件成立时, 公式 $\exists \xi \in (a,b) , 使 \frac{f(b)-f(a)}{g(b)-g(a)}=\frac{f'(\xi)}{g'(\xi)}$ 成立
    1. $f(x), g(x) \in C[a,b]$
    2. $f(x),g(x) 在 (a,b) 内可导$
    3. $g'(x)\ne 0 (a<x<b)$
       * 这个是比 Lagrange 多的内容
  * Notes: 
    1. $g'(x)\neq 0 (a<x<b) \Rightarrow \begin{cases} g'(\xi)\ne 0  \\g(b)-g(a)\ne 0 \end{cases}$
       * $(当 g(b)-g(a)=0 \Rightarrow g(a)=g()b, \exists C\in (a,b) , g'(c)=0, 矛盾)$
    2. 若 $g(x)=x, 则 C\Rightarrow L$
    3. $L: \varphi(x)= 曲-直 = f(x)-f(a)-\frac{f(b)-f(a)}{b-a}(x-a)$
       * Canchy: $\varphi (x)=f(x)-f(a)-\frac{f(b)-f(a)}{g(b)-g(a)}\cdot [g(x)-g(a)]$
       * 证: 
         * $令 \varphi (x)=f(x)-f(a)-\frac{f(b)-f(a)}{g(b)-g(a)}[g(x)-g(a)]$
         * $\varphi \in C[a,b], \varphi (x)在 (a,b) 内可导$
         * $\varphi (a)=0, \varphi (b)=0$
         * $\because \varphi (a)=\varphi (b)=0$
         * $\therefore \exists \xi \in (a,b), 使 \varphi ' (\xi)=0$
         * 而 $\varphi'(x)=f'(x)-\frac{f(b)-f(a)}{g(b)-g(a)}\cdot g'(x)$
         * $\therefore f'(\xi)-\frac{f(b)-f(a)}{g(b)-g(a)}\cdot g'(\xi)=0$
         * $\because g'(\xi)\ne 0, \therefore \frac{f(b)-f(a)}{g(b)-g(a)}=\frac{f'(\xi)}{g'(\xi)}$
  * 例子:
    * 1
      * $f(x)\in C[a,b], (a,b) 内 可导 (a>0),$
      * 证明: $使 f(b)-f(a)=\xi f'(\xi)\cdot ln\frac{b}{a}$
      * 分析: 
        * $\Leftrightarrow \frac{f(b)-f(a)}{lnb-lna}=\xi f'(\xi)$
      * 证: 
        * 令 $g(x)=lnx, g'(x)=\frac{1}{x}\ne 0 (a<x<b)$
        * 由 $Canchy , \exists \xi \in (a,b), 使$
        * $\frac{f(b)-f(a)}{g(b)-g(a)}=\frac{f'(\xi)}{g'(\xi)}$
        * $\Rightarrow \frac{f(b)-f(a)}{lnb-lna}=\frac{f'(\xi)}{\frac{1}{\varphi}}=\xi f'(\xi)$
        * $\Rightarrow f(b)-f(a)=\xi f'(\xi)\cdot ln\frac{b}{a} $
    * 2
      * $f(x) 二阶可导, lim_{x \to 0}\frac{f(x)}{x}=0, f(1)=0$
      * 试证明: $\exists \xi \in (0,1), 使 f''(\xi)=0$
      * 证: 
        * 步骤一: 
          * $\because lim_{x\to 0}\frac{f(x)}{x}=0, \therefore lim_{x\to 0}f(x)=0$
          * $又 \because f(x) 连续, \therefore f(0)=0$
          * $0=lim_{x\to0}\frac{f(x)}{x}=lim_{x\to 0}\frac{f(x)-f(0)}{x-0}=f'(0)$
          * $\therefore f(0)=0, f'(0)=0$
        * 步骤二: 
          * $\therefore f(0)=f(1)=0$
          * $\therefore \exists C\in (0,1), 使 f'(c)=0$
        * 步骤三: 
          * $\because f'(0)=f'(c)=0$
          * $\therefore \exists \xi  \in (0,c) \sub (0,1), 使 f''(\xi)=0$
    * 3
      * 试证明:$ x>0 时, e^x>1+x$
      * 证: 
        * $f(t)=e^t, f'(t)=e^t$
        * $对 x>0, f(x)-f(0)=f'(\xi)(x-0)(0<\xi<x)$
        * 即 $e^x-1=e^\xi x$
        * $\because \xi >0 , \therefore e^\xi > 1$
        * $\therefore e^x-1=e^\xi x > x$
        * $\Rightarrow e^x > 1+x$
    * 4
      * $0<a<b, 试证明: \frac{b-a}{b} < ln \frac{b}{a} < \frac{b-a}{a}$
      * 证: 
        * 令 $f(x)=lnx, f'(x)=\frac{1}{x} \ne 0 (a<x<b)$
        * $ln \frac{b}{a}=ln b-lna=f(b)-f(a)=f'(\xi)(b-a)=\frac{b-a}{\xi} (a<\xi<b)$
        * $\because a<\xi < b, \therefore \frac{1}{b}<\frac{1}{\xi} < \frac{1}{a}$
        * $\Rightarrow \frac{b-a}{b} < \frac{b-a}{\xi} < \frac{b-a}{a}$
        * $\therefore \frac{b-a}{b} < ln \frac{b}{a} < \frac{b-a}{a}$

### 第二节 罗必达法则

* $Q: lim_{x\to 0}\frac{tanx-sinx}{x^3}?$
  * $原式=lim_{x\to0}\frac{x-x}{x^3}=0$ 这个推理是错的, 精确度不够
  * $原式=lim_{x\to0}\frac{tanx}{x}\cdot \frac{1-cosx}{x^2}=\frac{1}{2}$ 这个推理是正确的
  * **对于 $\frac{0}{0} 型 的式子, 用等价无穷小求极限有局限性$**
*  本节的目标就是 找到 $\frac{0}{0}, \frac{\infty}{\infty} 型求极限的方法$

#### $\frac{0}{0} $型

* 定理: 
  1. $\frac{0}{0} 型$
     * 若函数满足如下条件, 则 $lim_{x\to a}\frac{f(x)}{F(x)}=A$
       * 1. $f(x), F(x) 在 x=a 的 去心邻域 内 可导 且 F'(x) \ne 0$
         2. $lim_{x\to a}f(x)=0, lim_{x\to a}F(x)=0;$
         3. $lim_{x\to a}\frac{f'(x)}{F'(x)}=A$

* $注意: lim_{x\to a}f(x) 的函数值 与 f(a) 的函数值无关, 例如下面的例子: $
  * 例子
    * 1
      * $f(x)=\frac{x^2-1}{x-1}$
      * $when\ x=1, f(x) 无函数值$
      * $lim_{x\to 1}f(x)=lim_{x\to1}(x+1)=2$
    * 2
      * $f(x)=\begin{cases} \frac{x^2-1}{x-1}& x\ne1 \\ 10 & x=1 \end{cases} $
      * $lim_{x\to1}f(x)=lim_{x\to1}\frac{x^2-1}{x-1}=lim_{x\to1}(x+1)$
* 证明: 
  * (令 $f(a)=0, F(a)=0$)
  * $\because lim_{x\to a}f(x), lim_{x\to a}F(x) 与 f(a), F(a) 无关$
  * $\therefore f(a)=0, F(a)=0$
  * $\therefore lim_{x\to a}f(x)=f(a)=0, lim_{x\to a}F(x)=F(a)=0$
  * $\therefore f(x), F(x) 在 x=a 的 邻域 内 连续$
  * $f(x), F(x) 在 x=a 的 去心邻域内可导, 且 F'(x)\ne 0$
  * $\therefore \frac{f(x)}{F(x)}=\frac{f(x)-f(a)}{F(x)-F(a)}=\frac{f'(\xi)}{F'(\xi)} (\xi 介于 a 与 x 之间)$
  * $lim_{x\to a} \frac{f(x)}{F(x)}=lim_{x\to a}\frac{f'(\xi)}{F'(\xi)}=lim_{\xi\to a}\frac{f'(\xi)}{F'(\xi)}=A$

* 再次详细解释证明过程

  * $1^\circ $
    * $ 令 f(a)=0, F(a)=0$
    * $\Rightarrow f(x)\cdot F(x) 在 x=a 连续$
    * $\Rightarrow f(x)\cdot F(x) 在 x=a 邻域 内 连续$

  * $2^\circ$
    * $f(x)\cdot F(x) 在 x=a 去心邻域 内可导$

  * $3^\circ$
    * $F'(x)\ne 0$
    * 由 $ Canchy, \frac{f(x)}{F(x)}=\frac{f(x)-f(a)}{F(x)-F(a)}=\frac{f'(\xi)}{F'(\xi)} (\xi 介于 a 与 x 之间)$
    * $lim_{x\to a}\frac{f(x)}{F(x)}=lim_{x\to a}\frac{f'(\xi)}{F'(\xi)}=lim_{\xi\to a}\frac{f'(\xi)}{F'(\xi)}=A$

* 例子
  * 1
    * $lim_{x\to0}\frac{x-sinx}{x^3}$
    * 解: 
      * $lim_{x\to 0}\frac{x-sinx}{x^3}=lim_{x\to 0}\frac{1-cosx}{3x^2}=\frac{1}{6}$
  * 2
    * $lim_{x\to 0} \frac{x-ln(1+x)}x^2{}$
    * 解: 
      * $lim_{x\to0}\frac{x-ln (1+x)}{x^2}=lim_{x\to 0}\frac{1-\frac{1}{1+x}}{2x}$
      * $=\frac{1}{2}lim_{x\to 0}\frac{\frac{x}{1+x}}{x}=\frac{1}{2}lim_{x\to0}\frac{1}{1+x}=\frac{1}{2}$
  * 3
    * $lim_{x\to1}\frac{x^2-3x+2}{x^2-1}$
    * 解: 
      * 法一: $lim_{x\to1}\frac{x^2-3x+2}{x^2-1}=lim_{x\to 1}\frac{x-2}{x+1}=-\frac{1}{2}$ (因式分解)
      * 法二: $lim_{x\to1}\frac{x^2-3x+2}{x^2-1}=lim_{x\to 1}\frac{2x-3}{2x}=-\frac{1}{2}$ (罗必达法则)

#### $\frac{\infty}{\infty }$型

* 定理
  *  ($\frac{\infty}{\infty}$) 若满足如下条件, 则 $lim_{x\to a}\frac{f(x)}{F(x)}=A$
    1. $f(x), F(x) 在 x=a 的去心邻域内可导, 且 F'(x)\ne 0;$
    2. $lim_{x\to a}f(x)=\infty, lim_{x\to a}F(x)=\infty$
    3. $lim_{x\to a}\frac{f'(x)}{F(x)}=A$
* 例子
  * 1
    * $lim_{x\to0^+}xlnx ,(0 * \infty型要转化)\Rightarrow \begin{cases} \frac{0}{0}; \\ \frac{\infty}{\infty}; \end {cases}$
    * 解
      * $lim_{x\to 0^+}x ln x = lim_{x\to 0^+}\frac{lnx}{\frac{1}{x}}$
      * $=lim_{x\to 0^+}\frac{\frac{1}{x}}{-\frac{1}{x^2}}=lim_{x\to0^+}(-x)=0$
  * 2
    * $lim_{x\to 0 ^+}x^{sinx},  (0^0 型需要转化)\Rightarrow e^{ln}$
    * 解: 
      * $lim_{x\to0^+} x^{sinx} = e^{lim_{x\to0^+}sinx\cdot lnx}$
      * $\because lim_{x\to 0^+} sinx\cdot lnx, (0 * \infty) \Rightarrow \begin{cases}\frac{0}{0} \\ \frac{\infty}{\infty} \end{cases}$
      * $= lim_{x\to 0^+}\frac{lnx}{cscx} (\frac{\infty}{\infty})$
      * $=lim_{x\to0^+}\frac{\frac{1}{x}}{-cscxcotx}=-lim_{x\to0^+}\frac{sinx\cdot tanx}{x}$
      * $=-lim_{x\to0^+}\frac{x^2}{x}=0$
      * $\therefore 原式 = e^0 =1$
  * 3
    * $lim_{x\to+\infty}\frac{lnx}{x^a} (a>0)$
    * 解: 
      * $lim_{x\to+\infty}\frac{lnx}{x^a}, (\frac{\infty}{\infty})$
      * $=lim_{x\to+\infty}\frac{\frac{1}{x}}{ax^{a-1}}=\frac{1}{a}lim_{x\to+\infty}\frac{1}{x^a}=0$
  * 4
    * $lim_{x\to + \infty}\frac{x^3}{e^x}$
    * 解
      * $lim_{x\to+\infty} \frac{x^3}{e^x}, (\frac{\infty}{\infty})$
      * $=lim_{x\to+\infty}\frac{3x^2}{e^x}=lim_{x\to+\infty}\frac{6x}{e^x}=lim_{x\to+\infty}\frac{6}{e^x}=0$
* Notes:
  1. $lim_{x\to + \infty} \frac{lnx}{x^a}=0, (a>0);$
  2. $lim_{x\to+\infty}\frac{x^a}{b^x}=0, (a>0,b>1)$
  3. $f(x)\to 0, F(x)\to 0, (x\to a)$
     * 若 $lim_{x\to a}\frac{f'(x)}{F'(x)}不存在$
     * 只能表明 <u>罗必达法则</u> 不能使用, 但 $lim_{x\to a}\frac{f(x)}{F(x)} 不一定不存在$
     * 如: $f(x)=x+sinx, F(x)=x$
       * $lim_{x\to0}f(x)=0, lim_{x\to 0}F(x)=0$
       * 且 $lim_{x\to0} \frac{f'(x)}{F'(x)}=lim_{x\to0}(1+cosx) 不存在$
       * $而 lim_{x\to 0}\frac{f(x)}{F(x)}=lim_{x\to0}(1+\frac{sinx}{x})=2$
  4. $lim_{x\to a}f(x)=\infty, lim_{x\to a}F(x)=\infty$
     * 若 $lim_{x\to a}\frac{f'(x)}{F'(x)}不存在$
     * 只能表明 <u>罗必达法则</u> 不能使用, 但 $lim_{x\to a}\frac{f(x)}{F(x)} 不一定不存在$
     * 如: $f(x)=2x+sinx, g(x)=x$
       * $lim_{x\to \infty}f(x)=\infty, lim_{x\to \infty} g(x)=\infty$
       * 且 $lim_{x\to\infty} \frac{f'(x)}{F'(x)}=lim_{x\to\infty}(2+cosx) 不存在$
       * $而 lim_{x\to \infty}\frac{f(x)}{F(x)}=lim_{x\to\infty}(2+\frac{sinx}{x})=2$

### 第三节 泰勒公式 Taylor

* 问题的提出: 
  * Q1
    * $lim_{x\to0}\frac{e^{x^2}-cosx}{x^2}=lim_{x\to0}\frac{(e^{x^2}-1)+(1-cosx)}{x^2}$
    * $\because e^{x^2}-1 $ ~ $ x^2, 1-cosx$ ~ $\frac{x^2}{2}$
    * $\therefore 原式 \stackrel{?}{=}lim_{x\to0}\frac{x^2+\frac{1}{2}x^2}{x^2}=\frac{3}{2}$
  * Q2
    * $lim_{x\to0}\frac{x-sinx}{x^3}\overset{?}{=} lim_{x\to0}\frac{x-x}{x^3}=0$
    * $=lim_{x\to0}\frac{1-cosx}{3x^2}=\frac{1}{6}$
  * Conjecture
    *  $sinx\overset{?}{=}x+kx^3+o(x^3), 带入 结论是否正确?$

>  在分数上下阶次相同的时候使用等价无穷小是相对安全的

* 思想: 
  * $f(x) 在 x=x_0 邻域内 n+1 不可导$
  * $找 P_n(x)=a_0+a_1(x-x_0)+a_2(x-x_0)^2+... + a_n(x-x_0)^n$
  * 满足: 
    * $P_n(x_0)=f(x_0)$
      * $a_0=f(x_0)$
    * $P_n'(x_0)=f'(x_0)$
      * $a_1=f'(x_0)$
    * $P_n''(x_0)=f''(x_0)$
      * $a_2=\frac{f''(x_0)}{2!}$
    * ...
    * $P_n^{(n)}(x_0)=f^{(n)}(x_0)$
      * $a_n=\frac{f^{(n)}(x_0)}{n!}$
  * $P_n(x)=f(x_0)+f'(x_0)(x-x_0)+\frac{f''(x_0)}{2!}(x-x_0)^2+...+\frac{f^{(n)}x_0}{n!}(x-x_0)^n$
  * $f(x)\approx P_n(x)$
  * $f(x)-P_n(x)\triangleq R_n(x) \Rightarrow f(x)=P_n(x)+R_n(x)$
    * $R_n(x) 表示余项$
* 定理: (泰勒)
  * 设 $f(x) 在 x=x_0 邻域内 n+1 不可导$, 则 $f(x)=P_n(x)+R_n(x)$
  * 其中 $P_n(x)=f(x_0)+f'(x_0)(x-x_0)+\frac{f''(x_0)}{2!}(x-x_0)^2+...+ \frac{f^{(n)}(x_0)}{n!}(x-x_0)^n$
    * $R_n(x)=\frac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)^{n+1} (\xi 介于 x_0 与 x 之间)$

  * 证明: 
    * $f(x_0)=P_n(x_0), f'(x_0)=P'_n(x_0), ... , f^{(n)}(x_0)=P_n^{(n)}(x_0)$
    * 令 $R_n(x)=f(x)-P_n(x)$
    * $R_n(x_0)=0, R_n'(x_0)=0,...., R^{(n)}_n(x_0)=0$
    * $R_n^{(n+1)}(x)=f^{(n+1)}(x), 对 x_0 去心邻域内任一点 x$
    * $\frac{R_n(x)}{(x-x_0)^{n+1}}=\frac{R_n(x)-R_n(x_0)}{(x-x_\Delta)^{n+1}-(x_\Delta-x_0)^{n+1}}=\frac{R_n'(\xi_1)}{(n+1)(\xi_1-x_0)^n} (\xi_1 在 x与 x_0 内)$
    * $=\frac{R_n'(\xi_1)-R_n'(x_0)}{(n+1)(\xi_1-x_\Delta)^n-(n+1)(x_\Delta-x_0)^n}=\frac{R_n''(\xi_2)}{(n+1)n(\xi_2-x_0)^{n-1}} (\xi_2 在 x_0 与 \xi_1 内)$
    * $=...$
    * $=\frac{R_n(\xi_n)}{(n+1)n ... 2(\xi_n-x_0)}=\frac{R_n^{(n)(\xi_n)}-R_n^{(n)}(x_0)}{(n+1)!(\xi_n-x_\Delta)-(n+1)!(x_\Delta-x_0)}$
    * $=\frac{R^{(n+1)}_n (\xi)}{(n+1)!} , (\xi 在 x_0 于 \xi_n 内) (或 \xi 在 x_\Delta 与 x内)$
    * $= \frac{f^{(n+1)}(\xi)}{(n+1)!}\Rightarrow \frac{R_n(x)}{(x-x_0)^n+1}=\frac{f^{(n+1)}(\xi)}{(n+1)!}$ 
    * $\Rightarrow R_n(x)=\frac{f^{(n+1)}\xi}{(n+1)!}(x-x_0)^{n+1}$
    * 即 $f(x)=p_n(x)+R_n(x)$
    * 其中 $P_n(x)=f(x_0)+f'(x_0)(x-x_0)+\frac{f''(x_0)}{2!}(x-x_0)^2+...+\frac{f^{(n)}(x_0)}{n!}(x-x_0)^n$
    * $ R_n(x)=\frac{f^{(n+1)}\xi}{(n+1)!}(x-x_0)^{n+1}$
    * 若 $x_0 = 0$
    * 则 $f(x)=f(0)+f'(0)x+\frac{f''(0)}{2!}x^2+...+\frac{f^{(n)}(0)}{n!}x^n+R_n(x)$ (**麦克劳林公式**)
      * 麦克劳林公式是解决 $\frac{0}{0}$ 型的优秀方法, 
  * 推论: 
    * 若 $f(x) 在 x=x_0 邻域 内 n 阶可导, 则对任意 x_0 去心邻域内点 x, 有 $
    * $f(x)=P_n(x)+o((x-x_0)^n)$
  * 证: 
    * $P_n=f(x_0)+f'(x_0)(x-x_0)+...\frac{f^{(n)}(x_0)}{n!}(x-x_0)^n$
    * $P_n(x_0)=f(x_0),P'_n(x_0)=f'(x_0), P^{(n)}_n(x_0)=f^{(n)}(x_0)$
    * $令 R_n(x)=f(x)-P_n(x)$
    * $R_n(x_0)=0,R_n'(x_0)=0, ... , R^{(n)}_n(x_0)=0$
    * $lim_{x\to x_0}\frac{R_n(x)}{(x-x_0)^n}=lim_{x-x_0}\frac{R'_n(x)}{n(x-x_0)^{n-1}}=lim_{x\to x_0}\frac{R''_n(x)}{n(n-1)(x-x_0)^{n-2}}= ....$
    * $=\frac{1}{n!}lim_{x\to x_0}\frac{R^{(n-1)}_n(x)}{x-x_0}=\frac{1}{n!}lim_{x\to x_0}R^{(n)}_n(x)=0$
    * $\Rightarrow R_n(x)=o((x-x_0)^n)$
    * $\therefore f(x)=P_n(x)+R_n(x)$
      * $R_n(x)=\begin{cases}\frac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0^{n+1}) & Lagrange 型余项\\ o((x-x_0)^n) & 匹亚诺型余项 \end{cases}$
* 基本思想: 
  * $f(x) 在 x=x_0 邻域内 n+1 阶可导$
  * $找 P_n(x) 与 f(x) 近似相等$
    * 满足: $\begin{cases} P_n(x_0) = f(x_0) \\P_n'(x_0) = f'(x_0) \\... \\ P_n^{(n)}(x_0)= f^{(n)}(x_0) \end{cases}$

* $f(x)=P_n(x)+R_n(x)$
  * $P_n(x)=f(x_0)+f'(x_0)(x-x_0)+ ... + \frac{f^{(n)}(x_0)}{n!}(x-x_0)^n$
  * $R_n(x)=\begin{cases}\frac{f^{(n+1)}(\xi)}{(n+1)!}(x-x_0)^{n+1}\\ o((x-x_0)^n) \end{cases}$

* 例题
  * 1
    * $f(x)=e^x 的 n 阶 麦克劳林公式$
    * 解: 
      * $f^{(n)}(x)=e^x, (n=0,1,2,3,....)$
      * $f(0)=1, f'(0)=1, f''(0)=1, ....$
      * $e^x=f(0)+f'(0)x+\frac{f''(0)}{2!}x^2+.... + \frac{f^{(n)}(0)}{n!}x^n+R_n(x)$
      * $=1+x + \frac{x^2}{2}+ ... + \frac{x^n}{n!}+o(x_n)$

  * 2
    * 求 $lim_{x\to 0}\frac{e^{-\frac{x^2}{2}}-1+\frac{x^2}{2}}{x^4}$
    * 解: 
      * $\because e^x=1+x+\frac{x^2}{2!}+o(x^2), \therefore e^{-\frac{x^2}{2}}=1-\frac{x^2}{2}+\frac{x^4}{8}+o(x^4)$
      * $\Rightarrow e^{-\frac{x^2}{2}}-1+\frac{x^2}{2}=\frac{x^4}{8}+o(x^4)$ ~ $\frac{1}{8}x^4$
      * $\therefore 原式 = \frac{1}{8}$

  * 3
    * $f(x)=sinx 的 n 阶 麦克劳林公式$
    * 解: 
      * $f^{(n)}(x)=sin(x+\frac{n\pi}{2})$
      * 即 $f(x)=sinx,f'(x)=cosx, f''(x)=-sinx, f'''(x)=-cosx$
      * $\therefore f(0)=0, f'(0)=1, f''(0)=0, f'''(0)=-1, f^{(4)}(0)=0, f^{(5)}(0)=1 , ...$
      * $\therefore sinx=f(0)+f'(0)x+\frac{f''(0)}{2!}x^2+\frac{f'''(0)}{3!}x^3+...$
        * $=x-\frac{1}{3!}x^3+\frac{1}{5!}x^5-\frac{1}{7!}x^7+ ... $
        * $=x-\frac{x^3}{3!}+\frac{x^5}{5!}-...+\frac{(-1)^n}{(2n+1)!}x^{2n+1}+o(x^{2n+1})$

  * 4 (例2)
    * 求 $lim_{x\to 0 }\frac{x-sinx}{x^3}$
    * 解:
      *  $\because sinx=x-\frac{x^3}{3!}+o(x^3)=x-\frac{x^3}{6}+o(x^3)$
      * $\therefore x-sinx=\frac{x^3}{6}+o(x^3)$ ~ $\frac{x^3}{6}$
      * $\therefore 原式= lim_{x\to 0}\frac{\frac{x^3}{6}}{x^3}=\frac{1}{6}$

  * 5 (例3)
    * 求 $lim_{x\to0}\frac{xcosx-sinx}{x^3}$
    * 解: 
      * $\because cosx=1-\frac{x^2}{2!}+o(x^2), \therefore xcosx= x-\frac{x^3}{2!}+o(x^3)$
      * $sinx=x-\frac{x^3}{3!}+o(x^3)=x-\frac{x^3}{6}+o(x^3s)$
      * $xcosx-sinx=-\frac{1}{3}x^3+o(x^3) $ ~ $ -\frac{1}{3}x^3$
      * $\therefore 原式 = -\frac{1}{3}$

  * 6 (例4)
    * 求 $lim_{x\to0}\frac{x-ln(1+x)}{x^2}$
    * 解: 
      * $ln(1+x)=x-\frac{x^2}{2}+o(x^2) \Rightarrow x-ln(1+x)$ ~ $\frac{x^2}{2}$
      * 则原式 = $\frac{1}{2}$

* 记: 
  1. $e^x=1+x+\frac{x^2}{2!}+ ... + \frac{x^n}{n!}+o(x^n)$
  2. $sinx= x- \frac{x^3}{3!}+\frac{x^5}{5!}-\frac{x^7}{7!}+ ... + \frac{(-1)^n}{(2n+1)!}x^{2n+1}+o(x^{2n+1})$
  3. $cosx= 1- \frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+ ... + \frac{(-1)^n}{(2n)!}x^{2n}+o(x^{2n})$
  4. $\frac{1}{1-x}=1+x+x^2+...+x^n+o(x^n)$
  5. $\frac{1}{1+x}=1-x+x^2-x^3+...+(-1)^nx^n+o(x^n)$
  6. $ln(1+x)=x-\frac{x^2}{2}+\frac{x^3}{3}-\frac{x^4}{4}+...+\frac{-1^{n-1}}{n}x^n+o(x^n)$

### 第四节 函数单调性 与 曲线的凹凸性

#### 函数单调性

* 定义
  * 1
    * $y=f(x) (x \in D)$
      * 若 $\forall x_1, x_2 \in D 且 x_1<x_2, 有 f(x_1)<f(x_2)$
        * 称 $f(x) 在 D 上 单调递增$
      * 若 $\forall x_1, x_2 \in D 且 x_1<x_2, 有 f(x_1)>f(x_2)$
        * 称 $f(x) 在 D 上 单调递减$
* 判别法
  * 定理1
    * $f(x) \in C[a,b], (a,b) 内可导$
      1. 若 $f'(x)>0 (a<x<b), 则 f(x) 在 [a,b] 上单调递增$
      2. 若 $f'(x)<0 (a<x<b), 则 f(x) 在 [a,b] 上单调递减$
    * 证明
      * 1
        * 设 $f'(x)>0 (a<x<b)$
        * $\forall x_1,x_2 \in [a,b] 且 x_1<x_2$
        * $f(x_2)-f(x_1)=f'(\xi)(x_2-x_1) (a<\xi<b)$
        * $\because f'(\xi)>0, x_2-x_1>0$
        * $\therefore f(x_2)-f(x_1)>0 \Rightarrow f(x_1)<f(x_2)$
        * $\therefore f(x) 在 [a,b] 上 单调递增$
  * 例题
    * 1
      * $y=f(x)=x^2-4x+11 , 求单调性$
      * 解:
        * $1^\circ x\in (-\infty, +\infty)$
        * $2^\circ f'(x)=2x-4=2(x-2)$
        * 令$f'(x)=0 \Rightarrow x=2$ 
        * 当 $x\in (-\infty,2) 时, f'(x)<0; 当 x\in (2,+\infty) 时, f'(x)>0$
        * $\therefore f(x) 在 (-\infty,2]上单调递增, 在 [2,+\infty]上单调递减$
    * 2
      * $y=f(x)=x^3-3x^2-9x+2 单调性$
      * 解
        * $1^\circ x\in (-\infty,+\infty)$
        * $2^\circ f'(x)=3x^2-6x-9=3(x^2-2x-3)=3(x+1)(x-3)$ 
        * 令 $f'(x)=0 \Rightarrow x=-1 或 x=3$
        * $当 x\in (-\infty,-1) 时, f'(x)>0, f(x) 在 (-\infty,-1] 上 单调递增;$
        * $当 x\in (-1,3) 时, f'(x)<0, f(x) 在 [-1,3] 上 单调递减;$
        * $当 x\in (3,+\infty) 时, f'(x)>0, f(x) 在 [3,+\infty) 上 单调递增;$
    * 3
      * $y=\sqrt[3]{x} 单调性$
      * 解
        * $1^\circ x\in (-\infty,+\infty)$
        * $2^\circ f'(x)=(x^\frac{2}{3})'=\frac{2}{3}x^{-\frac{1}{3}}=\frac{2}{3}\cdot \frac{1}{\sqrt[3]{x}}$
          * $f(x)在 x=0 处 不可导$
        * $3^\circ 当 x\in (-\infty, 0) 时, f'(x)<0, 则 f(x) 在 (-\infty,0] 上 单调递减;$
        * 当 $x\in (0,+\infty) 时, f'(x)>0$
        * 则 $f(x) 在 [0,+\infty) 上 单调递增$
    * 4
      * $证: 当 x>0 时, \frac{x}{1+x} < ln(1+x)<x$
      * 证: 
        * 令 $f(x)=x-ln(1+x), f(0)=0$
        * $f'(x)=1-\frac{1}{1-x}=\frac{x}{1+x}>0 (x>0)$
        * $\Rightarrow f(x) 在 [0,+\infty) 单调递增$
        * $\therefore 当 x>0 时, f(x)>f(0)=0 \Rightarrow ln(1+x)<x;$
        * 令 $g(x)=ln(1+x)-\frac{x}{1+x}, g(0)=0$
        * $g'(x)=\frac{1}{1+x}-\frac{1+x-x}{(1+x)^2}=\frac{1}{1+x}-\frac{1}{(1+x)^2}$
        * $=\frac{x}{(1+x)^2}>0 , (x>0)$
        * 则 $g(x)$ 在 $[0,+\infty)$ 上 单调递增
        * $\therefore 当 x>0 时, g(x)>g(0)=0 \Rightarrow \frac{x}{1+x} < ln(1+x)$
    * 5
      * $e<a<b , 证: a^b>b^a$
      * 证: 
        * $a^b>b^a \Leftrightarrow blna>alnb \Leftrightarrow blna - alnb >0$
        * 令 $f(x)=xlna-alnx , f(a)=0$
        * $f'(x)=lna-\frac{a}{x}>0 , (a<x<b)$
        * $则 f(x) 在 [a,b] 单调递增$
        * $\therefore 当 x>a 时, f(x)>f(a)=0$
        * $\because b> a, \therefore f(b)>f(a)=0$
        * $\therefore blna-alnb > 0$
        * $\therefore a^b>b^a$
    * 6
      * 证明 $当 x>1 时, 2\sqrt x > 3-\frac{1}{x}$
      * 证: 
        * 令 $f(x)=2\sqrt x -3 + \frac{1}{x}, f(1)=0$
        * $f'(x)=2*\frac{1}{2}x^{-\frac{1}{2}}-\frac{1}{x^2}=\frac{1}{\sqrt x}-\frac{1}{x^2}>0 , (x>1)$
        * 则 $f(x) 在 [1,+\infty) 上 单调递增$
        * $\therefore 当 x>1 时, f(x)>f(1)=0 \Rightarrow 2\sqrt x> 3-\frac{1}{x}$

#### 曲线凹凸性

* 定义

  * $y=f(x) (x\in D)$

  1. 若 $\forall x_1, x_2 \in D 且 x_1 \ne x_2, 有 $
     * $f(\frac{x_1+x_2}{2}) < \frac{f(x_1)+f(x_2)}{2}$
     * 称 $f(x)$ 在 $D$ 内为 凹函数
  2. 若 $\forall x_1,x_2 \in D 且 x_1 \ne x_2 , 有$
     * $f(\frac{x_1+x_2}{2}) > \frac{f(x_1)+f(x_2)}{2}$
     * 称 $f(x) 在 D 内为 凸函数$

* 判别法
  * 引论
    * 设 $f(x)$ 二阶可导, 且 $f''(x)>0 (<0), x_0 \in D , 则 $
      * $f(x) \geq (f(x_0) + f'(x_0)(x-x_0))$ 
      * (或 $f(x)\leq (f(x_0)+f'(x_0)(x-x_0))$)
      * 且 "=" 成立 $\Leftrightarrow x=x_0$ 
    * 证明
      * 设 $f''(x)>0$
      * 由 Taylor 公式, $f(x)=f(x_0)+f'(x_0)(x-x_0)+\frac{f''(\xi)}{2!}(x-x_0)^2$ ,  ($\xi 介于 x_0 与 x 之间$)
      * $\because f''(x)>0$
      * $\therefore R(x)=\frac{f''(\xi)}{2!}(x-x_0)^2\ge 0$
      * 且 $R(x)=0 \Leftrightarrow x=x_0$
      * $\therefore f(x) \ge f(x_0)+f'(x)(x-x_0)$
      * $当 "=" 成立时 \Leftrightarrow x=x_0$
      * 当 $f''(x)<0, 则 R(x)=\frac{f''(\xi)}{2!}(x-x_0)^2\le 0$
      * $R(x)=0 \Leftrightarrow x=x_0 $
      * $\therefore f(x)\le f(x_0)+f'(x_0)(x-x_0)$
      * $= 成立 \Leftrightarrow x+x_0$
  * Note: 
    * $若 f''(x)>0, 则 当 x \ne x_0 时, $
      * $f(x)>(f(x_0)+f'(x_0)(x-x_0));$
    * $若 f''(x)<0, 则 当 x\ne x_0 时, $
      * $f(x)<(f(x_0)+f'(x_0)(x-x_0))$
* 定理
  * 2
    * $f(x)\in C[a,b], (a,b) 内 二阶可导$
      1. 若 $f''(x)>0\ (a<x<b), 则 y=f(x) 图像 在 [a,b] 上是 凹的$
      2. 若 $f''(x)<0\ (a<x<b), 则 y=f(x) 图像在 [a,b] 上是 凸的$
    * 证明: 
      * 1
        * 设 $f'' (x)>0\ (a<x<b)$
        * $\forall x_1,x_2 \in [a,b] 且 x_1\ne x_2$
        * $x_0 \triangleq \frac{x_1+x_2}{2}$
        * $\because f''(x)>0, \therefore x\ne x_0 时, f(x)> (f(x_0)+f'(x_0)(x-x_0))$
        * 取 $x=x_1, x=x_2$
        * 有 $\begin{cases} f(x_1) > f(x_0)+f'(x_0)& (x_1-x_0) & (*) \\ f(x_2) > f(x_0)+f'(x_0) & (x_2-x_0) & (**) \end{cases}$
        * $\Rightarrow \begin{cases} \frac{1}{2}f(x_1)> \frac{1}{2}f(x_0)+f'(x_0)\cdot \frac{1}{2}(x_1-x_0) \\ \frac{1}{2}f(x_2)> \frac{1}{2}f(x_0)+f'(x_0)\cdot \frac{1}{2}(x_2-x_0) \end{cases}$
        * $\Rightarrow \frac{f(x_1)+f(x_2)}{2} > f(x_0)+f'(x_0)\cdot (\frac{x_1+x_2}{2}-x_0)=f(x_0) $
        * $\Rightarrow f(\frac{x_1+x_2}{2})<\frac{f(x_1)+f(x_2)}{2}$
        * 即 $\forall x_1,x_2 \in [a,b] 且 x_1\ne x_2, 有$
        * $ f(\frac{x_1+x_2}{2})<\frac{f(x_1)+f(x_2)}{2}$
        * $\therefore y=f(x) 在 [a,b] 上 凹$
* Note:
  * 凹凸判断步骤
    1. $x\in D$
    2. $f''(x)\begin{cases} =0 \\ 不存在 \end{cases} \Rightarrow x=?$
    3. 每个区间内 $f'' >0 \ \ or \ \ < 0?$

* 例子
  * 1
    * $y=lnx$
    * 解: 
      * $1^\circ \ \ \ x\in (0,+\infty);$
      * $2^\circ \ \ \ y'=\frac{1}{x}, y''=-\frac{1}{x^2}$
      * $\because y''<0, \therefore y= lnx 在 (0,+\infty) 内为 凸函数$
  * 2
    * $y=x^3$
    * 解: 
      * $1^\circ$
        * $x\in (-\infty,+\infty)$
      * $2^\circ$
        * $y'=3x^2, y'' = 6x$
        * $令 y'' =0 \Rightarrow x=0$
      * $3^\circ$
        * $当 x\in (-\infty, 0 ) 时, y''<0, \therefore y=x^3 在 (-\infty, 0] 上 是 凸的$
        * $当 x\in (0,+\infty) 时 , y'' > 0, \therefore y=x^3 在 [0,+\infty )上 时 凹的$
        * $(0,0) 为 y=x^3 的拐点$
  * 3
    * $y=e^{-x^2}$
    * 解: 
      * $1^\circ$
        * $x\in (-\infty, +\infty)$
      * $2^\circ$
        * $y'=-2xe^{-x^2},$
        * $y''=-2e^{-x^2}+4x^2e^{-x^2}=4(x^2-\frac{1}{2})e^{-x^2}$
        * 令 $y''=0 \Rightarrow x= \pm\frac{1}{\sqrt2}$
      * $3^\circ$
        * $当 x\in (-\infty, -\frac{1}{\sqrt2}) 时, y''>0 \Rightarrow y=e^{-e^2} 在 (-\infty, -\frac{1}{\sqrt2}] 上凹;$
        * $当 x\in (-\frac{1}{\sqrt2}, \frac{1}{\sqrt2}) 时, y''<0 \Rightarrow y=e^{-e^2} 在 [-\frac{1}{\sqrt2}, \frac{1}{\sqrt2}] 上凸;$
        * $当 x\in (\frac{1}{\sqrt2}, \infty) 时, y''>0 \Rightarrow y=e^{-e^2} 在 [\frac{1}{\sqrt2}, \infty] 上凹;$
        * $(-\frac{1}{\sqrt2}, e^{-\frac{1}{2}}) 与 (\frac{1}{\sqrt2}, e^{-\frac{1}{2}}) 为 y=e^{-x^2}的拐点$

### 第五节 极值与最值

>  $0<|x-x_0|<\delta$ 叫做 $x_0$的 去心邻域

#### 函数的极大值 和 极小值

* 定义 - 当$ y=f(x) ,(x\in D), x_0 \in D$

  1. If $ \exists \delta > 0 , 当 0<|x-x_0|<\delta 时, 有 $
     * $f(x) > f(x_0)$
     * 称 $x_0$ 为极小点, $f(x_0) 为 极小值$
  2. If $ \exists \delta > 0 , 当 0<|x-x_0|<\delta 时, 有 $
     * $f(x) < f(x_0)$
     * 称 $x_0$ 为极大点, $f(x_0) 为 极大值$

* 附:

  * $f'(a) = \begin{cases} >0 \\ <0 \\ =0 \\无 \end{cases}$
  * If $f'(a)>0, 既 lim_{x\to a}\frac{f(x)-f(a)}{x-a}>0$
  * $\exists \delta >0, 当 0<|x-a|<\delta 时, \frac{f(x)-f(a)}{x-a}>0$
  * $\begin{cases} f(x)<f(a)&x\in (a-\delta , a) \\ f(x)> f(a) & x\in (a,a+\delta) \end{cases}$
  * $f'(a)>0 \Rightarrow $ 左低右高 ; (x=a 为 极值点)
  * 同理 $f'(a)<0 \Rightarrow$ 左高右低 ; (x=a 为极值点)

* 结论: 

  1. $x= a 为 f(x) 的极值点 \Rightarrow f'(a)=0 或 f'(a) 不存在$

  2. $x=a 为 f(x) 极值点 且 f(x) 可导 \Rightarrow f'(a) =0 $

  3. 上述结论反之则不对

     * 反例

       1. 

          * $y=f(x)=x^3$

          * $f'(0)=0$
          * $x=0 不是极值点$

       2.  

          * $y=f(x)=\begin{cases} x+1 & x<0 \\ e^{2x} & x\ge 0 \end{cases}$
          * $f'_-(0)=1 \ne f_+'(0)=2$
          * $\Rightarrow x=0 为 f(x) 不可导点, 但 x=0 不是极值点$

#### 求极值步骤

* $y=f(x)$
  * $1^\circ$
    * $ x\in D$
  * $2^\circ$
    * $f'(x)\begin{cases} =0 \\ 不存在 \end{cases} \Rightarrow x=? ; (不一定)$
  * $3^\circ$ 判别法
    * 方法一: (第一充分条件)
      * 定理1
        * If $\begin{cases} x< x_0 时, f'(x) < 0 \\ x>x_0 时, f'(x)> 0 \end{cases}$
          * $x=x_0 为极小点$
        * If $\begin{cases} x<x_0 时, f'(x_0)>0 \\ x>x_0 时, f'(x)<0 \end{cases}$
          * $x=x_0 为 极大点$
        * 例题
          * 1
            * $f(x)=x^3-6x^2+2$
            * 解: 
              * $1^\circ $
                * $x \in (-\infty, +\infty)$
              * $2^\circ$
                * $f'(x)=3x^2-12x=3x(x-4)$
                * 令 $f'(x)=0 \Rightarrow x=0 或 x=4$
              * $3^\circ$
                * $\because \begin{cases} x<0 时 & f'(x)>0 \\0<x<4 时 & f'(x)<0 \end{cases}$
                  * $\therefore x=0 为极大点, 极大值 f(0)=2;$
                * $\because \begin{cases} 0<x<4 时 & f'(x)<0 \\ x>4 时 & f'(x)>0 \end{cases}$
                  * $\therefore x=4 为 极小点, 极小值 f(4)= -30$
    * 方法二: (第二充分条件)
      * 定理:
        * 设 $f'(x_0)=0, f''(x_0)\begin{cases} >0 & x_0 为极小点 \\ <0 \end{cases}$
        * Case1: 
          * $f''(x_0)> 0$
          * 即 $f''(x_0)=lim_{x-x_0}\frac{f'(x)}{x-x_0}>0$
          * $\exists \delta > 0 , 当 0<|x-x_0|<\delta 时, \frac{f'(x)}{x-x_0}>0$ 
          * $\begin{cases} f'(x)<0, x\in (x_0-\delta, x_0) \\ f'(x)>0, x\in (x_0, x_0+\delta) \end{cases}$
          * $\Rightarrow x=x_0 为 极小点$
        * Case 2
          * $f''(x_0)<0$
          * $即 lim_{x\to x_0}\frac{f'(x)}{x-x_0}<0$
          * $\exists \delta > 0 , 当 0<|x-x_0|<\delta 时, \frac{f'(x)}{x-x_0}<0$ 
          * $\begin{cases} f'(x)>0, x\in (x_0-\delta, x_0) \\ f'(x)<0, x\in (x_0, x_0+\delta) \end{cases}$
          * $\Rightarrow x=x_0 为 极大点$
* 例题
  * 2
    * $f'(1)=0, lim_{x\to 1}\frac{f'(x)}{sinx\pi x}=2, 问 x=1 是什么点$
    * 解
      * 法一:
        * $\because lim_{x\to 1}\frac{f'(x)}{sin\pi x}=2 >0$
        * $\therefore \exists \delta > 0 , 当 0< |x-1|<\delta 时, \frac{f'(x)}{sin\pi x} >0$
        * $\begin{cases} f'(x)>0, x\in (1-\delta, 1) \\ f'(x)<0, x\in (1,1+\delta) \end{cases}$
        * $\therefore x=1 为 极大点$
      * 法二: 
        * $f'(1)=0$
        * $2=lim_{x\to 1}\frac{f'(x)}{sin[\pi + \pi (x-1)]}=-lim_{x\to 1}\frac{f'(x)}{sin\pi (x-1)}$
        * $=-lim_{x\to1}\frac{f'(x)}{\pi(x-1)}=-\frac{1}{\pi}lim_{x\to 1}\frac{f'(x)-f'(1)}{x-1}$
        * $=-\frac{1}{\pi}f''(1)$
        * $\Rightarrow f''(1)=-2\pi < 0$
        * $\because f'(1)=0, f''(1)<0$
        * $x=1$ 为 极大点
  * 3
    * $y=f(x) \in C(-\infty, +\infty ), 问 f(x) 有几个 极值点$
    * 解: 
      * $1^\circ$
        * $x\in (-\infty, +\infty);$
      * $2^\circ$
        * $f'(x)\begin{cases} =0 \\ 无 \end{cases} \Rightarrow x=a,0,b,c ;$
      * $3^\circ$
        * $\begin{cases} x<a & f'>0 \\ x>a & f'<0 \end{cases}\Rightarrow x=a 为极大点$
        * $\begin{cases} x<0 & f'<0 \\ x>0 & f'<0 \end{cases}\Rightarrow x=0 不是极值点$
        * $\begin{cases} x<b & f'<0 \\ x>b & f'>0 \end{cases}\Rightarrow x=b 为极小点$
        * $\begin{cases} x<c & f'>0 \\ x>c & f'>0 \end{cases}\Rightarrow x=c 为极大点$



#### 最大值 与 最小值

* (一) $f(x)\in C[a,b]$
  * If $f(x)\in C[a,b] , then \exists m,M$
  * $1^\circ$
    * $f'(x) \begin{cases} =0 \\ 不存在 \end{cases}, (a<x<b) \Rightarrow x_1,x_2,...,x_m$
  * $2^\circ$
    * $m=min\{f(a),f(x_1),...,f(x_n),f(b)\}$
    * $M=max\{f(a), f(x_1),...,f(x_n),f(b)\}$
* 例子
  * 1
    * 求 $y=x^3-3x^2-4x+1, 在 [-2,4] 上的 m, M$
    * 解: 
      * $1^\circ$
        * 令 $f'(x)=3x^2-6x-9=3(x^2-2x-3)=3(x+1)(x-3)=0$
        * $\Rightarrow x_1=-1, x_2=3;$
      * $2^\circ$
        * $f(-2)=-1$
        * $f(-1)=6$
        * $f(3)=-26$
        * $f(4)=173$
      * $\therefore m=-26, M=173$
  * 2
    * $设 p>1, 证: 当 \in [0,1] 时, 2^{\frac{1}{p-1}}\le x^p+(1-x)^p \le 1$
      * 证: 
        * $f(x)=x^p+(1-x)^p \in C[0,1]$
        * $令 f'(x)=px^{p-1}-p(1-x)^{p-1}=0 \Rightarrow x=\frac{1}{2}$
        * $\because f(0)=1=f(1)=1 > f(\frac{1}{2})=\frac{1}{2^{p-1}}$
        * $\therefore m=\frac{1}{2^{p-1}}, M=1 \therefore 2^{\frac{1}{p-1}}\le x^p+(1-x)^p \le 1$

### 第六节 函数图像描绘

* $y=f(x):$
  * $1^\circ$  $x\in D;$
  * $2^\circ$  $f'(x)\begin{cases} =0 \\ 不存在 \end{cases}$ ;
  * $3^\circ$  $f''(x)\begin{cases} =0 \\ 不存在 \end{cases}$ ;
  * $4^\circ$  渐近线;
  * $5^\circ$  描图
* 渐近线
  1. 水平渐近线 - $L: y=f(x)$
     * 若 $lim_{x\to \infty} f(x)=A , 称 y=f(x) 有水平渐近线 y=A;$
     * 例题1: $求 y=\frac{2x^2+1}{x}sin\frac{1}{x} 的水平渐近线$
       * 解: 
         * $\because lim_{x\to\infty}y=lim_{x\to\infty}\frac{2x^2+1}{x^2}\cdot \frac{sin\frac{1}{x}}{\frac{1}{x}}=2$
         * $\therefore y=2 为水平渐近线$
  2. 铅直渐近线 - $L: y=f(x)$
     * If $lim_{x\to a}f(x)=\infty, 称 x=a 为 铅直渐近线$
     * 例题2: 求 $y=f(x)=\frac{x^2-3x+2}{x^2-1} 水平, 铅直渐近线$
       * 解: 
         * $\because lim_{x\to\infty}f(x)=1 , \therefore y=1 为 水平渐近线$
         * $\therefore lim_{x\to -1}f(x)=\infty, \therefore x=-1 为 铅直渐近线$
         * $又 \because lim_{x\to 1} f(x)= lim_{x\to 1}\frac{x-2}{x-1}=-\frac{1}{2}$
         * $\therefore x=1 不是铅直渐近线$
  3. 斜渐近线 - $L: y=f(x)$
     * If $lim_{x\to \infty }\frac{f(x)}{x}=a(\ne 0,\infty)$
     * $lim_{x\to \infty}[f(x)-ax]=b$
     * $称 y=ax+b 为 斜渐近线$
     * 例题3: 求 $y=\frac{x^3-x}{x^2-x-2} 的 渐近线$
     * 解: 
       * $\therefore lim_{x\to\infty}y=\infty, \therefore 无水平渐近线;$
       * $lim_{x\to -1}y=lim_{x\to -1}\frac{x(x-1)(x+1)}{(x+1)(x-2)}=lim_{x\to-1}\frac{x(x-1)}{x-2}=-\frac{2}{3}$
       * $\therefore x=-1 为铅直渐近线$
       * $\because lim_{x\to 2}y=\infty, \therefore x=2 为铅直渐近线$
       * $\because lim_{x\to\infty}\frac{y}{x}=1$
       * $lim_{x\to \infty}(y-x)=lim_{x\to \infty} (\frac{x^3-x}{x^2-x-2}-x)=lim_{x\to\infty}\frac{x^2+x}{x^2-x-2}=1$
       * $\therefore y=x+1 为 斜渐近线$
     * 例题4: 求 $y=xln(e+\frac{3}{x}) (x>0) 的 斜渐近线$
     * 解: 
       * $\because lim_{x\to+\infty}\frac{y}{x}=lim_{x\to+\infty}ln(e+\frac{3}{x})=1$
       * $lim_{x\to+\infty}(y-x)=lim_{x\to+\infty}x[ln(e+\frac{3}{x})-1]$
       * $=lim_{x\to+\infty}\frac{ln(e+\frac{3}{x}-1)}{\frac{1}{x}}\overset{\frac{1}{x}=t}{=}lim_{t\to0}\frac{ln(e+3t)-1}{t}$
       * $=lim_{t\to0}\frac{3}{e+3t}=\frac{3}{e}$
       * $\therefore 斜渐近线, y=x+\frac{3}{e}$

* 做图 $y=f(x)$

  1. $x\in D$ ;

  2. $f'(x)\begin{cases} =0 \\ 无 \end{cases}$  ;

  3. $f''(x)\begin{cases} =0 \\ 无 \end{cases}$ ;

  4. 渐近线

  5. 

  6. | x      | (  ) | ?    | (  ) | ?    | (  ) | ?    | (  ) | ?    | ...  |
     | ------ | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
     | f'(x)  | +    |      | -    |      | -    |      | +    |      |      |
     | f''(x) | +    |      | +    |      | -    |      | -    |      |      |
     | f(x)   | ↗凹  | 极大 | ⤵凹  | 拐点 | 凸⤵  | 极小 | 凸↗  |      |      |

     找关键点, 描图

* 例题1: 作 $y=x^3-x^2-x $图

  * 解: 

    1. $x\in (-\infty, +\infty);$

    2. 令 $y'=3x^2-2x-1=0 \Rightarrow x=-\frac{1}{3}, x=1;$

    3. 令 $y''=6x-2=0 \Rightarrow x=\frac{1}{3}$

    4. $lim_{x\to \infty}y=\infty \Rightarrow 无水平渐近线\ ,\ lim_{x\to\infty}\frac{y}{x}=\infty \Rightarrow 无斜渐近线$

    5. 

       | x     | $(-\infty,-\frac{1}{3})$ | $-\frac{1}{3}$ | $(-\frac{1}{3},\frac{1}{3})$ | $\frac{1}{3}$ | $(\frac{1}{3},1)$ | 1    | (1,+\infty) |
       | ----- | ------------------------ | -------------- | ---------------------------- | ------------- | ----------------- | ---- | ----------- |
       | $y'$  | +                        |                | -                            |               | -                 |      | +           |
       | $y''$ | -                        |                | -                            |               | +                 |      | +           |
       | y     | 凸增                     | 极大           | 凸减                         | 拐点          | 凹减              | 极小 | 凹增        |

       $y(-\frac{1}{3})=\frac{32}{27}, \frac{1}{3}=\frac{16}{27}, f(1)=0, y(-\infty)=-\infty, y(+\infty)=+\infty$

    6. 绘图 略

* 例题2: $y=e^{-x^2}$

* 解: 

  1. $x\in (-\infty, +\infty)$

  2. 令 $y'=-2xe^{-x^2}=0 \Rightarrow x=0$ ; 

  3. 令 $y''=(4x^2-2)e^{-x^2}=0 \Rightarrow x=\pm \frac{1}{\sqrt2}$

  4. $lim_{x\to \infty} y=0 \Rightarrow y=0 水平渐近线$

  5. 

  6. | x    | $(-\infty, -\frac{1}{\sqrt2})$ | $-\frac{1}{\sqrt2}$ | $(-\frac{1}{\sqrt2},0)$ | 0    | $(0,\frac{1}{\sqrt2})$ | $\frac{1}{\sqrt2}$ | $(\frac{1}{\sqrt2},+\infty)$ |
     | ---- | ------------------------------ | ------------------- | ----------------------- | ---- | ---------------------- | ------------------ | ---------------------------- |
     | y'   | +                              |                     | +                       |      | -                      |                    | -                            |
     | y''  | +                              |                     | -                       |      | -                      |                    | +                            |
     | y    | 凹增                           | 拐点                | 凸增                    | 极大 | 凸减                   | 拐点               | 凹减                         |

### 第七节 弧微分 与 曲率

* 弧微分
  * $L: y=f(x)$
    1. $(\Delta s)^2≈ (\Delta x)^2+(\Delta y)^2$
       * $\Delta y = f(x+\Delta x)-f(x)$
    2. $(ds)^2=(dx)^2+(dy)^2$
       1. $ds=\sqrt{(dx)^2+(dy)^2}$
  * so
    * Cases1: $L: y=f(x)$
      * $ds= \sqrt{1+(\frac{dy}{dx})^2}dx  = \sqrt{1+f'^2(x)}dx$
      * 即 $ds=\sqrt{1+f'^2(x)}dx \ ;$
    * Case2: $L: \begin{cases} x=\phi(t) \\ y=\psi(t) \end{cases}$
      * $ds=\sqrt{(dx)^2+(dy)^2} = \sqrt{(\frac{dx}{dt})^2 + (\frac{dy}{dt})^2}dt=\sqrt{\phi'^2(t)+\psi'^2(t)}dt$
      * 即 $ds=\sqrt{\phi'^2(t)+\psi'^2(t)}dt$
* 曲率与曲率半径
  * $L: y=f()x$
    * $|\overset{\frown}{MM'}|=\Delta s$
    * $\overset{\_}k=\frac{|\Delta\alpha|}{|\Delta S|}$ , ($\overset{\_}{k}$ 表示平均曲率)
  * M 点 处的曲率
    * $k=lim_{\Delta x\to 0}|\frac{\Delta\alpha}{\Delta s}|=|\frac{d\alpha}{ds}|$ ($\alpha 为 x 的函数$)
    * $ds= \sqrt{1+y'^2}dx$
    * $tan\alpha = y' =f'(x)$
    * 两边对 x 求导
    * $sec^2\alpha \cdot \frac{d\alpha}{dx}=y''=f''(x)$
    * $\because sec^2\alpha = 1+tan^2\alpha = 1+y'^2$
    * $\therefore \frac{d\alpha}{dx}=\frac{y''}{1+y'^2}\Rightarrow d\alpha = \frac{y''}{1+y'^2}\cdot dx$
    * $ds=\sqrt{1+y'^2}dx$
    * $d\alpha=\frac{y''}{1+y'^2}dx$
    * $\therefore k=|\frac{d\alpha}{ds}|=\frac{|y''|}{(1+y'^2)^\frac{3}{2}}$
* 例题
  * 1
    * 求 $L: y=sinx 在 x=\frac{\pi}{4} 对应点处的曲率$
    * 解:
      * $y'=cosx, y'(\frac{\pi}{4})=\frac{\sqrt{2}}{2}$
      * $y''=-sinx, y''(\frac{\pi}{4})=-\frac{\sqrt2}{2}$
      * $therefore x=\frac{\pi}{4} 对应曲线 y=sinx 在的点 (\frac{\pi}{4},\frac{\sqrt 2}{2}) 处的曲率为 $
        * $k=\frac{|y''|}{(1+y'^2)^\frac{3}{2}}=\frac{\frac{\sqrt2}{2}}{\frac{3}{2}\cdot \sqrt\frac{3}{2}}=\frac{\sqrt2}{\frac{3\sqrt3}{2}}=\frac{2}{3\sqrt3}$
  * 2
    * 求 $y=x^2-4x+11 曲率最大点的座标$
    * 解:
      * $y'=2x-4, y''=2$
      * $k(x)=\frac{|y''|}{(1+y'^2)^\frac{3}{2}}=\frac{2}{[1+(2x-4)^2]^\frac{3}{2}}$
      * 当 $2x-4=0, 即 x=2 时, 曲率最大$
      * $k_{max}=2$
      * 所求点 $(2,7)$



## 第四章 不定积分

### 第一节 不定积分的概念与性质

* 引子

  * $y=x^3, (x^3)'=? $

  * $3x^2=(?)': 3x^2=(x^3+C)'$

  * $\frac{x}{1+x^4}=(?)'$
* 不定积分的概念
  1. 原函数 - 设 $f(x), F(x) (x\in I) , 若 \forall x\in I, 有 $
     * $F'(x)=f(x)$
     * $F(x)$称为 $f(x)$ 的 一个原函数
     * Notes: 
       1. 一个函数有原函数, 则一定有不止一个 原函数
          * 设 $F'(x)=f(x), 即 F(x) 为 f(x) 的 原函数$
          * 则 $[F(x)+C]'=F'(x)+(C)'=f(x)$
          * $\Rightarrow F(x)+C 也是 f(x) 的 原函数$
       2. 一个函数的两个原函数之间相差常数
          * 设 $F(x), \Phi(x) 均为 f(x) 的 原函数$
          * 即 $F'(x)=f(x), \Phi'(x)=f(x)$
          * $\Rightarrow [F(x)-\Phi(x)]' = F'(x)-\Phi'(x)\equiv 0$
          * $\therefore F(x)-\Phi(x)\equiv C_0$
       3. 设 $F(x) 为 f(x) 的 一个原函数, 则 F(x)+C 为 f(x) 的一切原函数 (C 为常数)$
  2. 不定积分 - 设 $F(x)为 f(x) 的 一个 原函数, F(x)+C 为 f(x) 的 所有原函数, $
     * $F(x)+C$, 记$\int f(x)dx$
     * 即 $\int f(x)dx = F(x)+C$
  3. 例题
     1. $\int x^2 dx$
        * 解: 
          * $\because (\frac{1}{3}x^3)' = x^2, \therefore \int x^2 dx=\frac{1}{3}x^3+c$
     2. $\int xe^{x^2}dx$
        * 解:
          * $\because (\frac{1}{2}e^{x^2})'=\frac{1}{2}e^{x^2}\cdot 2x=xe^{x^2}$
          * $\therefore \int xe^{x^2}dx=\frac{1}{2}e^{x^2}+C$
     3. $\int \frac{x}{1+x^4}dx$
        * 解: 
          * $\because (\frac{1}{2}arctanx^2)'=\frac{1}{2}\frac{1}{1+(x^2)^2}\cdot 2x=\frac{x}{1+x^4}$
          * $\therefore \int \frac{x}{1+x^4}dx=\frac{1}{2}arctanx^2+C$

#### 不定积分工具 (一)- 不定积分基本公式

* 求导
  * 幂函数
  * 指数函数
  * 对数函数
  * 三角函数
  * 反三角函数
* 不定积分 基本公式
  1. $\int Kdx=Kx+c $ ;
  2. $\int x^a dx$ - 幂函数
     1. $a\ne -1 时, \because (\frac{1}{a+1}x^{a+1})'=x^a$
        * $\therefore \int x^a dx = \frac{1}{a+1}x^{a+1}+C;$ ;
     2. $a=-1$
        * If $x<0, [ln(-x)]'=\frac{1}{x} \Rightarrow \int \frac{1}{x}dx=ln(-x)+C$
        * $\therefore \int\frac{1}{x}dx = ln |x|+C$
          * 如: 
            * $\int \frac{1}{x^4}dx=\int x^{-4}dx=-\frac{1}{3}x^{-3}+C$
            * $\int \frac{1}{x\sqrt x}dx=\int x^{-\frac{3}{2}}dx=-2x^{-\frac{1}{2}}+C$
  3. $(\frac{a^x}{lna})'=a^x$ - 指数函数
     1. $\int a^xdx=\frac{a^x}{lna}+C$
     2. $a=e 时, \int e^xdx=e^x+C$
  4. 三角函数
     1. $\int sinxdx=$
        * $\because (-cosx)'=sinx$
        * $\therefore \int sinxdx=-cosx+C$
     2. $\int cosxdx = $
        * $\because (sinx)'=cosx$
        * $\therefore \int cosxdx=sinx+C$
     3. $\int sec^2xdx=$
        * $\because (tanx)'=sec^2x$
        * $\therefore \int sec^2xdx=tanx+C$
     4. $\int csc^2xdx=$
        * $\because (-cotx)'=csc^2x$ 
        * $\therefore \int csc^2xdxs=-cotx+C$
     5. $\int secxtanxdx=$
        * $\because (secx)'=secxtanx$
        * $\therefore \int secxtanx dx=secx+C$
     6. $\int cscxcotxdx=$
        * $\because (-cscx)'=cscxcotx$
        * $\therefore \int cscxcotxdx = -cscx+C$
* Note: 
  1. $\int f'(x)dx=f(x)+C$
  2. $(\int f(x)dx)'=[F(x)+C]'$
     * $=f(x)$
     * e.g.
       * $\int (x^2)'dx = x^2$

#### 不定积分 性质

1. $\int [f(x)\pm g(x)]dx=\int (fx)dx\pm \int g(x)dx$
   * 证明: 
     * 令 $\int f(x)dx=F(x)+C , \int g(x)dx=G(x)+C$
     * $则 F'(x)=f(x), G'(x)=g(x)$
     * $\because (\int[f(x)\pm g(x)]dx)'=f(x)\pm g(x)$
     * $(\int f(x)dx\pm \int g(x)dx)'=(\int f(x)dx)'\pm (\int g(x)dx)'=f(xs)\pm g(x)$
2. $\int af(x)dx=a\int f(x)dx$

* 例题

  * 4
    * $\int (3e^x-\frac{1}{x}+sec^2x+2)dx$
    * 解: 
      * $\int(3e^x-\frac{1}{x}+sec^2x+2)dx$
      * $=3\int e^xdx-\int \frac{1}{x}dx+\int{sec^2x}dx+\int 2dx$
      * $=3e^x-ln|x|+tanx+2x+C$

  * 5
    * $\int{\frac{x^4}{x^2+1}}dx$
    * 解: 
      * $\int \frac{x^4}{x^2+1}dx=\frac{(x^4-1)+1}{x^2+1}dx=\int(x^2-1+\frac{1}{x^2+1})dx$
      * $\int x^2dx-\int1dx+\int \frac{1}{1+x^3}dx=\frac{1}{3}x^3-x+arctanx+C$

### 第二节 积分方法-换元积分法(一) 

#### 第一类换元积分法

* 公式
  * $f'(x)dx=df(x)$
    * 证明: 
      * $f'(x) = lim_{Δx→0} \frac{f(x + Δx) - f(x)}  {Δx}$
      * $\because df(x) = f(x + Δx) - f(x)$
      * $f'(x) = lim_{Δx→0} \frac{df(x)}  {Δx}$
      * $\therefore f'(x)dx=df(x)$
* 例题
  * 1
    * $\int xe^{x^2}dx$
    * 解: 
      * $\int xe^{x^2}dx=\frac{1}{2}\int e^{x^2}d(x^2)\overset {x^2=t}{=}\frac{1}{2}\int e^tdt$
      * $=\frac{1}{2}e^t+C=\frac{1}{2}e^{x^2}+C$
  * 2
    * $\int\frac{x}{1+x^4}dx$
    * 解:
      * $\int\frac{x}{1+x^4}dx=\frac{1}{2}\int\frac{1}{1+(x^2)^2}d(x^2)\overset{x^2=t}{=}\frac{1}{2}\int \frac{1}{1+t^2}dt$
      * $=\frac{1}{2}arctant+C=\frac{1}{2}arctanx^2+C$
  * 3
    * $\int \frac{1}{x^2}cos\frac{1}{x}dx$
    * 解:
      * $\therefore (\frac{1}{x})'=-\frac{1}{x^2}, \therefore (-\frac{1}{x})'=\frac{1}{x^2}$
      * $\int \frac{1}{x^2}cos\frac{1}{x}dx=-\int cos\frac{1}{x}d(\frac{1}{x})\overset{\frac{1}{x}=t}{=}-\int costdt=-sint+C=-sin\frac{1}{x}+C$
  * 4
    * $\int \frac{1}{2x+3}dx$
    * 解:
      * $\int \frac{1}{2x+3}dx=\frac{1}{2}\int\frac{1}{2x+3}d(2x+3)\overset{2x+3=t}{=}\frac{1}{2}\int\frac{1}{t}dt$
      * $=\frac{1}{2}ln|t|+C=\frac{1}{2}ln|2x+3|+C$

* 定理1
  * $f(u) \exists 原函数, \phi (x) 可导, F(u) 为 f(u) 的 原函数, 则 $
  * $\int f[\phi(x)]\phi'(x)dx=\int f[\phi(x)]d\phi(x)\overset{\phi(x)=t}{=}\int f(t)dt=F(t)+C=f[\phi(x)]+C$
  * 称为 **第一类换元积分法**
* 例题1
  1. $\int \frac{1}{x^2-x-2}dx$
     * $(记: \int \frac{1}{1+x^2}dx=arctanx+c)$
     * $\int \frac{1}{x^2-x-2}dx=\int \frac{1}{(x+1)(x-2)}dx=\frac{1}{3}\int(\frac{1}{x-2}-\frac{1}{x+1})dx$
     * $=\frac{1}{3}\int \frac{1}{x-2}d(x-2)-\frac{1}{3}\int\frac{1}{x+1}d(x+1)$
     * $=\frac{1}{3}ln|x-2|-\frac{1}{3}ln|x+1|+c=\frac{1}{3}ln |\frac{x-2}{x+1}|+c$
  2. $\int \frac{dx}{x^2+2x+2}$
     * $\int \frac{1}{1+(x+1)^2}d(x+1) = arctan(x+1)+c$
  3. $\int \frac{x}{x^2+3}dx$
     * 解: $\int\frac{x}{x^2+3}dx=\frac{1}{2}\int \frac{1}{x^2+3}d(x^2+3)=\frac{1}{2}ln(x^2+3)+c$
  4. $\int \frac{sinx\sqrt x}{\sqrt{x}}dx$
     * 解: 
       * $\because (\sqrt x)'=(x^{\frac{1}{2}})'=\frac{1}{2}x^{-\frac{1}{2}}=\frac{1}{2\sqrt x}$
       * $\therefore \int \frac{sin\sqrt x}{\sqrt x}dx=2\int \frac{sinx\sqrt x}{2\sqrt x}dx=2\int sin\sqrt x d(\sqrt x)$
       * $\overset {\sqrt x=t}{=}2\int sintdt = -2cost +c =-2cos\sqrt x + C$

* 公式积累: 
  1. $\int K dx = kx+C; $
  2. $\int x^adx=\begin{cases}\frac{1}{a+1}x^{a+1}+C & ,a\ne-1  \\ ln |x|+C & ,a=-1 \end{cases}$
  3. $\int a^xdx=\begin{cases} \frac{a^x}{ln a}+ C &,a\ne e \\ e^x+C & ,a=e \end{cases}$
  4. .
     1. $\int sinxdx = -cosx+C$
     2. $\int cosxdx = sinx+C$
     3. $\int tanx dx=\int \frac{sinx}{cosx}dx= -\int \frac{1}{cosx}\cdot d(cosx)= -ln |cosx|+C$
     4. $\int cotxdx =\int \frac{cosx}{sinx}dx=\int \frac{1}{sinx}\cdot d(sinx)= ln |sinx|+C$
  5. 插入例题, 引入接下来的公式
     * 例题4 
       * $\int cscx dx$
       * 解: 
         * $\int cscxdx = \int \frac{1}{sinx}dx=\int \frac{1}{2sin\frac{x}{2}cos\frac{x}{2}}dx $
         * $=\int \frac{1}{tan\frac{x}{2}\cdot cos^2\frac{x}{2}}d(\frac{x}{2})=\int \frac{sec^2\frac{x}{2}}{tan\frac{x}{2}}d(\frac{x}{2})\overset{\frac{x}{2}=t}{=}\int \frac{sec^2t}{tant}dt=\int\frac{1}{tant}\cdot d(tant)$
         * $=ln|tant|+C=ln |tan\frac{x}{2}|+C$
         * $\because tan\frac{x}{2}=\frac{sin\frac{x}{2}}{cos\frac{x}{2}}=\frac{2sin^2\frac{x}{2}}{2sin\frac{x}{2}cos\frac{x}{2}}=\frac{1-cosx}{sinx} = cscx -cotx$
         * $so, ⑤ \int cscxdx=ln |tan\frac{x}{2}|+C=ln|cscx-cotx|+C$
     * 例题5
       * $\int secxdx$
       * 解: 
         * $\int secx dx=\int \frac{1}{cosx}dx=\int \frac{1}{sin(x+\frac{\pi}{2})}\cdot d(x+\frac{\pi}{2})=\int csc(x+\frac{\pi}{2})d(x+\frac{\pi}{2})$
         * $=ln|csc(x+\frac{\pi}{2})-cot(x+\frac{\pi}{2})|+C$
         * $=ln|secx+tanx|+C$
  6. $\int secxdx=ln |secx+ tanx|+C$
  7. $\int sec^2xdx=tanx + C$
  8. $\int csc^2xdx=-cotx+C$
  9. $\int secxtanxdx=secx+C$
  10. $\int cscxcotxdxs=-cscx+C$

* 平方和 / 平方差公式
  1. $\int \frac{1}{\sqrt{1-x^2}}dx=\int \frac{1}{\sqrt{1-(\frac{x}{a})^2}}d(\frac{x}{a}) \overset{\frac{x}{a}=t}{=}\int \frac{1}{\sqrt{1-t^2}}dt=arcsint+C=arcsin\frac{x}{a}+C$
  2. $\int \frac{1}{\sqrt {a^2-x^2}}dx=arcsin\frac{x}{a}+C(a>0)$
  3. $\int \frac{1}{1+x^2}dx=arctanx+C$
  4. $\int \frac{1}{a^2+x^2}dx=\frac{1}{a^2}\int\frac{1}{1+(\frac{x}{a})^2}dx=\frac{1}{a}\int \frac{1}{1+(\frac{x}{a})^2}d(\frac{x}{a}) \overset{\frac{x}{a}=t}{=}\frac{1}{a}\int \frac{1}{1+t^2}dt=\frac{1}{a}arctant+C=\frac{1}{a}arctan\frac{x}{a}+C$
  5. $\int \frac{1}{x^2-a^2}dx=\frac{1}{2a}ln |\frac{x-a}{x+a}|+C$
     * $\int \frac{1}{x^2-a^2}=\int \frac{1}{(x-a)(x+a)}dx=\frac{1}{2a}\int (\frac{1}{x-a}-\frac{1}{x+a})dx$
     * $=\frac{1}{2a}\int \frac{1}{x-a}d(x-a)-\frac{1}{2a}\int \frac{1}{x+a}d(x+a)=\frac{1}{2a}ln|x-a|-\frac{1}{2a}ln|x+a|+C$
  6. .
  7. .
  8. . (6/7/8 下一章会讲)

* 例题
  6. $\int (1-\frac{1}{x^2})e^{x+\frac{1}{x}}dx$
     * 解: 
       * $\int(1-\frac{1}{x^2})e^{x+\frac{1}{x}}dx=\int e^{x+\frac{1}{x}}d(x+\frac{1}{x})=e^{x+\frac{1}{x}}+C$
  7. $\int \frac{1}{\sqrt x (4+x)}dx$
     * 解: 
       * $\int \frac{1}{\sqrt (4+x)}dx=2\int\frac{1}{2\sqrt x (4+x)}dx$
       * $=2\int \frac{1}{2^2+(\sqrt x)^2}d(\sqrt x) \overset{\sqrt x}{t} 2\int \frac{1}{2^2+t^2}dt=2\cdot \frac{1}{2}arctan\frac{t}{2}+C$
       * $=arctan\frac{\sqrt x}{2}+C$
  8. .
     1. $\int \frac{1}{xln^2x} dx$
        * 原式= $\int \frac{1}{ln^2x}d(lnx)=-\frac{1}{lnx}+C$
     2. $\int \frac{1}{x(2lnx+1)}dx$
        * 原式$=\frac{1}{2}\int \frac{1}{2lnx+1}d(2lnx+1)$
        * $=\frac{1}{2}ln |2lnx+1|+C$
  9. $\int sin^3xdx$
     * 解:
       * $\int sin^3xdx=-\int sin^2xd(cosx)$
       * $=-\int (1-cos^2x)d(cosx)\overset{ cosx=t}{=}\int {t^2-1}dt$
       * $=\frac{1}{3}t^3-t+C=\frac{1}{3}cos^3x-cosx+C$

### 第二节 积分方法-换元积分法(二) 

* 复习第一类换元积分法
  * $\int f[\phi(x)]\phi'(x)dx=\int f[\phi(x)]d\phi(x)\overset{\phi(x)=t}{=}\int f(t)dt=F(t)+C=F[\phi(x)]+C$
    * 如:
      * $\int sec^4xdx=\int (tan^2x+1)d(tanx)$
      * $=\frac{1}{3}tan^3x+tanx+C$

#### 第二类换元积分法

* Case 1. 无理数
  * 例题
    1. $\int\frac{dx}{\sqrt{x(1-x)}}$
       * 解: 
         * $\int\frac{dx}{\sqrt{x(1-x)}}=2\int\frac{1}{2\sqrt x\cdot\sqrt {1-x} }dx=2\int \frac{1}{\sqrt{1-(\sqrt x)^2}}d(\sqrt x)$
         * $=2arcsin\sqrt x +C$
    2. $\int \frac{x^2}{\sqrt{x^3+1}}dx$
       * 解:
         * $\int\frac{x^2}{\sqrt{x^3+1}}dx=\frac{2}{3}\frac{1}{^2\sqrt{x^3}{+1}d(x^3+1)}=\frac{2}{3}\sqrt{x^3 +1}+C$
    3. $\int x\sqrt{1-x^2}dx$
       * 解: 
         * 原式 = $-\frac{1}{2}\int (1-x^2)\frac{1}{2}d(1-x^2)\overset{1-x^2=t}{=}-\frac{1}{2}\int t^\frac{1}{2}dt$
         * $=-\frac{1}{2}\cdot \frac{2}{3}t^\frac{3}{2}+C=-\frac{1}{3}t^\frac{3}{2}+C=-\frac{1}{3}(1-x^2)^\frac{3}{2}+C$
    4. $\int \frac{1}{1+\sqrt x} dx$
       * 解: 
         * 令 $\sqrt x =t  或 x= t^2$
         * 原式=$2\int\frac{t}{1+t}dt=2\int (1-\frac{1}{1+t})dt=2[t-ln|1+t|]+C$
           * $=2\sqrt x-2 ln (1+\sqrt x)+C$
* 定理 2: 
  * $x=\psi (t) 可导 且 \psi '(t)\ne 0$
    * 

![image-20230513125430394](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125430394.png)

![image-20230513125446704](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125446704.png)

![image-20230513125538892](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125538892.png)

![image-20230513125555221](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125555221.png)

![image-20230513125615113](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125615113.png)

![image-20230513125630933](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125630933.png)

![image-20230513125913912](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125913912.png)

![image-20230513125936013](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125936013.png)

![image-20230513125945704](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125945704.png)

![image-20230513130043252](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130043252.png)

![image-20230513130052688](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130052688.png)

![image-20230513130134444](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130134444.png)

![image-20230513130146310](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130146310.png)

![image-20230513130201286](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130201286.png)

![image-20230513130223114](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130223114.png)

### 第三节 分部积分法

![image-20230513130251946](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130251946.png)

![image-20230513130300712](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130300712.png)

![image-20230513130517528](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130517528.png)

![image-20230513130535698](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130535698.png)

![image-20230513130549531](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130549531.png)

![image-20230513130616588](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130616588.png)

![image-20230513130637702](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130637702.png)

![image-20230513130651785](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130651785.png)

![image-20230513130714515](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130714515.png)

![image-20230513130728818](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130728818.png)

![image-20230513130805486](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130805486.png)

![image-20230513130821794](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513130821794.png)

![image-20230513131332304](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131332304.png)

![image-20230513131344719](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131344719.png)

![image-20230513131726158](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131726158.png)

![image-20230513131738146](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131738146.png)

![image-20230513131752121](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131752121.png)

### 第四节 有理函数不定积分

![image-20230513131846857](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131846857.png)

![image-20230513131942805](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131942805.png)

![image-20230513131956398](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513131956398.png)

![image-20230513132010001](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132010001.png)

![image-20230513132035446](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132035446.png)

![image-20230513132047586](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132047586.png)

![image-20230513132102924](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132102924.png)

![image-20230513132117093](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132117093.png)

![image-20230513132132582](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132132582.png)

![image-20230513132150233](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132150233.png)

![image-20230513132202949](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132202949.png)

![image-20230513132214839](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132214839.png)

![image-20230513132737612](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132737612.png)

![image-20230513132755136](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513132755136.png)

![image-20230515124436708](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124436708.png)

![image-20230515124448308](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124448308.png)



## 第五章 定积分

### 第一节 定积分的概念与性质(一)

![image-20230515124536006](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124536006.png)

![image-20230515124634088](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124634088.png)

![image-20230515124646213](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124646213.png)

![image-20230515124751663](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124751663.png)

![image-20230515124814446](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124814446.png)

![image-20230515124835610](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124835610.png)

![image-20230515124846133](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124846133.png)

![image-20230515124905994](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124905994.png)

![image-20230515124924200](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124924200.png)

![image-20230515124936951](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124936951.png)

![image-20230515124947700](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124947700.png)



### 第一节 定积分的概念与性质(二)

![image-20230515125007065](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125007065.png)

![image-20230515125358152](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125358152.png)

![image-20230515125408331](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125408331.png)

![image-20230515125425929](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125425929.png)

![image-20230515125436317](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125436317.png)

![image-20230515125726736](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125726736.png)

![image-20230515125737745](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125737745.png)

![image-20230515125756832](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125756832.png)

![image-20230515125812865](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125812865.png)

![image-20230515125850238](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515125850238.png)

![image-20230515130002631](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130002631.png)

![image-20230515130015715](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130015715.png)

![image-20230515130026727](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130026727.png)

![image-20230515130059622](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130059622.png)

![image-20230515130108365](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130108365.png)

### 第二节 基本公式

![image-20230515130130839](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130130839.png)

![image-20230515130143293](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130143293.png)

![image-20230515130216736](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130216736.png)

![image-20230515130233732](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130233732.png)

![image-20230515130251992](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130251992.png)

![image-20230515130317161](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130317161.png)

![image-20230515130328898](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130328898.png)

![image-20230515130340229](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130340229.png)

![image-20230515130438685](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130438685.png)

![image-20230515130455468](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130455468.png)

![image-20230515130510168](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130510168.png)

![image-20230515130531744](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130531744.png)

![image-20230515130546089](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130546089.png)

![image-20230515130606349](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130606349.png)

![image-20230515130616284](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130616284.png)

![image-20230515130627284](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130627284.png)

![image-20230515130642412](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130642412.png)

![image-20230515130704170](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130704170.png)

![image-20230515130717868](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130717868.png)

![image-20230515130728318](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130728318.png)

![image-20230515130739130](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130739130.png)

![image-20230515130748417](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130748417.png)

![image-20230515130808293](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130808293.png)

![image-20230515130824821](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130824821.png)

![image-20230515130839614](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130839614.png)

![image-20230515130851595](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130851595.png)

### 第三节 换元积分

![image-20230515130933530](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130933530.png)

![image-20230515130955765](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130955765.png)

![image-20230515131006076](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131006076.png)

![image-20230515131022640](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131022640.png)

![image-20230515131037822](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131037822.png)

![image-20230515131053488](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131053488.png)

![image-20230515131105156](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131105156.png)

![image-20230515131115120](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131115120.png)

![image-20230515131127716](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131127716.png)

![image-20230515131140809](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131140809.png)

![image-20230515131202376](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131202376.png)

![image-20230515131247141](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131247141.png)

![image-20230515131302986](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131302986.png)

![image-20230515131318710](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131318710.png)

![image-20230515131329653](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131329653.png)

![image-20230515131338852](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131338852.png)

![image-20230515131435699](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131435699.png)

![image-20230515131450319](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131450319.png)

![image-20230515131349820](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131349820.png)

![image-20230515131507333](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131507333.png)

![image-20230515131516110](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131516110.png)

![image-20230515131527108](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131527108.png)

![image-20230515131539906](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131539906.png)

![image-20230515131550791](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131550791.png)

### 第四节 分部积分

![image-20230515131611367](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131611367.png)

![image-20230515131622968](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131622968.png)

![image-20230515131634267](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131634267.png)

![image-20230515131647183](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131647183.png)

![image-20230515131656904](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131656904.png)

![image-20230515131724081](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131724081.png)

![image-20230515131736271](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131736271.png)

![image-20230515131749161](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131749161.png)

![image-20230515131805027](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515131805027.png)

![image-20230515132004843](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132004843.png)

### 第五节 反常积分

![image-20230515132023566](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132023566.png)

![image-20230515132034263](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132034263.png)

![image-20230515132050114](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132050114.png)

![image-20230515132103542](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132103542.png)

![image-20230515132116068](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132116068.png)

![image-20230515132142748](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132142748.png)

![image-20230515132201200](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132201200.png)

![image-20230515132215553](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132215553.png)

![image-20230515132251355](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132251355.png)

![image-20230515132307343](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132307343.png)

![image-20230515132325046](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132325046.png)

![image-20230515132339587](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132339587.png)

![image-20230515132355476](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132355476.png)

![image-20230515132411110](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132411110.png)

![image-20230515132429736](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132429736.png)

![image-20230515132524600](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132524600.png)

![image-20230515132643444](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132643444.png)

![image-20230515132707504](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132707504.png)

![image-20230515132720719](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132720719.png)

![image-20230515132735175](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132735175.png)

![image-20230515132812081](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132812081.png)

![image-20230515132821941](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132821941.png)

![image-20230515132836569](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132836569.png)

![image-20230515132853773](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132853773.png)

![image-20230515132920487](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132920487.png)

![image-20230515132933242](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132933242.png)

![image-20230515132945126](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132945126.png)

![image-20230515132954164](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515132954164.png)

![image-20230515133206334](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515133206334.png)

