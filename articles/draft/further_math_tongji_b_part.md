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
          * // TODO



![image-20230427182648943](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182648943.png)

![image-20230427182719033](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182719033.png)

![image-20230427182738415](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182738415.png)

![image-20230427182752816](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182752816.png)

![image-20230427182816520](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182816520.png)

![image-20230427182827564](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182827564.png)

![image-20230427182850768](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182850768.png)

![image-20230427182917467](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182917467.png)

![image-20230427182933003](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182933003.png)

![image-20230427182956870](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182956870.png)

![image-20230427183014562](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183014562.png)

![image-20230427183030627](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183030627.png)

![image-20230427183057030](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183057030.png)



### 第六节 函数图像描绘

![image-20230427183124604](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183124604.png)

![image-20230427183134729](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183134729.png)

![image-20230427183357272](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183357272.png)

![image-20230427183411628](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183411628.png)

![image-20230427183427850](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183427850.png)

![image-20230427183443462](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183443462.png)

![image-20230427183459502](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183459502.png)

![image-20230427183515972](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183515972.png)

![image-20230427183533394](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183533394.png)

![image-20230427183548174](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183548174.png)

![image-20230427183603236](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183603236.png)

![image-20230427183618540](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183618540.png)

![image-20230427183630182](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183630182.png)

![image-20230427183642316](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183642316.png)

![image-20230427183656179](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183656179.png)

![image-20230427183717949](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427183717949.png)

### 第七节 弧微分 与 曲率

![image-20230512162623159](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162623159.png)

![image-20230512162642021](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162642021.png)

![image-20230512162658655](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162658655.png)

![image-20230512162715323](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162715323.png)

![image-20230512162731102](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162731102.png)

![image-20230512162750866](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162750866.png)

![image-20230512162808947](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162808947.png)

![image-20230512162825328](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162825328.png)

![image-20230512162839182](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162839182.png)

![image-20230512162857593](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162857593.png)

![image-20230512162909719](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162909719.png)

![image-20230512162923917](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512162923917.png)

## 第四章 不定积分

### 第一节 不定积分的概念与性质

![image-20230512163019628](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163019628.png)

![image-20230512163033946](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163033946.png)

![image-20230512163048821](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163048821.png)

![image-20230512163112210](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163112210.png)

![image-20230512163131625](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163131625.png)

![image-20230512163148315](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163148315.png)

![image-20230512163206227](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163206227.png)

![image-20230512163222702](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163222702.png)

![image-20230512163236893](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163236893.png)

![image-20230512163254358](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163254358.png)

![image-20230512163307940](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163307940.png)

![image-20230512163323609](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163323609.png)

![image-20230512163338779](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163338779.png)

![image-20230512163348896](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163348896.png)

![image-20230512163400482](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163400482.png)

![image-20230512163411758](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163411758.png)

![image-20230512163534670](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512163534670.png)

![image-20230512163947344](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512164008051.png)

![image-20230512164024580](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512164024580.png)

![image-20230512164238741](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512164238741.png)

![image-20230512164252159](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512164252159.png)

### 第二节 积分方法-换元积分法(一) 

![image-20230512164343327](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230512164343327.png)

![image-20230513122837965](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513122837965.png)

![image-20230513122856272](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513122856272.png)

![image-20230513123129200](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513123129200.png)

![image-20230513123149004](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513123149004.png)

![image-20230513123204874](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513123204874.png)

![image-20230513124129614](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124129614.png)

![image-20230513124147628](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124147628.png)

![image-20230513124209234](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124209234.png)

![image-20230513124227079](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124227079.png)

![image-20230513124239875](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124239875.png)

![image-20230513124250256](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124250256.png)

![image-20230513124311009](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124311009.png)

![image-20230513124332402](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124332402.png)

![image-20230513124818495](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124818495.png)

![image-20230513124834304](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124834304.png)

![image-20230513124845120](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124845120.png)

![image-20230513124856675](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124856675.png)

![image-20230513124942590](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513124942590.png)

![image-20230513125001864](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125001864.png)

![image-20230513125052916](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125052916.png)

![image-20230513125107879](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125107879.png)

![image-20230513125120829](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125120829.png)

![image-20230513125222139](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125222139.png)

![image-20230513125234656](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125234656.png)

![image-20230513125247295](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125247295.png)



### 第二节 积分方法-换元积分法(二) 

![image-20230513125310191](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125310191.png)

![image-20230513125323197](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125323197.png)

![image-20230513125337033](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125337033.png)

![image-20230513125408576](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230513125408576.png)

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

