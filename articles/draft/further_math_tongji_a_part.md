# Further Mathematic lecture (tongji) full notes (A part) cross Jiafeng Tang

A part 主要是关于 导数 和部分 微分, 



看起来上册的 七章, 基本是 把 高中的 数学从根上重新定义了一次

第一章 , 重新定义 什么时函数, 并 加入极限的概念

第二章, 使用极限来定义导数, 并使用 微分

第三章, 更加详细的介绍微分的定理, 以及各种应用

第四章, 不定积分 , 也就是 原函数, 

第五章, 定积分, 曲线和 x 轴围成的 曲面梯形的面积

第六章, 定积分的应用

第七章, 微分方程

[TOC]

## 第一章 函数与极限

### 第一节 映射 和 函数

* 映射
  * 略, 

1. 定义 (defs)

   * 函数

     * x,y 为两个变量 ($x\in D$), 对 任意的 $x \in D$, 有 **唯一** <u>确定</u> 的 y 与 x 对应, 称 y 为 x 的函数, 记 $y=f(x)$

     * Note: 

       1. 符号

          1. $\forall$ (\forall 倒写的 A): 表示任意的, 所有的
          2. $\exists$ (\exists 反写的 E) : 表示存在
          3. $\exists !$ (\exists !): 存在唯一

       2. 

          * D : 表示定义域,  x 的取值范围

          * R: 表示值域, $R=\{y|y=f(x), x\in D\}$ , 所有的函数值构成的集合, 叫做 值域, 记作 $R_f$, 或者 $f(D)$ ,
          * f - function

     * 例子

       1. Sgn 函数, 符号函数 $y = sgn x =\begin{cases} -1, &  x < 0, \\ 0, &  x = 0, \\ 1, & x > 0. \end{cases}$

       
       
       2.  狄利克雷 (Dirichlet) 函数 $f(x) = \begin{cases} 1, & \text{如果 }  x \in \mathbb{Q} \\ 0, & \text{如果 } x \notin \mathbb{Q} \end{cases}$ 
       3.  取整函数(左取整函数)$y= [x] \\ e.g. [\surd{2}]=1 , [-0.3]=-1, [3]=3$
          * Note: 
            1.  
               1. $[x] \le x$
               2. $[x+y]  \neq [x] + [y]  \text(通常)$
               3. 若 $k \in \mathbb{Z}$ , $[x+k] = [x]+k$ 
       
     * 函数的奇偶性
     
       * $f(-x)=f(x)$, 偶函数, 图像关于 y 轴对称
       * $f(-x)=-f(x)$, 奇函数, 图像关于 原点对称
     
     * 反函数
       * $y=f(x)(x\in D)$, 严格单调
         * 在这个条件下, 每一个 y 也都只有唯一的一个对应的 x, 这也称为单射, 所以可以得到结论
           * $y=f(x) \Rightarrow  x= g(y) $ , 这里的 g 就是 f 的反函数, 也就是 $g = f^{-1}$
       * 例子: 
         1. 求 $y= \ln(x+ \sqrt{x^2+1}) $ 的反函数
            * 解:  由 $y= \ln(x+ \sqrt{x^2+1}) $ 得
              * $x + \sqrt{x^2+1} = e^y  $
              * 由于 $(x+\sqrt{x^2+1})*(-x+\sqrt{x^2+1})=1$ (倒数关系), 所以这里可以构造出另一条式子
                * $-x+\sqrt{x^2+1}=\frac{1}{e^y}$
                * $-x+\sqrt{x^2+1}=e^{-y}$
              * 接着将两个式子相减, 得到 $2x=e^y-e^{-y}$
              * $x=\frac{e^y-e^{-y}}{2}$
       * 特性 
         1. $f(x) * f^{-1}(x) = x$
            * 推导: 
              * 因为有 $f^{-1}(f(x)) = x 和 f(f^{-1}(x))=x$
              * 所以 $f(x)*f^{-1}(x)=f(x)*\frac{x}{fx}=x$
              * 所以得到结论
     
   * 基本初等函数, 只有五种
     1. 幂函数 $y=x^\mu (\mu\in \mathbb{R})$
     2. 指数函数 $y=a^x (a>0 \text且 a\neq 1)$
     3. 对数函数 $y=log_ax, (a > 0 \text且 \ a \neq 1, 当 a=e 时, 记为 y= lnx ) $
     4. 三角函数 $y=sin x, y=cosx,y=tanx, y=cotx,y=secx,y=cscx $
        * $y=sinx$ 正弦, $y=cscx$ 余割, $sinx * cscx = 1$
        * $y=cosx$ 余弦. $y=secx$ 正割, $cosx * secx = 1$
        * $y = tanx$ 正切, $y=cotx$ 余切, $tanx * cotx = 1$
     5. 反三角函数 上面六个 三角函数的反函数
     
   * 初等函数
     * 由 **常数** 和 **基本初等函数** 经过 **四则运算** 和 **复合运算**  而成的式子. (课本上的定义: 由常数和基本初等函数经过 有限次的四则运算 和 有限次的函数复合步骤 所构成并可用一个式子表示的函数, 称为 **初等函数**) 
       * BTW 双曲函数 // TODO
     * 例子: 
       * $y=3e^{x^2} => e^u,u=x^2$
   
   2. 初等性质
      1. 奇偶性
         * $y=f(x)(x\in D)$, D关于 原点 对称
           * 例如 $y=x^2, x\in (-1,1]$ 这种函数, 不需要考虑奇偶性
         * If $\forall x \in D$, 有 $f(-x)=f(x)$, f(x) 为偶函数
         * If $\forall x \in D$, 有 $f(-x)=-f(x)$, f(x) 为奇函数
      2. 单调性
         * $y=f(x) (x\in D)$
           1. If $\forall x_1,x_2\in D 且 x1<x2, 有 f(x_1)< f(x_2)$, 称 $f(x) 在 D 上 严格单调递增$;
           2. If $\forall x_1,x_2\in D 且 x1<x2, 有 f(x_1)> f(x_2)$, 称 $f(x) 在 D 上 严格单调递减$;
      3. 有界性
         * $y = f(x) (x\in D)$
         * $if \ \exists M > 0 , 对 \forall x \in D, 有 |f(x)| \le M , 则 f(x) 在 D 上有界$
           * Note: 
             * 有界的 $\Leftrightarrow$ 有上下界
      4. 周期性
         * $y=f(x) (x\in D)$, If $\exists T > 0 $
         * 使 $\forall x \in D (x+T \in D)$, 有 $f(x+T)=f(x)$

### 第二节 数列极限

1. 定义
   1. 设 $\{x_n\}$ 为一数列, 如果存在常数 $a$, 对于任意给定的正数 $\epsilon$ (不论它多么小), 总存在 正整数 $N$, 使得当 $n > N$ 时, 不等式 $|x_n -a| <\epsilon$都成立, 那么就称 常数 $a$  是数列 $\{x_n\}$ 的 极限, 或者称 数列 $\{x_n\}$ 收敛与 $a$, 记作 $\lim_{n\to \infty}x_n=a$  或 $x_n \to a (n \to \infty)$ , ($\epsilon 是误差值, N是数列中为界的那个数的序号, a 是数列 \{x_n\} 极限值$)
      * 例子1
        * 证明 $lim_{n\to\infty} \frac{n-1}{n+1} =1$
          * 证: $|\frac{n-1}{n+1}-1|=\frac {2}{m+1}$
          * $\forall \epsilon > 0, \frac{2}{n+1} < \epsilon \Leftrightarrow n > \frac {2}{\epsilon} -1$
          * 取 $N=[\frac{2}{\epsilon}-1], 当 n> N 时, \frac{2}{n+1} < \epsilon $
          * 所以, $lim_{m\to\infty} \frac{n-1}{n+1} =1$
          * Q.E.D.
      * 例子2
        * 证明 $lim_{n\to\infty} \frac{n-1}{2n} =\frac{1}{2}$
          * 证: $|\frac{n-1}{2n}-\frac{1}{2}|=\frac{1}{2n}$  (首先拿到期望值 和 式子之间的差)
          * $\forall \epsilon > 0, 令 \frac{1}{2n} < \epsilon \Leftrightarrow n > \frac {1}{2\epsilon} $  (然后让差值小于任意给定的正数, 同时推导出 当 n 为何值时, 会误差会大于期望)
          * 取 $N=[\frac{1}{2\epsilon}], $ (说明界的位置, 这个界在误差的位置)
          * 对 $\forall \epsilon > 0, \exists N = [\frac{1}{2\epsilon}], 当 n> N 时, |\frac{n-1}{2n} - \frac{1}{2}| < \epsilon $  (接着 对于任意取的 $\epsilon$, 都有一个受  $\epsilon$ 控制的 N, 当 n = N 时, 上述式子相等, 当 n> N 时, 上述式子的 左边会小于右边, 也就满足要求 , 所以随着 n 的增大, 上述式子是满足的)
          * 所以, $lim_{m\to\infty} \frac{n-1}{2n} =\frac{1}{2}$
          * Q.E.D.
   2. 性质
      1. (唯一性) 数列有界限必唯一, 
         * 证: (反) 设 $lim_{n\to\infty}a_n=A$, $lim_{n\to\infty}a_n=B$ , 且 $A\ne B$ , (翻译一下就是 说一个数列有两个界限)
           * 设 A > B
           * 取 $\epsilon=\frac{A-B}{2}$ > 0,  
           * 因为 $lim_{n\to\infty}a_n=A$, 
             * 所以 $\exists N_1>0, 当 n>N_1 时$,
             *  $|a_n-A|<\frac{A-B}{2}  \Leftrightarrow \frac{A+B}{2} < a_n < \frac{3A-B}{2}  $  $(*)$
           * 又因为 $lim_{n\to\infty}a_n=B$, 
             * 所以 $\exists N_2 > 0 $, 当 $n>N_2时$,
             * $|a_n-B| < \frac{A-B}{2} \Leftrightarrow \frac{3B-A}{2} < a_n < \frac{A+B}{2}$  $(**)$
           * 取 $N=max{N1,N2}, $ 当 $n>N 时$, $(*)(**)$ 成立
           * 然而上述矛盾, $a_n$ 是不可能在 (*) 中 既大于 $\frac{A+B}{2}$ 又在 (**) 中小于 $\frac{A+B}{2}$ 的
           * 所以 假设 $A>B$ 不成立, 同理 A<B 也不成立, 
           * 所以 A=B
      2. (有界性) if $lim_{n\to\infty}a_n=A$, 则 $\exists M>0$, 使 $|a_n|\le M$ , 反之则不成立
         * 证: 
           * "$\Rightarrow$" 正向
             *  取 $\epsilon = 1 >0$
               * 因为 $lim_{m\to\infty}a_n=A$
               * 所以 $\exists N > 0$, 当 $n>N$ 时, $|a_n-A|<1$
               * $||a_n|-|A||\le|a_n-A|$
               * 所以 当 n>N 时, $||a_n|-|A||<1 \Rightarrow |a_n| < 1+|A|$  $(*)$
               * 取 M=max{$|a_1|,|a_2|, ... ,|a_N|,1+|A|$} $(**)$
               * 所以 根据上面两条结论 (*) 和 (**), 
               * $\forall n$, 有 $|a_n|\le M$
           * "$\nLeftarrow$" 反向
             * 反例1: $a_n=1+(-1)^n$  ={0,2,0,2,0,2,....)
             * 反例2: 二次函数, 有界, 但不存在极限
             * 所以 $lim_{n\to\infty}a_n$ 不存在, 但 $|a_n|\le2$
         * 既 如果存在极限, 那么函数必定有界, 但反之则不成立, 函数有界, 但不一定存在极限
      3. (保号性)  if $\lim_{n\to\infty}a_n=A \begin{cases} >0 \\ <0 \end{cases} $   , 则 $\exists N>0, 当 n>N时$, $a_n\begin{cases} >0\\<0 \end{cases}$
         * 证: 设 A>0
           * 取 $\epsilon = \frac{A}{2} >0$
           * 因为 $lim_{n\to\epsilon}a_n=A$, 所以 $\exists N>0, 当 n> N 时$
             * $|a_n-A|<\frac{A}{2} \ \ \Rightarrow \ \ a_n>\frac{A}{2} > 0$ 
             * Q.E.D.
         * 设 A < 0
           * 取 $\epsilon = - \frac{A}{2} >0$
           * 因为 $lim_{n\to\epsilon}=A$, 所以 $\exists N > 0 , 当 n> N 时$
             * $|a_n-A|<-\frac{A}{2} \Rightarrow a_n < \frac{3A}{2} < 0 $
             * Q.E.D.

### 第三节 函数极限

1. 定义$(\epsilon-\delta)$
   * $(\epsilon-\delta) $若 $\forall \epsilon > 0 , 当 0 < |x-a| < \delta 时, $($0<|x-a|$)( 意味着 不取 a 这个点)
     * $|f(x)-A|<\epsilon$
     * 称 $f(x)当 x\to a 时, A 为极限$
     * 记 $lim_{x\to a}f(x)=A$, 或 $f(x)\to A(x\to a)$
   * Notes: 
     1. $x\to a 时, x\ne a;$
     2. $x\to a, 含 \begin{cases} x\to a^- \\ x\to a^+ \end{cases} \ ;$  
     3. $\{x| 0< |x-a|< \delta  \}\triangleq \mathring{U}(a,\delta) $ , a 的 去心 $\delta$ 领域
        * $\triangleq$ 是定义为的意思
        * ![image-20230225173355165](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230225173355165.png)
     4. $lim_{x\to a }f(x) 与 f(a) 无关$
     5. $若\forall \epsilon > 0 , \exists \delta >0,$
        1. $ 当 x \in (a-\delta,a) 时, $ (左侧)
           1.  $|f(x)-A|<\epsilon $ , 
           2. A 称为 $f(x) 在 x=a 处的左极限$
           3. 记 $lim_{x\to a^-}f(x)=A, 或 f(a-0)=A$
        2. $ 当 x \in (a,a+\delta) 时, $ (右侧)
           1. $|f(x)-B|<\epsilon$
           2. B 称为 f(x) 在 x=a 处的 右极限
           3. 记 $lim_{x\to a^+}f(x)=B, 或 f(a+0)=B$
        3. ⭐️ $lim_{x\to a}f(x)\exists \Leftrightarrow f(a-0),f(a+0)\exists 且相等$
           1. 例子: 已知 $ f(x)=\begin{cases} 2x-1 & x<1 \\ 3x & x>1 \end{cases} , 求\ lim_{x\to 1} f(x)$
              * 解: 
                * $f(1-0)=lim_{x\to1^-}f(x)=lim_{x\to 1^-}2x-1=1;$
                * $f(1+0)=lim_{x\to 1^+}f(x)=lim_{x\to1^+}3x=3;$
                * 由于 $f(1-0) \ne f(1+0)$
                * 所以 $lim_{x\to1} 不存在$
           2. 例子: 证 $lim_{x\to 2}(3x+1)=7$
              * 证: 
                * $\forall \epsilon > 0$, $|(3x+1)-7|=3|x-2|<\epsilon \Leftrightarrow |x-2|<\frac{\epsilon}{3} $
                * 取 $\delta = \frac{\epsilon}{3} > 0$, 当 $0<|x-2|<\delta$ 时, 
                * $|(3x+1)-7|<\epsilon$
                * 所以 $lim_{x\to2}(3x+1)=7$ 成立
           3. 例子: 证 $lim_{x\to1}\frac{2x^2-x-1}{x-1}=3$
              * 证: 
                * $\forall \epsilon >0, |\frac{2x^2-x-1}{x-1}-3|= |(2x+1)-3|=2|x-1|<\epsilon\Leftrightarrow |x-1|<\frac{\epsilon}{2}$
                * 取 $\delta = \frac{\epsilon}{2}>0, 当 0<|x-1|<\delta$ 时, 
                * $|\frac{2x^2-x-1}{x-1} -3|<\epsilon$
                * 所以 $lim_{x\to 1}\frac{2x^2-x-1}{x-1}=3$
2. 定义 $(\epsilon-x)$ , 当 x 趋近于 $\infty$ 的情况
   * 例子: 
     * y=arctan$x$ 
       * $arctanx \to -\frac{\pi}{2} (x\to -\infty)$
       * $arctanx\to\frac{\pi}{2}(x\to+\infty)$
     *  $y=e^{-x^2}+1$
       * $e^{-x^2}+1\to 1 \  (x\to\infty)$
   * 定义
     * Case1: If $\forall\epsilon>0, \exists X>0, 当 x> X 时$,
       * $|f(x)-A|< \epsilon $
       * 记 $lim_{x\to+\infty}=A$
     * Case2: If $\forall \epsilon > 0, \exists X>0, 当 x<-X 的时候, $
       * $|f(x)-A|<\epsilon $
       * 记 $lim_{x\to-\epsilon}f(x)=A$
     * Case3: If $\forall\epsilon>0,\exists X>0,当 |x|>X 时$
       * $|f(x)-A|<\epsilon$
       * 记 $lim_{x\to\infty}f(x)=A$
   * 例题: 证明 $lim_{x\to\infty}\frac{2x^2+1}{x^2}=2$
     * 证: $\forall\epsilon>0, |\frac{2x^2+1}{x^2}-2|=\frac{1}{x^2}<\epsilon \Leftrightarrow |x|>\frac{1}{\surd{\epsilon}}$
       * 取 $x=\frac{1}{\surd{\epsilon}}>0$
       * 当 $|x|>X 时$,
       * $|\frac{2x^2+1}{x^2}-1|<\epsilon$
       * 所以 $lim_{x\to\infty}\frac{2x^2+1}{x^2}=2$
3. 性质
   1. (唯一性) 函数有极限必唯一
      * 证: 仅证 $x\to a$的情形
        * 设 $\lim_{x\to a} f(x)=A , lim_{x\to a}f(x)=B$
        * (反证) 设 A>B
          * 取 $\epsilon = \frac{A-B}{2}>0$
          * 因为 $lim_{x\to a}f(x)=A, 所以 \exists\delta_1>0 , 当 0<|x-a|<\delta_1 时$
            * $|f(x)-A|<\frac{A-B}{2} \Leftrightarrow \frac{A+B}{2}<f(x)<\frac{3A-B}{2} \ \ (*)$
          * 又因为 $lim_{x\to a}f(x)=B$ $ 所以 \exists\delta_2>0 , 当 0<|x-a|<\delta_2 时$
            * $|f(x)-B|<\frac{A-B}{2} \Leftrightarrow \frac{3B-A}{2}<f(x)<\frac{A+B}{2} \ \ (**)$
          * 取 $\delta=mix\{\delta_1,\delta_2\}$ , 当 $0<|x-a|<\delta$ 时, (*),(**) 成立, 矛盾
          * 所以 A>B 不成立, 同理 A<B 也不成立, 所以 A=B
      * 证: 证明 $x\to \infty$ 的情况
        * // TODO
   2. (<u>局部</u>有界)  设 $lim_{x\to a}f(x)=A$ , 则 $\exists \delta > 0, M>0, 当 0<|x-a|<\delta 时$, 
      * $|f(x)|\le M$
      * 证: 取 $\epsilon =1 >0$
        * 因为 $lim_{x\to a}f(x)=A, 所以 \exists \delta >0, 当 0<|x-a|<\delta 时,$
        * $|f(x)-A|<1$
        * 又因为 $||f(x)|-|A||\le |f(x)-A|$
        * 所以当 $0<|x-a|<\delta 时$
        * $||f(x)|-|A||<1 \Rightarrow |f(x) < 1+|A| \triangleq M|$
        * 即当 $0<|x-a|<\delta$ 时, $|f(x)\le M|$
   3. (保号性) $设 lim_{x\to a }f(x)=A \begin{cases}>0\\<0\end{cases}, 则 \exists \delta >0, 当0<|x-a|<\delta 时,  f(x)\begin{cases}>0\\<0\end{cases} $
      * 证: 设 A>0
        * 取 $\epsilon = \frac{A}{2}>0$
        * 因为 $lim_{x\to a }f(x)=A$
        * 所以 $\delta >0, 当 0<|x-a|<\delta时$
        * $|f(x)-A|<\frac{A}{2} \Rightarrow f(x)<\frac{A}{2}>0$
        * $(A<0, 取 \epsilon = -\frac{A}{2} >0)$ 

### 第四节 无穷小 和 无穷大

1. 无穷小
   1. 定义: $\alpha(x)为 x 的函数, 如果 lim_{x\to x_0}\alpha(x)=0, 称 \alpha(x) 当 x\to x_0时为无穷小$
      * Notes;
        1. 0 是无穷小, 但 无穷小不一定是0
        2.  $设 \alpha (x) \ne 0 , \alpha(x)是否为无穷小 与自变量的趋向有关$
           * 例子: $\alpha(x)=3(x-1)^2$
             * 因为 $lim_{x\to1}\alpha(x)=0$
               * 所以 $\alpha(x)=3(x=1)^2 , 当x\to1时为无穷小$
             * 因为 $lim_{x\to2}\alpha(x)=3 $
               * 所以 $\alpha(x)=3(x=1)^2 , 当x\to2时不为无穷小$
        3. 等价定义: If $\forall\epsilon >0,\exists\delta>0, 当 0<|x-x_0|<\delta 时$,
           * $|\alpha(x)-0|<\epsilon$
           * 即 $lim_{x\to x_0}\alpha(x)=0$
   2. 常规性质: ⭐️
      1. $\alpha \to 0, \beta\to0(x\to x_0), 则 \alpha\pm\beta\to0(x\to x_0)$
         * 证: $\forall\epsilon>0$
           * 因为 $lim_{x\to x_0}\alpha=0, 所以 \exists \delta_1>0 ,当 0<|x-x_0|<\delta_1 时$
             * $|\alpha|<\epsilon $ (*)
           * 又因为 $\lim_{x\to x_0}\beta=0 所以\exists \delta_2>0, 当 0<|x-x_0|<\delta_2 时$,
             * $|\beta|<\epsilon$ (**)
           * 取 $\delta = min \{\delta_1,\delta_2\},  当 0<|x-x_0|<\delta 时$, (*)(**) 成立
           * 所以 , $当 0<|x-x_0|<\delta 时$ , $|\alpha\pm\beta|\le|\alpha|+|\beta|<2\epsilon$
           * 所以, $lim_{x\to x_0}(\alpha\pm\beta)=0$
      2. $\alpha\to0 (x\to x_0), 则 k\alpha\to0 (x\to x_0) (k 是常数)$
         * 证: $\forall\epsilon>0$
           * 因为 $lim_{x\to x_0}\alpha=0$ , 所以 $\exists \delta >0, 当 0<|x-x_0|<\delta 时$
             * $|\alpha|<\delta$
           * 当 $0<|x-x_0|<\delta$ 时
             * $|k\alpha-0|=|k\alpha|<|k|*\epsilon$
           * 所以 $lim_{x\to x_0}k\alpha=0$
      3. $lim_{x\to x_0}f(x)=A \Leftrightarrow f(x)=A+\alpha, \alpha\to0(x\to x_0)$
         * 证: "$\Rightarrow$" $f(x)=A+[f(x)-A]=A+\alpha, \alpha=f(x)-A$
           * $\forall\epsilon>0, lim_{x\to x_0}f(x)=A$ , 所以 $\exists \delta >0, 当 0<|x-x_0|<\delta 时$
             * $|f(x)-A|<\epsilon$
             * 即 $|\alpha|<\epsilon$
           * 所以 $lim_{x\to x_0}\alpha=0$
           * "$\Leftarrow$" 设 $f(x)=A+\alpha, \alpha\to0 (x\to x_0)$
             * $\forall\epsilon>0, 因为 lim_{x\to x_0}\alpha=0 , 所以 \exists\delta >0, 当 0<|x-x_0|<\delta 时$
               * $|\alpha|<\epsilon$
               * 即 $|f(x)-A|<\epsilon$
             * 所以 $lim_{x\to x_0}f(x)=A$
2. 无穷大
   1. 定义: $若 \forall M>0, \exists \delta >0, 当 0<|x-x_0|<\delta 时 , |f(x)|\ge M$, 称 $f(x) 当 x\to x_0 时为无穷大$
      * 记 $\lim_{x\to x_0}f(x)=\infty$
        * 另一种情况: $当 \forall M >0, \exists X>0 , 当 x> X 时, |f(x)|\ge M, 称 f(x) 当 x\to\infty 为无穷大, 记 lim_{x\to\infty}f(x)=\infty$
      * 例子1: 证明 $\lim_{x\to1}\frac{2}{(x-1)^2}=\infty$
        * 证: $\forall M>0, |\frac{2}{(x-1)^2}|>M \Leftrightarrow |x-1|<\sqrt{\frac{2}{M}}$
          * 取 $\delta=\sqrt{\frac{2}{M}}>0, 当 0< |x-1|<\delta 时, 有 |\frac{2}{(x-1)^2}|>M  $
          * 所以 $lim_{x\to1}\frac{2}{(x-1)^2}=\infty$
      * 例子2: 证 $lim_{x\to\infty}(2x^2+1)=\infty$
        * 证: $\forall M>0, |2x^2+1|>M \Leftrightarrow |x|>\sqrt{\frac{M-1}{2}}$
          * 取 $X=\sqrt{\frac{M-1}{2}}>0, 当 |x|>X 时, |2x^2+1|>M$
          * 所以 $lim_{x\to\infty}(2x^2+1)=\infty$
3. 无穷小和无穷大的关系
   1.  性质: $lim_{x\to x_0}f(x)=0 \Leftrightarrow lim_{x\to x_0}\frac{1}{f(x)}=\infty$
      * 证: $\forall M>0$
        * "$\Rightarrow$"
          * 取 $\epsilon=\frac{1}{M}>0$, 因为 $lim_{x\to x_0}f(x)=0, 所以 \exists \delta >0, 当 0 <|x-x_0|<\delta 时$
          * $|f(x)-0|<\epsilon \Leftrightarrow |\frac{1}{f(x)}|>M$
          * $lim_{x\to x_0}\frac{1}{f(x)}=\infty$
        * "$\Leftarrow$"
          * $\forall\epsilon>0, 取 M=\frac{1}{\epsilon}>0$
          * 因为 $lim_{x\to x_0}\frac{1}{f(x)}=\infty$
          * 所以 $\exists\delta>0, 当 0<|x-x_0|<\delta 时$
          * $|\frac{1}{f(x)}|>M \Leftrightarrow |f(x)|<\epsilon$
          * 所以 $lim_{x\to x_0}f(x)=0$

### 第五节 极限的运算法则

1. 预备知识: 
   1. 初等函数, 由 `常数` 和 `基本初等函数` , 由 `四则` 和 `复合` 而成的式子, 叫做初等函数.
   2. 无穷小
      1. $\alpha\to0,\beta\to0 \Rightarrow \alpha\pm\beta\to0$
         1. $\alpha\to0,\beta\to0,\gamma\to0 \Rightarrow \alpha\pm\beta\pm\gamma\to0$
      2. $\alpha\to0 \Rightarrow k\alpha\to0$
      3.  $f(x)\to A \Leftrightarrow f(x)=A+\alpha, \alpha\to0$
      4. $\alpha\to0,\beta\to0 \Leftrightarrow \alpha\beta\to0$
         1. 证: 设 $lim_{x\to x_0}\alpha(x)=0$
            1. 取 $\epsilon_0=1>0$
            2. $lim_{x\to x_0}\alpha=0, \therefore \exists \delta_1>0, when 0<|x-x_0|<\delta_1 $
               1. $|\alpha-0|<1, i.e. |\alpha|<1 $
            3. $\forall\epsilon>0,\because lim_{x\to x_0}\beta=0,\therefore \exists\delta_2>0. when\  0<|x-x_0|<\delta_2$
               1. $|\beta-0|<\epsilon$ 
            4. 取 $\delta=min\{\delta_1,\delta_2\}$, when $0<|x-x_0|<\delta $, 上述二式成立
            5. $i.e.\ |\alpha\beta-0|=|\alpha\beta|=|\alpha|\cdot|\beta|<\epsilon$
            6. $\therefore lim_{x\to x_0}\alpha\beta=0$
2. 四则求导法则
   1. suppose/assume $lim_{x\to x_0}f(x)=A, lim_{x\to x_0}g(x)=B$, (极限趋向 只有 趋向于 某个点 或者 趋近于无穷 两种情况 )
   2. (加法) $\lim_{x\to x_0}[f(x)\pm g(x)]=\lim_{x\to x_0}f(x)\pm lim_{x\to x_0}g(x)=A\pm B$
      * 证明: 
        * $lim_{x\to x_0}f(x)=A \Leftrightarrow f(x)=A+\alpha, \alpha \to 0 (x\to x_0)$
        * $lim_{x\to x_0}g(x)=B \Leftrightarrow g(x)=B+\beta, \beta\to0(x\to x_0)$
        * $f(x)+g(x)=(A\pm B)+(\alpha\pm\beta)$
        * $\therefore lim_{x\to x_0}[f(x)\pm g(x)]=A\pm B$
   3. 乘法
      1. k 为常数, $lim_{x\to x_0}k\cdot f(x) = k\cdot lim_{x\to x_0}f(x)=k\cdot A$
         * 证: 
           * $lim_{x\to x_0}f(x)=A \Leftrightarrow f(x)=A+\alpha,\alpha\to0(x\to x_0)$
           * $k\cdot f(x)=kA+k\alpha$
           * $\therefore lim_{x\to x_0}kf(x)=k\cdot A$
      2. $lim_{x\to x_0}f(x)\cdot g(x)=lim_{x\to x_0}\cdot lim_{x\to x_0}g(x)=A\cdot B$
         * 证: 
           * $lim_{x\to x_0}f(x)=A \Leftrightarrow  f(x)=A+\alpha, \alpha\to0$
           * $lim_{x\to x_0}g(x)=A \Leftrightarrow  g(x)=B+\beta, \beta\to0$
           * $f(x)\cdot g(x)=AB+(A\beta+B\alpha+\alpha\beta)$
           * $\therefore lim_{x\to x_0}f(x)\cdot g(x)=AB$
   4. (除法)⭐️ 若 $lim_{x\to x_0}g(x)=B\ne0$, 则 $lim_{x\to x_0}\frac{f(x)}{g(x)}=\frac{lim_{x\to x_0}f(x)}{lim_{x\to x_0}g(x)}=\frac{A}{B}$
      * 证: 
        * $lim_{x\to x_0}f(x)=A \Leftrightarrow f(x)=A+\alpha, \alpha\to0 (x\to x_0)$
        * $lim_{x\to x_0}g(x)=A \Leftrightarrow g(x)=B+\beta, \beta\to0 (x\to x_0)$
        * $|\frac{f(x)}{g(x)}-\frac{A}{B}|=|\frac{A+\alpha}{B+\beta}-\frac{A}{B}|=\frac{1}{|B|\cdot |B+\beta|}\cdot |B\alpha\cdot A\beta|$
        * 另取 $\epsilon_0=\frac{|B|}{2}>0, \because lim_{x\to x_0}\beta=0, \therefore \exists \delta_1>0, 当 0<|x-x_0|<\delta_1 时$
          * $|\beta-0|=|\beta|< \frac{|B|}{2}$ 
        * 当 $0<|x-x_0|<\delta_1$ 时, 
          * $|B+\beta|\ge|B|-|\beta|>\frac{|B|}{2}$
        * $\therefore \frac{1}{|B|\cdot |B+\beta|}<\frac{2}{|B|^2} \ (*)$
        * $\because lim_{x\to x_0}(B\alpha-A\beta)=0$
        * $\therefore \forall \epsilon >0 , \exists \delta_2>0, when \ 0<|x-x_0|<\delta $
          * $|B\alpha-A\beta-0|=|B\alpha-A\beta|<\epsilon \ (**)$
        * 取 $\delta=min\{\delta_1,\delta_2\}, 当 0<|x-x_0|<\delta 时, (*)(**) 成立 $
        * $|\frac{f(x)}{g(x)}-\frac{A}{B}|<\frac{2}{B^2}\cdot \epsilon$
          * 那么由于 $\epsilon$ 可以被随意控制, 那么也就意味着 $|\frac{f(x)}{g(x)} 与 \frac{A}{B}|$ 无限接近
        * $\therefore lim_{x\to x_0}\frac{f(x)}{g(x)}=\frac{A}{B}$
   5. 例子
      1. $lim_{x\to2}(3x^2-2x+3)$
         * 解: 
           * $lim_{x\to2}(3x^2-2x+3)$
           * $=lim_{x\to2}3x^2-lim_{x\to2}2x+lim_{x\to2}3$
           * $=3lim_{x\to2}(x\cdot x)-2lim_{x\to2}(x)+3$
           * $=3*4+2*2+3=11$
      2. $lim_{x\to1}(\frac{x^3-2}{x^2+x+1})$
         * 解: 
           * $lim_{x\to1}(\frac{x^3-2}{x^2+x+1})=\frac{lim_{x\to1}(x^3-2)}{lim_{x\to1}(x^2+x+1)}$
           * $=\frac{lim_{x\to1}(x^3)-lim_{x\to1}(2)}{lim_{x\to1}(x^2)+lim_{x\to1}(x)+lim_{x\to1}(1)}$
           * $=\frac{1-2}{1+1+1}=-\frac{1}{3}$
         * Note1:
           * $P(x)=a_nx^n+...+a_1x^1+a_0$
           * 则 $lim_{x\to x_0}p(x)=p(x_0)$
         * Note2:
           * $P(x)=a_nx^n+...+a_1x^1+a_0$
           * $Q(x)=b_mx^m+...+b_1x^1+b_0$
           * 当 $Q(x_0)\ne0$
           * 则 $lim_{x\to x_0}\frac{P(x)}{Q(x)}=\frac{P(x_0)}{Q(x_0)}$
      3. $lim_{x\to1}\frac{x^2+x-2}{x^2-1}$
         * 解: 
           * 数学要注重原理
           * $lim_{x\to1}\frac{x^2+x-2}{x^2-1}=lim_{x\to1}\frac{(x-1)(x+2)}{(x-1)(x+1)}=lim_{x\to1}\frac{x+2}{x+1}=\frac{3}{2}$ (绕过一下 分母为0的情况即可)
      4. $lim_{x\to\infty}\frac{2x^2-x+2}{x^2+1}$
         * 解: 
           * $lim_{x\to\infty}\frac{2x^2-x+2}{x^2+1}=lim_{x\to\infty}\frac{2-\frac{1}{x}+\frac{2}{x^2}}{1+\frac{1}{x^2}}=2$
      5. $lim_{x\to\infty}\frac{2x^2-x+2}{x+1}$
         * 解: 
           * $lim_{x\to\infty}\frac{2x^2-x+2}{x+1} \Rightarrow(取倒数) lim_{x\to\infty}\frac{\frac{1}{x}+\frac{1}{x^2}}{1+\frac{2}{x}+\frac{1}{x^2}} =0$ (无穷小)
           * $\therefore lim_{x\to\infty}\frac{2x^2-x+2}{x+1} = \infty$
         * Note: 
           * $P(x)=a_nx^n+...+a_1x^1+a_0$
           * $Q(x)=b_mx^m+...+b_1x^1+b_0$
           * $lim_{x\to\infty}\frac{P(x)}{Q(x)}=\begin{cases}\frac{a_n}{b_m} &, m=n \\ \infty&,n>m \\ 0&,n<m  \end{cases}$
3. 复合运算极限法则
   1. $Th. y=f(u), u=\phi(x),\phi(x)\ne a$
      * $若 lim_{u\to a}f(u)=A, lim_{x\to x_0}\phi(x)=a, 则 lim_{x\to x_0}f(\phi(x))=A$
        * 证明: 
          * $\forall\epsilon>0, \because lim_{u\to a}f(u)=A, \therefore \exists \eta>0, 当 0<|u-a|<\eta 时.$
          * $|f(u)-A|<\epsilon \ (*)$
          * $对 \eta >0, \because lim_{x\to x_0}\phi(x)=a, \therefore \exists \eta>0, 当 0<|x-x_0|<\delta 时.$
          * $0<|\phi(x)-a|<\eta \ (**)$
          * $\therefore |f(\phi(x))-A|<\eta $
          * $\therefore f(\phi(x))=A$


### 第六节 极限存在准则 ⭐️ 

1. 极限存在准则
   1. 准则 I: 迫敛定理 (夹逼定理)
      * 情况1 : 数列型
        * 设: 
          * 已知
            * $a_n\le b_n \le c_n$
            * $lim_{n\to\infty}a_n=lim_{n\to\infty}b_n=A$
          * 则 $lim_{n\to\infty}b_n=A$
        * 证明: 
          * $\forall\epsilon>0$
          * $\because lim_{n\to\infty}a_n=A, \therefore \exists N_1>0, 当 n > N_1 时, $
          * $|a_n-A|<\epsilon \Leftrightarrow A-\epsilon < a_n < A+\epsilon $ (*)
          * 又 $\because lim_{n\to\infty}C_n=A, \therefore \exists N_2>0, 当 n > N_2 时, $
          * $|c_n-A|<\epsilon \Leftrightarrow A-\epsilon < c_n < A+\epsilon $ (**)
          * 取 $N=max\{N1,N2\} , 当 n> N 时, (*)/(**) 成立$
          * 当 n>N 时, 有 $A-\epsilon<a_n\le b_n\le c_n<A+\epsilon$
          * $\Rightarrow A-\epsilon < b_n < A+\epsilon \Leftrightarrow |b_n-A|<\epsilon$
          * $\therefore lim_{n\to\infty}b_n=A$
        * 例子1: 
          * $lim_{n\to\infty}(\frac{1}{\sqrt{n^2+1}}+\frac{1}{\sqrt{n^2+2}}+...+\frac{1}{\sqrt{n^2+n}})$
          * 解: 
            * 令 $b_n=\frac{1}{\sqrt{n^2+1}}+\frac{1}{\sqrt{n^2+2}}+...+\frac{1}{\sqrt{n^2+n}}$
            * 1. $ \frac{n}{\sqrt{n^2+n} } \le b_n \le \frac{n}{\sqrt{n^2+1}}$ (找个上式中最小的, 找个上式中最大的, 证明他们极限相等, 从而利用夹逼定理, 求得 $b_n$ 的极限)
              2. $lim_{n\to\infty}\frac{n}{\sqrt{n^2+n} } = lim_{n\to\infty}\frac{1}{\sqrt{1+\frac{1}{n}} } = 1 $ && $lim_{n\to\infty}\frac{n}{\sqrt{n^2+1} } = lim_{n\to\infty}\frac{1}{\sqrt{1+\frac{1}{n^2}} } = 1$
            * $\therefore 原式 = 1$
        * 例子2: 
          * $lim_{n\to\infty}(\frac{1}{n^2+1}+\frac{1}{n^2+2}+...+\frac{1}{n^2+n})$
          * 解: 
            * 令 $b_n=\frac{1}{n^2+1}+\frac{1}{n^2+2}+...+\frac{1}{n^2+n}$
            * 1. $ \frac{n^2}{n^2+n } \le b_n \le \frac{n^2}{n^2+1}$ (找个上式中最小的, 找个上式中最大的, 证明他们极限相等, 从而利用夹逼定理, 求得 $b_n$ 的极限)
              2. $lim_{n\to\infty}\frac{n}{n^2+n } = lim_{n\to\infty}\frac{1}{1+\frac{1}{n} } = 1 $ && $lim_{n\to\infty}\frac{n^2}{n^2+1 } = lim_{n\to\infty}\frac{1}{1+\frac{1}{n^2} } = 1$
            * $\therefore 原式 = 1$
      * 情形2: 函数型
        * If
          1. $f(x)\le g(x) \le h(x)$
          2. $limf(x)=limh(x)=A$
        * 则 $lim g(x)=A$
   2. 准则2: 单调有界的数列, 必有极限
      * Note: 
        1. $\{a_n\} 有界 \Leftrightarrow \{a_n\}有上下界$
        2. 如果 $\{a_n\}↑ \begin{cases} 有上界 &\Rightarrow lim_{n\to\infty}a_n\exists \\ 无上界 & \Rightarrow lim_{n\to\infty}a_n 不存在 \end{cases}$ (箭头向上代表函数单调递增)
        3. 如果 $\{a_n\}↓ \begin{cases} 有下界 &\Rightarrow lim_{n\to\infty}a_n\exists \\ 无下界 & \Rightarrow lim_{n\to\infty}a_n 不存在 \end{cases}$ (箭头向下代表函数单调递减)
      * 例题3: 
        * 若 $a_1=\sqrt{2}, a_2=\sqrt{2+\sqrt{2}},a_3=\sqrt{2+\sqrt{2+\sqrt{2}}}, ... $
        * 求证: $lim_{n\to\infty}a_n\exists, $ 求此极限
        * 证: 
          1. $a_{n+1}=\sqrt{2+a_n} ,(n=1,2,3,...)$
          2. $\therefore \{a_n\}↑$(单调递增), 显然
          3. 现证 $a_n\le 2$
             * n=1 时, $a_1=\sqrt{2}\le2;$
             * 当 n = k 时, 设 $a_k\le 2;$
             * 当 n = k +1 时, $a_{k+1}=\sqrt{2+a_k}\le\sqrt{2+2}=2$
             * $\therefore \forall n, 有 a_n \le2$
             * $\therefore lim_{n\to\infty}a_n 存在$
          4. 令 $lim_{n\to\infty}a_n=A$
             * 由 $a_{n+1}=\sqrt{2+a_n} \Rightarrow A=\sqrt{2+A}$
             * $\Rightarrow A^2-A-2=0$
             * $\Rightarrow A=-1 (舍) , A=2$
2. 两个重要极限 
   1. $lim_{x\to0}\frac{sinx}{x}(lim_{x\to0}\frac{sim\Delta}{\Delta})$ = 1
      * ![image-20230318165300581](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230318165300581.png)
   
      * 设: $0< x < \frac{\pi}{2}$
        * $S_{\triangle AOB}=\frac{1}{2}sinx$
        * $S_{扇AOB}=\frac{1}{2}x$
        * $S_{RT\triangle AOC}=\frac{1}{2}tanx$
          * $\frac{AC}{OA}=tanx \Rightarrow AC=tanx \because (OA =1)$
        * $\therefore sinx < x < tanx \Rightarrow 1<\frac{x}{sinx}< \frac{1}{cosx}$ 
          * $0\le1-cosx\le2sin^2\frac{x}{2}<2(\frac{x}{2})^2=\frac{1}{2}x^2$
        * $\because lim_{x\to 0^+}\frac{1}{2}x^2=0 \therefore lim_{x\to 0^+}(1-cosx)=0 \Rightarrow lim_{x\to 0^+}cosx =1 $
        * $\therefore lim_{x\to0^+}\frac{1}{cosx}=1$
        * $\therefore lim_{x\to0^+}\frac{x}{sinx}=1$
        * $\because \frac{x}{sinx} 为偶函数. \therefore lim_{x\to0^-}\frac{x}{sinx}$
        * $\therefore lim_{x\to0}\frac{x}{sinx}=1$
        * $\therefore (\mathrm{I})  lim_{x\to0}\frac{sinx}{x}=1$
      * 推广: $lim_{x\to0}\frac{sin\Delta}{\Delta}=1$
        * 例子1: $求 lim_{x\to0}\frac{sin3x}{x}$
          * 解: $lim_{x\to0}\frac{sin3x}{x}=3*lim_{x\to0}\frac{sin3x}{3x}=3$
        * 例子2: $lim_{x\to0}\frac{1-cosx}{x^2}$
          * 解: $lim_{x\to0}\frac{1-cosx}{x^2} = lim_{x\to0}\frac{2sin^2\frac{x}{2}}{x^2}$
            * $=\frac{1}{2}lim_{x\to0}(\frac{sin\frac{x}{2}}{\frac{x}{2}}) = \frac{}{}*1^2=\frac{1}{2}$
   2. $lim_{n\to\infty}(1+\frac{1}{n})^n = e$ 
      * $a_n=(1+\frac{1}{n})^n$
      * $a_n=C^0_n+C^1_n*\frac{1}{n}+C^2_n*\frac{1}{n^2}+...+C^n_n\frac{1}{n^n}$
        * $= 1+ 1+\frac{n(n-1)}{2!} + \frac{n(n-1)(n-2)}{3!}+ ... + \frac{n(n-1)...2*1}{n!}*\frac{1}{n^n}$
        * $= 1+1+\frac{1}{2!}(1-\frac{1}{n})+\frac{1}{3!}(1-\frac{1}{n})(1-\frac{2}{n})+...+\frac{1}{n!}(1-\frac{1}{n})...(1-\frac{n-1}{n})$
      * $a_n=(1+\frac{1}{n})^n$
        * $= 1+1+\frac{1}{2!}(1-\frac{1}{n})+\frac{1}{3!}(1-\frac{1}{n})(1-\frac{2}{n})+...+\frac{1}{n!}(1-\frac{1}{n})...(1-\frac{n-1}{n})$
      * $a_{n+1}=(1+\frac{1}{n+1}^{n+1})$
        * $= 1+1+\frac{1}{2!}(1-\frac{1}{n+1})+\frac{1}{3!}(1-\frac{1}{n+1})(1-\frac{2}{n+1})+...+\frac{1}{n!}(1-\frac{1}{n+1})...(1-\frac{n-1}{n+1})+ \frac{1}{(n+1)^{n+1}}$
      * $ \therefore a_n < a_{a+1}, 即 {a_n} 单调递增 ↑$
      * 又 $a_n \le 1+1+\frac{1}{2!}+ .. + \frac{1}{n!} \le 1+1 +\frac{1}{1*2} + \frac{1}{2*3} + \frac{1}{3*4} + ... + \frac{1}{n(n-1)}$
      * 又$ n(n-1) \le n! \Rightarrow \frac{1}{n!} \le \frac{1}{n(n-1)} $
        * $= 1+1 + (1-\frac{1}{2}) + ... + (\frac{1}{n-1}-\frac{1}{n})=3-\frac{1}{n} \le 3$
      * $即 \{a_n\} 有上界$
      * $lim_{n\to\infty}(1+\frac{1}{n})^n \exists$
      * $\therefore lim_{n\to\infty}(1+\frac{1}{n})^n = e $
      * 推广:  $lim_{x\to\infty}(1+\frac{1}{x})^x = e$
        * $\&\ \ \ lim_{\Delta\to0}(1+\Delta )^\frac{1}{\Delta}=e$
      * 例题3: 
        * $lim_{x\to0}(1+2x)^{\frac{1}{sinx}}$
        	* 解: $lim_{x\to0}(1+2x)^\frac{1}{sinx}= lim_{x\to0}[(1+2x)^{\frac{1}{2x}}]^{2x*\frac{1}{sinx}}$
        		* $= e^{2lim_{x\to0}\frac{x}{sinx}}= e^2$
      * 例题4: 
        * $lim_{x\to0}(1+x^2)^{frac{1}{x*sin2x}}$
        	* 解: $lim_{x\to0}(1+x^2)^{\frac{1}{x*sin2x}}=lim_{x\to0}\{[1+(-x^2)]^{\frac{1}{-x^2}}\}^{-x^2*\frac{1}{x*sinx}}$
        		* $= e^{-\frac{1}{2}*\frac{2x}{sin2x}}=e^{-\frac{1}{2}}$
      * 例题5: 
      	* $lim_{x\to0}\frac{ln(1+x)}{x}$
      		* 解: $lim_{x\to0}\frac{ln(1+x)}{x}=\lim_{x\to0}\frac{1}{x}ln(1+x)$
      			* = $lim_{x\to0}ln(1+x)^{\frac{1}{x}}=lne=1$


### 第七节 无穷小的比较

6:17:00

* 主要注重于 无穷小的比较

1. 无穷小的概念与性质
   * 定义: $如果 lim_{x\to x_0}\alpha(x)=0, 称 \alpha(x)当 x\to x_0 时为无穷小$
     * 简称: 以 0 为极限的函数叫做无穷小
   * 性质: 
     1. $\alpha\to0,\beta\to0, 则 \begin{cases} \alpha\pm\beta \to 0 \\ k\alpha\to0\\\alpha\beta\to0\end{cases}$
     2. $\alpha\to0, |\beta|\le M, 则 \alpha\beta\to0$
        * 证明:  $\forall \epsilon > 0 , \because lim_{x\to0}\alpha(x)=0, \therefore \exists \delta , 当 0<|x-x_0|<\delta 时$
        	* $|\alpha-0|=|\alpha| < \epsilon$
        	* $\therefore 当 0<|x-x_0| < \delta 时,$
        		* $|\alpha\beta|=|\alpha|*|\beta|<M\epsilon$
          * $\therefore lim_{x\to x_0}\alpha\beta =0$
          * 如: $lim_{x\to0}x^2sin\frac{1}{x}=0$
     3. $limf(x)=A \Leftrightarrow f(x)=A+\alpha,\alpha\to0$

2. 无穷小的比较
   * 无穷小之间也有变小的速度差距, 这个知识点是为了体现这种差距
   * 设 $\alpha \to 0, \beta \to 0$
     1. $lim\frac{\beta}{\alpha}=0 , 称 \beta 为 \alpha 的高阶无穷小, 记为 \beta = {o}(\alpha), lim\frac{\beta}{\alpha}=\infty, 称 \beta 为 \alpha 的低阶无穷小$
     2. $lim\frac{\beta}{\alpha}=k(\neq 0,\infty) (\beta\ is\ almost\ k\ times\ of\ \alpha), 称 \alpha 和 \beta 为同阶无穷小, 记 \beta ={O}(\alpha)$
        * 如果 $lim\frac{\beta}{\alpha}=1, 称 \alpha 与 \beta 为等价无穷小, 记 \alpha \sim \beta $
     3.    $lim\frac{\beta}{\alpha}=k (\neq 0 , \infty)$
        * 称 $\beta 为 \alpha 的k阶无穷小$

3. 等价无穷小的性质以及常见的等价无穷小
   1. 等价无穷小性质, 
      1. $\alpha\to0, \beta\to0$, 则 $\alpha \sim \beta \Leftrightarrow \beta = \alpha +0(\alpha)$
         * 证明: $"\Rightarrow" 设 \alpha \sim \beta \Rightarrow lim\frac{\beta}{\alpha}=1$
           * $\Rightarrow \frac{\beta}{\alpha}=1+\gamma, \gamma\to 0 $
           * $\beta = \alpha+\alpha\gamma$
           * $\because lim\frac{\alpha\gamma}{\alpha}=0, \therefore \alpha\gamma = 0(\alpha)$
           * $\beta = \alpha + 0(\alpha)$
         * 证明 : $"\Leftarrow" 设 \beta=\alpha+0(\alpha)$
           * $\Rightarrow \frac{\beta}{\alpha}=1+\frac{0(\alpha)}{\alpha}$
           * $\because lim\frac{\beta}{\alpha}=1$ 
           * $\therefore \alpha \sim \beta$

   2. $\alpha \to 0, \beta \to 0$

      * 证明If $\alpha \sim \alpha_1, \beta \sim \beta_1; lim\frac{\beta_1}{\alpha_1}=A$, 则 $lim\frac{\beta}{\alpha}=A$
        * 证: 
          * $\alpha \sim \alpha_1, \beta\sim\beta_1 \Rightarrow lim_\frac{\alpha}{\alpha_1}=1, lim\frac{\beta_1}{\beta}=1$
          * $\because \frac{\beta}{\alpha}=\frac{\alpha_1}{\alpha}*\frac{\beta_1}{\alpha_1}*\frac{\beta}{\beta_1}$
          * $又\because lim\frac{\alpha_1}{\alpha}=1, lim\frac{\beta_1}{\alpha_1}=A, lim\frac{\beta}{\beta_1}=1$
          * $\therefore lim\frac{\beta}{\alpha}=lim\frac{\alpha_1}{\alpha}*lim\frac{\beta_1}{\alpha_1}*lim\frac{\beta}{\beta_1}=A$

   * 常见的等价无穷小: $x\to 0$ (七个)

     1. $lim_{x\to 0}\frac{x}{sinx}=1 \Rightarrow x\sim sinx(x\to 0)$
     2. $lim_{x\to0}\frac{x}{tanx}=lim_{x\to0}\frac{x}{sinx}*cosx=1 \Rightarrow x\sim tanx;$
     3. $lim_{x\to0}\frac{x}{arcsinx}, arcsinx=t, lim_{t\to0}\frac{sint}{t}=1 \Rightarrow x\sim arcsimx$
     4. $x\sim arctanx$
     5. $x\sim ln(1+x)$
     6. $x\sim e^x-1$
     7. $1-cosx\sim\frac{1}{2}x^2$
        * $\lim_{x\to0}\frac{1-cosx}{x^2}=\lim_{x\to0}\frac{2sin^2\frac{x}{2}}{x^2}=lim_{x\to0}\frac{2\cdot(\frac{x}{2})^2}{x^2}=\frac{1}{2}$
     8. $(1+x)^a-1\sim ax$
        * $lim_{x\to0}\frac{(1+x)^a-1}{x}=lim_{x\to0}\frac{e^{a\cdot ln(1+x)}-1}{x} ;(e^\Delta-1\sim \Delta (\Delta \to 0))$
          * $=lim_{x\to0}\frac{a\cdot ln(1+x)}{x}=a\cdot lim_{x\to0}\frac{x}{x}=a$
          * $\therefore (1+x)^a-1\sim ax$
   
   * 等价无穷小例题
     * 1
       * $lim_{x\to0}\frac{sin3x}{ln(1+2x)}, 求极限$
       * 解: 
         * $\because sin3x \sim 3x , ln(1+2x)\sim 2x$
         * $\therefore lim_{x\to0}\frac{sin3x}{ln(1+2x)}=\lim_{x\to0}\frac{3x}{2x}=\frac{3}{2}$
     * 2
       * $lim_{x\to0}\frac{(1+2x)^x-1}{x^2}, 求极限$
       * 解: 
         * $lim_{x\to0}\frac{(1+2x)^x-1}{x^2}=lim_{x\to0}\frac{e^{2\cdot ln(1+2x)-1}}{x^2}(e^\Delta-1\sim\Delta (\Delta \to 0))$
         * $=lim_{x\to0}\frac{x\cdot ln(1+2x)}{x^2}=lim_{x\to0}\frac{ln(1+2x)}{x}=lim_{x\to0}\frac{2x}{x}=2$
     * 3
       * $lim_{x\to0}\frac{e^{-x^2}-1}{1-cos2x}, 求极限$
       * 解:
         * $\because e^{-x^2}-1 \sim -x^2, 1-cos2x\sim \frac{1}{2}\cdot(2x)^2=2x^2$
         * $\therefore 原式=lim_{x\to0}\frac{-x^2}{2x^2}=-\frac{1}{2}$
     

### 第八节 函数的连续性与间断点

* 前置描述
  1. $x\to a 时, x\ne a , lim_{x\to a}f(x) 与 f(a) 无关$
  2. $lim_{x\to a}f(x) 与 f(a) 情形:$
     * 断: 
       * $f(a-0)=f(a+0)=A\ne f(a)$ , 既 空心点的函数值不等于 极限值
       * $f(a-0)\ne f(a+0)=f(a)$

* 连续
  * 定义1
    * 函数在一点连续, 则 $lim_{x\to a}f(x)=f(a) 或 f(a-0)=f(a+0)=f(a)$
  * Note 
    * If $f(a-0)=f(a), 称 f(x) 在 x=a 左连续$
    * If $f(a+0)=f(a), 称f(x) 在 x=a 右连续$
  * 例题
    * 1
      * $f(x)=\begin{cases} \frac{e^{ax}-1}{ln(1+x)}, & x>0 \\2, & x=0\\ \frac{b^2}{1+x^2} ,& x<0  \end{cases}, f(x) 在 x=0 连续, 求 a,b$
      * 解: 
        * $f(0+0)=lim_{x\to 0 ^+}f(x)=lim_{x\to0^+}f(x)=lim_{x\to0^+}\frac{e^{ax}-1}{ln(1+x)}=lim_{x\to0^+}\frac{ax}{x}=a;$
        * $f(0)=2;$
        * $f(0-0)=lim_{x\to0^-}f(x)=lim_{x\to0^-}\frac{b}{1+x^2}=\frac{b}{1}=b$
        * $\because f(x) 在 x=0 连续, $
        * $\therefore f(0+0)=f(0-0)=f(0),$
        * $\therefore a=2,b=2$
  * 定义2
    * $f(x) 在闭区间上连续 - 设 f(x) 在 [a,b] 上有定义, 当$
      1. $f(x) 在 (a,b) 内 处处连续;$
      2. $f(a)=f(a+0), f(b)=f(b-0)$
    * 称 $f(x) 在 [a,b] 上连续, 记 f(x)\in C[a,b]$

* 间断点分类

  * 概念

    * 间断 - If $lim_{x\to a}f(x) \ne f(a), 称 f(x) 在 x=a 间断$

  * 分类

    1. 第一类间断点 , $f(a-0), f(a+0) 有值$
       1. $f(a-0)=f(a+0) \ne f(a) , x=a 为 f(x) 的 可去间断点$
       2. $f(a-0)\ne f(a+0),x=a 为 f(x) 的 跳跃间断点$
    2. 第二类间断点, $f(a-0), f(a+0) 至少有一个不存在, 称 x=a 为 第二类间断点$

  * 例题

    * 1

      * $f(x)=\frac{x^2-3x+2}{x^2-1}, 求 f(x) 的 间断点以及分类$
      * 解: 
        * $x=1 和 x=-1 为 f(x) 的间断点$
        * $\because lim_{x\to-1}f(x)=lim_{x\to-1}\frac{x^2-3x+2}{x^2-1}=\infty$
          * $x=-1 为 f(x) 的 第二类间断点$
        * $\because lim_{x\to1}f(x)=lim_{x\to1}\frac{(x-2)(x-1)}{(x+1)(x-1)}=lim_{x\to1}\frac{x-2}{x+1}=-\frac{1}{2}$
          * 既 $f(1-0)=f(1+0)=-\frac{1}{2}$
          * $x=1 为 f(x) 的 可去间断点$

    * 2

      * $f(x)=\frac{x}{sinx}, 求 间断点的分类$

      * 解: 

        * $x=k\pi (k\in \mathbb{Z}), 为 f(x) 的间断点$
        * $\because lim_{x\to0}f(x)=lim_{x\to0}\frac{x}{sinx}=1$
          * 即 $f(0-0)=f(0+0)=1$

        * $\therefore x=0 为 f(x) 的 可去间断点;$
        * $又 \because lim_{x\to k\pi}f(x)=\infty$
        * $\therefore x=k\pi (k\in \mathbb{Z} 且 k\ne 0) 为 第二类间断点$

  * Note: 

    * $a>1 时$
      * $lim_{x\to-\infty}a^x=0$
      * $lim_{x\to+\infty}a^x=+\infty$
        * 如 $lim_{x\to0^-}e^\frac{1}{x}=0, lim_{x\to0^+}e^\frac{1}{x}=+\infty$

    * 例子
      * $f(x)=\frac{1-2^x}{1+2\frac{1}{x}}, 求 f(x) 的 间断点 及 分类$
        * 解: 
          * $x=0 为 f(x) 的 间断点$
          * $f(0-0)=lim_{x\to0^-}f(x)=lim_{x\to0^-}\frac{1-2^\frac{1}{x}}{1+2^\frac{1}{x}}=1;$
          * $f(0+0)=lim_{x\to 0^+}f(x)=lim_{x\to 0^+}\frac{1-2^\frac{1}{x}}{1+2^\frac{1}{x}}$
            * $=\frac{0-1}{0+1}=-1$
          * $\because f(0-0)\ne f(0+0)$
          * $\therefore x=0 为 f(x) 的 跳跃间断点$

### 第九节 连续函数运算 以及 初等函数 连续性

* 连续函数运算
  1. 四则
     * 设 $f(x),g(x) 在 x=x_0处连续, 则$
       1. $f(x)\pm g(x) 在 x=x_0 连续;$
       2. $f(x)\cdot g(x) 在 x=x_0 连续;$
       3. If $g(x_0)\ne 0, 则 \frac{f(x)}{g(x)}在 x=x_0连续$
     * 证明: 
       * $\because f(x), g(x) 在 x=x_0 连续$
       * $\therefore lim_{x\to x_0}f(x)=f(x_0), lim_{x\to x_0}g(x)=g(x_0)$
       * $\therefore lim_{x\to x_0}[f(x)\pm g(x)]=lim_{x\to x_0}f(x) \pm lim_{x\to x_0}g(x)=f(x_0)\pm g(x_0)$
       * $\therefore f(x)\pm g(x) 在 x=x_0 连续$
       * $lim_{x\to x_0}f(x)g(x)=lim_{x\to x_0}f(x)lim_{x\to x_0}g(x)=f(x_0)g(x_0)$
       * $\therefore f(x)g(x)在 x=x_0 连续$
       * $lim_{x\to x_0}\frac{f(x)}{g(x)}=\frac{lim_{x\to x_0}f(x)}{lim_{x\to x_0}g(x)}=\frac{f(x_0)}{g(x_0)}$
       * $\frac{f(x)}{g(x)}在 x=x_0 连续$
  2. 复合运算
     * 定理2
       * $y=f(u), u=\varphi(x), \varphi(x)\ne a, 当 lim_{u\to a}f(u)=A, lim_{x\to x_0}\varphi(x)=a, 则 lim_{x\to x_0}f[\varphi(x)]=A$
       * 证明: 
         * $\forall \epsilon > 0, \because lim_{u\to a}f(u)=A \therefore \exists \eta >0, 当 0 < |u-a|<\eta\ 时$,
           * $|f(u)-A|<\epsilon $     (*)
         * 对 $\eta > 0, \because lim_{x\to x_0}\varphi(x)=a, \therefore \exists \delta >0, 当 0<|x-x_0|<\delta 时$
           * $0<|\varphi(x)-a|<\eta$     (**)
         * $\therefore \forall \epsilon >0, \exists \delta >0, 当 0<|x-x_0|<\delta 时,$
           * $|f[\varphi(x)]-A|=\epsilon$
         * $\therefore lim_{x\to x_0}f[\varphi(x)]=A$
     * 定理3
       * $y=f(u), u=\varphi(x), \varphi(x)\ne a, 当lim_{u\to a}f(u)=f(a), lim_{x\to x_0}\varphi(x)=a, 则$
       * $lim_{x\to x_0}f[\varphi(x)]=f(a)$, 
       * 即 $lim_{x\to x_0}f[\varphi(x)]=f[lim_{x\to x_0}\varphi(x)]=f(a)$
       * 如: 
         * $lim_{x\to 0} arctan \frac{1-x}{1+x}=arctan(\lim_{x\to0}\frac{1-x}{1+x})=arctan1=\frac{\pi}{4}$

* 初等函数的连续性
  * 基本初等函数
    1. $x^a;$
    2. $a^x (a>0 且 a\ne 1);$
    3. $log_a^x (a>0 且 a\ne 1);$
    4. $sinx,cosx,tanx,cotx,secx,cscx;$
    5. $arcsinx,arccosx,arctanx, arccotx$
  * 初等函数, 
    * 由 **常数/基本初等函数** 经过 **四则运算/复合运算** 而成的式子
  * 结论
    * 基本初等函数 在其定义域内 连续
      * 复合运算保持连续性, 基本初等函数保持连续性, 函数的加减乘除保持连续性 
    * 初等函数在其定义域内连续
  * 例子
    * 1
      * $lim_{x\to2}(x^3-3x^2+4)$
        * 解: 
          * $lim_{x\to2}(x^3-3x^2+4)=8-3*4+4=0$
    * 2
      * $lim_{x\to0}(\frac{1+2x}{1-x})^\frac{1}{sin2x}$
        * 解:
          * $lim_{x\to0}(\frac{1+2x}{1-x})^\frac{1}{sin2x}=lim_{x\to0}[(1+\frac{3x}{1-x})^\frac{1-x}{3x}]^{\frac{1}{sin2x}\cdot\frac{3x}{1-x}}$
          * $=lim_{x\to0}e^{\frac{1}{sin2x}\cdot\frac{3x}{1-x}}$
          * $=e^{3lim_{x\to0}\frac{1}{1-x}\cdot \frac{x}{sin2x}}=e^{3\cdot1\cdot lim_{x\to0}\frac{x}{2x}}=e^\frac{3}{2}$
        * 在 求 x趋近于0 的 y 的极限时, 灵活使用等价无穷小来替换化简.

### 第十节 闭区间上连续函数的性质

* 回顾

  * $f(x)\in[a,b]$ 表示 f(x) 在 [a,b] 上连续, 则
    1. $f(x) 在 (a,b) 内 处处连续$
    2. $f(a)=f(a+0), f(b)=f(b-0)$
  * 称 $f(x) 在 [a,b] 上连续, 记 f(x)\in C[a,b]$.

* 定理1 (最值定理)

  * $设 f(x)\in C[a,b] ,则 f(x) 在 [a,b] 上, 能取到最小值 m,和 最大值 M$
  * $即 \exists x_1, x_2 \in [a,b], 使 f(x_1)=m, f(x_2)=M$

* 定理2  (有界定理)

  * $设 f(x) \in C [a,b], 则 \exists k>0, $ $使 \forall x\in [a,b], 有$ $|f(x)|\le k$
  * 证明: 
    * $\because f(x)\in C[a,b] , \therefore f(x) 在 [a,b] 上 取最小值 m 和最大值 M$
    * 即 $f(x)\ge m, f(x)\le M, 或 f(x)在 [a,b] 上 有上下界$
    * $\Rightarrow f(x) 在 [a,b] 上有界$
    * $\exists k>0, \forall x \in [a,b], 有 |f(x)|\le k$

* 定理3 (零点定理)

  * 设 $f(x)\in C[a,b], f(a)f(b)<0$
  * $则 \exists c \in (a,b), 使 f(c)=0$

* 例题

  * 1
    * 证明 $x^5-5x+1=0至少有一个正根$
    * 证: 
      * $f(x)=x^5-5x+1, $
      * $f(x)\in C[0,1],$
      * $f(0)=1,f(1)=-3,$
      * $\because f(0)f(1)<0$
      * $\therefore \exists c \in (0,1), 使 f(c)=0, 即 c^5-5c+1=0$
      * $方程 x^5-5x+1=0 , 至少有一个正根 x=c$

  * 2
    * $f(x)\in C[0,1],f(0)=0, f(1)=1,证明 : \exists \varsigma \in (0,1), 使 f(\varsigma)=\frac{2}{3}$
    * 证: 
      * $令 \varphi(x)=f(x)-\frac{2}{3}, \varphi(x)\in C[0,1]$
      * $\varphi(0)=-\frac{2}{3},\varphi(1)=\frac{1}{3}$
      * $\because \varphi(0)\varphi(1)<0$
      * $\therefore \exists \varsigma \in (0,1), 使 \varphi (\varsigma)=0, 即 f(\varsigma)-\frac{2}{3}=0$
      * 则 $f(\varphi)=\frac{2}{3}$

* 介值定理
  * 介值: The value between m and M
  * $\forall \eta \in [m,M], \exists \varsigma \in [a,b], 使 f(\varsigma)=\eta$
  * 若 $f(x)\in C [a,b], 则 m 于 M 之间任意值皆可被 f(x) 取到$
  * 定理: $设 f(x)\in C[a,b], 则 \forall \eta \in [m,M], \exists \varsigma \in [a,b] , 使 f(\varsigma)=\eta$ (即 介于 m 和M 之间的 值, f(x) 皆可取到
  * Notes: 
    1. $f(x) \in C[a,b], \exists c\in (a,b) ... \Rightarrow 零点定理$
    2. $f(x) \in C [a,b] , \exists \varsigma \in [a,b] , .... \Rightarrow 介值定理$
  * 例子
    * 1
      * $\because f(x) \in C [a,b], \therefore f(x)在 [a,b] 上 可任取 最小值 m 和 最大值 M, m\le f(a) \le M, m\le f(b) \le M$
      * $\because p> 0, q>0$
      * $\therefore pm \le pf(a)\le pM, mq\le qf(b)\le qM$
      * $又 \because p+q=1$
      * $\therefore m \le pf(a)+qf(b)\le M$
      * $\therefore \exists \varsigma \in [a,b], 使 f(\varsigma)=p\cdot f(a)+q\cdot f(b)$
    * 2
      * $f(x)\in C[0,2], f(0)+2f(1)+3f(2)=6, $要求证明 : $\exists c \in [0,2], 使 f(c)=1$
      * 证
        * $f(x)\in C[0,2], 则 f(x) 在 [0,2] 上 取 最大值 M 和 最小值 m$
        * $6m\le f(0) + 2f(1)+3f(2)\le 6M $
        * 即 $m\le 1 \le M$
        * $\therefore \exists c \in [0,2], 使 f(c)=1$

## 第二章 导数与微分

### 第一节 导数概念

* 定义
  * $y=f(x) (x\in \mathbb{D}), x_0\in \mathbb{D}, x_0+\Delta x\in \mathbb{D}$
  * $\Delta y = f(x_0+\Delta x)-f(x_0)$
  * 若 $lim_{\Delta x \to 0}\frac{\Delta y }{\Delta x}, 存在,  称 f(x) 在 x=x_0 处 可导$
  * 极限值 称为 $f(x) 在 x=x_0 处的导数, 记 f'(x_0) 或 \frac{dy}{dx}|_{x=x_0}$
* 例子: 
  * 1
    * $y=x^3, 求 y=x^3 在 x=2 处的导数$
    * 解: 
      * $\Delta y = f(2+\Delta x)-f(2)=(2+\Delta x)^3-2^3=3*2^2\Delta x+ 3*2(\Delta x )^2+(\Delta x)^3$
      * $=12\Delta x + 6(\Delta x)^2+(\Delta x)^3$
      * $lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=\lim_{\Delta x \to 0}[12+6\Delta x+(\Delta x)^2]=12$
      * 即 $\frac{dy}{dx}|_{x=2}=12$

* Notes: 
  1. $f'(x_0)=lim_{\Delta x\to0}\frac{f(x_0+\Delta x)-f(x_0)}{\Delta x}$ (定义1)
     * $x_0\to x, f(x_0)\to f(x)$
     * $\Delta x = x-x_0, \Delta y = f(x)-f(x_0)$
     * $f'(x_0)=lim_{x\to x_0}\frac{f(x)-f(x_0)}{x-x_0}$ (等价定义, 定义2)
  2. 当 $f(x) 在 x=x_0 可导, 则 f(x) 在 x=x_0 连续$
     * 证明: 
       * $\because f(x) 在 x=x_0 可导$
       * $\therefore lim_{x\to x_0}\frac{f(x)-f(x_0)}{x-x_0} 存在$
       * $\therefore lim_{x\to x_0}[f(x)-f(x_0)]=0 ; \Rightarrow lim_{x\to x_0}f(x)=f(x_0)$
       * $即 f(x) 在 x=x_0 连续$
  3. $\Delta x\to 0 \begin{cases} \Delta x \to 0^- \\ \Delta x \to 0^+\end{cases} (或 x\to x_0 \begin{cases}x\to x_0^- \\ x\to x_0^+ \end{cases})$
     * $lim_{\Delta x\to 0^-}\frac{\Delta y}{\Delta x}(=lim_{x\to x^-_0}\frac{f(x)-f(x_0)}{x-x_0}) \triangleq f_-'(x_0)$ - 左导数
     * $lim_{\Delta x\to 0^+}\frac{\Delta y}{\Delta x}(=lim_{x\to x^+_0}\frac{f(x)-f(x_0)}{x-x_0}) \triangleq f_+'(x_0)$ - 右导数
     * $f'(x_0)\exists \Leftrightarrow f_-'(x_0), f_+'(x_0) 存在且相等 $
* 例子: 
  * 1
    * $f(x) = \begin{cases} ln(1+2x),& x\geq 0 \\ e^x-1, & x<0  \end{cases}, 讨论 f(x) 在 x=0 可导性$
    * 解: 
      * $f(0-0)=lim_{x\to 0^-}f(x)=lim+{x\to 0^-}(e^x-1)=0;$
      * $f(0)=0;$
      * $f(0+0)=lim_{x\to 0^+}f(x)=lim+{x\to 0^+}ln(1+2x)=0;$
      * $\because f(0-0)=f(0+0)=f(0)=0$
      * $\therefore f(x) 在 x=0 连续$
      * $f_-'(0)=lim_{x\to 0^-}\frac{f(x)-f(0)}{x-0}=lim_{x\to0^-}\frac{e^x-1}{x}=1;$
      * $f_+'(0)=lim_{x\to 0^-}\frac{f(x)-f(0)}{x-0}=lim_{x\to0^+}\frac{ln(1+2x)}{x}=2;$
      * $\because f_-'(0)\ne f_+'(0), \therefore f(x) 在 x=0 不可导$
  * 2
    * $y=f(x)=|x|, 研究 f(x) 在 x=0 可导性$
    * 解: 
      * 显然, $y=f(x)=|x| 在 x=0 连续$
      * $f_-'(0)=lim_{x\to 0^-}\frac{f(x)-f(0)}{x-0}=lim_{x\to0^-}\frac{|x|}{x}=-1;$
      * $f_+'(0)=lim_{x\to0^+}\frac{f(x)-f(0)}{x-0}=lim_{x\to0^+}\frac{|x|}{x}=1;$
      * $\because f_-'(0)\ne f_+'(0) , \therefore f(x) 在 x=a 不可导$

* 定理
  * $f(x) 在 x = x_0 \Rightarrow f(x) 在 x=x_0$
* 举例: 
  1. $y=f(x)=C, 求 f'(x)$
     * 解: 
       * $f'(x)=lim_{\Delta x\to0}\frac{f(x+\Delta x)-f(x)}{\Delta x}=lim_{\Delta x\to 0}\frac{C-C}{\Delta x}=0$
       * $即 (C)'=0$
  2. $y=x^n, 求 f'(a)$
     * 解:
       * $f'(a)=lim_{x\to a}\frac{f(x)-f(a)}{x-a}=lim_{x\to a}\frac{x^n-a^n}{x-a}$
       * $=lim_{x\to a}\frac{(x-a)(x^{n-1}+ax^{n-2}+ ... + a^{n-2}x+a^{n-1})}{x-a}$
       * $=lim_{x\to a}(x^{n-1}+ax^{n-2}+...+a^{n-1})=na^{n-1}$
       * $\therefore (x^n)'=nx^{n-1}$
       * 一般的, $(x^a)'=ax^{a-1}$
  3. $y=f(x)=a^x (a>0 且 a\ne 1), 求 f'(x)$
     * 解:
       * $f'(x)=lim_{\Delta x \to 0}\frac{f(x+\Delta x)-f(x)}{\Delta x}$
       * $=lim_{\Delta x\to0}\frac{a^{x+\Delta x}-a^x}{\Delta x}$
       * $=a^x\cdot lim_{\Delta x \to 0}\frac{a^{\Delta x}-1}{\Delta x}$
       * $= a^x \cdot lim_{\Delta x \to 0} \frac{e^{\Delta x \cdot ln a} -1}{\Delta x}$ ; $e^\Delta -1 \sim \Delta (\Delta \to 0)$
       * $= a^x \cdot lim_{\Delta x \to 0}\frac{\Delta x \cdot lna}{\Delta x}= a^x\cdot ln a$
       * $\therefore (a^x)'=a^x\cdot ln a$
       * 特别的 , $(e^x)'=e^x$
  4. $y=f(x)=log_ax (a>0 且 a\ne 1, x>0), 求 f'(x)$
     * 解:
       * $f'(x)=lim_{\Delta x\to0}\frac{f(x+\Delta x)-f(x)}{\Delta x}$
       * $=lim_{\Delta x\to 0}\frac{log_a{x+\Delta x}-log_a{x}}{\Delta x}= lim_{\Delta \to 0}\frac{1}{\Delta x}\cdot log_a{(1+\frac{\Delta x}{x})} $
       * $=lim_{\Delta x \to 0}log_a({1+\frac{\Delta x}{x}})^{\frac{1}{\Delta x}}$
       * $=log_a{lim_{\Delta x\to0}[(1+\frac{\Delta x}{x})^{\frac{x}{\Delta x}}]^\frac{1}{x}}; (1+\Delta )^{\frac{1}{\Delta}}\to e^{\Delta}(\Delta \to 0)$
       * $=\frac{1}{x}log_ae=\frac{1}{x}\frac{lne}{lna}=\frac{1}{x\cdot ln a}$
       * $\therefore (log_ax)'=\frac{1}{x\cdot lna}$
       * 特别地, $(ln x)'=\frac{1}{x}$
* 后续还缺 三角函数 和 反三角函数 的求导

### 第二节 求导法则

* 前言
  * 对象: 初等函数 - 材料: 常数/基本初等函数, 动作: 四则/复合函数
  * 任务1: 材料求导: 
    1. $(c)'=0;$
    2. $(x^a)'=ax^{a-1};$
    3. $(a^x)'=a^xlna, (e^x)'=e^x$
    4. $(log_ax)'=\frac{1}{x\cdot lna}, (lnx)'=\frac{1}{x};$
    5. 三角函数
       1. $(sinx)'=cosx;$
       2. $(cosa)'=-sinx;$
    6. 反三角函数
       1. ?

* 求导四则法则

  1. 设 $u(x), v(x) 可导$, 则
     1. $[u(x)\pm v(x)]'=u'(x)\pm v'(x);$
     2. $[u(x)v(x)]'=u'(x)v(x)+u(x)v'(x);$
     3. 设 $v(x)\ne 0, [\frac{u(x)}{v(x)}]'=\frac{u'(x)v(x)-u(x)v'(x)}{v^2(x)}$
  2. 证明: 
     1. 令 $\varphi (x)=u(x)+v(x)$
        * $\Delta \varphi =\varphi (x+\Delta x)-\varphi (x)=u(x+\Delta x)+ v(x+\Delta x)-u(x)-v(x)$
        * =$\Delta u + \Delta v$
        * $\frac{\Delta \varphi }{\Delta x}=\frac{\Delta u}{\Delta x}+\frac{\Delta v}{\Delta x}$
        * $\Rightarrow lim_{\Delta \to 0}\frac{\Delta \varphi}{\Delta x}=lim_{\Delta x \to 0}\frac{\Delta u}{\Delta x}+lim_{\Delta\to 0}\frac{\Delta v}{\Delta x}$
        * $\therefore [u(x)+v(x)]'=u'(x)+v'(x)$
     2. 令 $\varphi (x)=u(x)v(x)$
        * $\Delta \varphi= \varphi (x+\Delta)-\varphi(x)=u(x+\Delta x)v(x+\Delta x)-u(x)v(x)$
        * $=u(x+\Delta x)v(x+\Delta x)-u(x)v(x+\Delta x)+u(x)v(x+\Delta x)-u(x)v(x)$
        * $=\Delta u\cdot v(x+\Delta x)+u(x)\cdot \Delta v$
        * $\frac{\Delta \varphi}{\Delta x}=\frac{\Delta u}{\Delta x}\cdot v(x+\Delta x)+u(x)\cdot \frac{\Delta v}{\Delta x}$
        * $\because lim_{\Delta x\to 0}\frac{\Delta \varphi}{\Delta x}=lim_{\Delta x\to0}\frac{\Delta u}{\Delta x}\cdot lim_{\Delta x\to 0}v(x+\Delta x)+u(x)\cdot lim_{\Delta x\to 0}\frac{\Delta v}{\Delta x}$
        * $\because v(x) 可导, \therefore v(x) 连续, \therefore lim_{\Delta x\to 0}v(x+\Delta x)=v(x)$
        * $\therefore \varphi'(x)=u'(x)v(x)+u(x)v'(x)$
        * 即 $[u(x)v(x)]'=u'(x)v(x)+u(x)v'(x)$
     3. $\varphi(x)=\frac{u(x)}{v(x)} (v(x)\ne 0)$
        * $\Delta \varphi =\varphi (x+\Delta x)-\varphi (x)=\frac{u(x+\Delta x)}{v(x+\Delta x)}-\frac{u(x)}{v(x)}$
        * $=\frac{u(x+\Delta x)v(x)-u(x)v(x+\Delta x)}{v(x)v(x+\Delta x)}$
        * $=\frac{u(x+\Delta x)v(x)-u(x)v(x)-[u(x)v(x+\Delta x)-u(x)v(x)]}{v(x)v(x+\Delta x)}$
        * $=\frac{\Delta u\cdot v(x)-u(x)\cdot \Delta v}{v(x)v(x+\Delta x)}$
        * $\frac{\Delta \varphi}{\Delta x}=\frac{1}{v(x)v(x+\Delta x)}\cdot [\frac{\Delta u}{\Delta x}\cdot v(x)-u(x)\cdot \frac{\Delta v}{\Delta x}]$
        * $lim_{\Delta x \to 0}\frac{\Delta \varphi}{\Delta x}=\frac{1}{v(x)}\cdot\frac{1}{lim_{\Delta x \to 0}v(x+\Delta x)}\cdot [v(x)\cdot lim_{\Delta x\to 0}\frac{\Delta u}{\Delta x}-u(x)\cdot lim_{\Delta x \to 0}\frac{\Delta v}{\Delta x}]$
        * 即 $\varphi '(x)=\frac{1}{v^2(x)}\cdot [u'(x)v(x)-u(x)\cdot v'(x)]$
        * $\therefore [\frac{u(x)}{v(x)}]'=\frac{u'(x)v(x)-u(x)v'(x)}{v^2(x)}$
     4. $y=x^3e^x, 求 y'$
        * 解
          * $y'=(x^3)'e^x+x^3\cdot(e^x)'=3x^2e^x+x^3e^x$
     5. $y=tanx, 求 y'; y=cotx, 求 y'; y=secx, 求 y'; y=cscx, 求 y'$
        * 解: 
          1. $(tanx)'=(\frac{sinx}{cosx})'=\frac{(sinx)'cosx-sinx\cdot(cosx)'}{cos^2x}$
             * =$\frac{cos^2x+sin^2x}{cos^2x}; secx=\frac{1}{cosx}, sin^2x+cos^2x=1$
             * $=\frac{1}{cos^2x}=sec^2x$
          2. $(cotx)'=(\frac{cosx}{sinx})'=\frac{(cosx)'\cdot sinx-cosx\cdot(sinx)'}{sin^2x}$
             * $=\frac{-sin^2x-cos^2x}{sin^2x}; cscx=\frac{1}{sinx}$
             * $=-\frac{1}{sin^2x}=-csc^2x$
          3. $(secx)'=(\frac{1}{cosx})'=\frac{1'\cdot cosx - 1\cdot (cosx)'}{cos^2x}$
             * $=\frac{sinx}{cos^2x}=\frac{1}{cosx}\cdot \frac{sinx}{cosx}=secx\cdot tanx$
          4. $(cscx)'=(\frac{1}{sinx})'=\frac{1'\cdot sinx-1\cdot (sinx)'}{sin^2x}$
             * $=-\frac{cosx}{sin^2x}=-\frac{1}{sinx}\cdot \frac{cosx}{sinx}=-cscx\cdot cotx$

  1. 推论
     1. $(ku)'=k'u+ku'=ku;$
     2. $(uvw)'=(uv')w+(uv)w'$
        * $=(u'v+uv')w+uvw'$
        * $=u'vw+uv'w+uvw'$
     3. 三角函数
        * $(sinx)'=cosx$
        * $(cosx)'=-sinx$
        * $(tanx)'=sec^2x$
        * $(cotx)'=-csc^2x$
        * $(secx)'=secx\cdot tanx$
        * $(cscx)'=-cscx\cdot cotx$

  * 例子: 
    * 1
      * $y=f(x)=x(x+1).....(x+99), 求 f'(0)$
      * 解: 
        * 法一:
          * $f'(0)=lim_{x\to0}\frac{f(x)-f(0)}{x-0}=lim_{x\to0}(x+1)...(x+99)=99!$
        * 法二: 
          * $f'(x)=(x+1)(x+2)...(x+99)+x(x+2)...(x+99)+ .. + x(x+1)...(x+98)$
          * $\therefore f'(0)=99!$

* 反函数求导法则
  * $y=f(x) 严格单调$
  * $u=f(x)\Rightarrow x=\varphi (y)$
  * 定理 1: 
    * $设 y=f(x) 可导, 且 f'(x)\ne 0, x=\varphi(y) 为反函数$
    * $且 x=\varphi (y) 可导, 且 \varphi'(y)=\frac{1}{f'(x)}$
      * 证明: 
        * $f'(x)=lim_{\Delta x \to 0}\frac{\Delta y}{\Delta x}\ne 0 \Rightarrow \Delta y =O(\Delta x)$
        * $\varphi'(y)=lim_{\Delta y \to 0}\frac{\Delta x}{\Delta y}=lim_{\Delta y \to 0}\frac{1}{\frac{\Delta y}{\Delta x}}$
        * 由于 $\Delta y 是 \Delta x 的等价无穷小$
        * $=lim_{\Delta x \to 0}\frac{1}{\frac{\Delta y}{\Delta x}}=\frac{1}{f'(x)}$
        * $\therefore \varphi'(y)=\frac{1}{f'(x)}$
  * 例子
    * 1
      * $y=arcsinx (-1<x<1), 求 y'$
      * 解: 
        * $y=arcsinx\Rightarrow x=siny$
        * $y=f(x) , x=\varphi (y)$
        * $由 f'(x)=\frac{1}{\varphi'(y)}\Rightarrow (arcsinx)'=\frac{1}{cosy}$
        * $\because -1<x<1, \therefore -\frac{\pi}{2}<y<\frac{\pi}{2}\Rightarrow cosy >0$
        * $\therefore (arcsinx)'=\frac{1}{\sqrt{1-sin^2y}}=\frac{1}{\sqrt{1-x^2}}$
    * 2
      * $y=arccosx (-1<x<1), 求 y'$
      * 解: 
        * $y=arccosx \Leftrightarrow x = cosy$
        * $\because -1<x<1, \therefore 0<y<\pi$
        * $又 \because f'(x)=\frac{1}{\varphi '(y)}$
        * $\therefore (arccosx)'=-\frac{1}{siny}=-\frac{1}{\sqrt{1-cos^2y}}=-\frac{1}{\sqrt{1-x^2}}$
    * 3
      * $y=arctanx, 求 y'$
      * 解: 
        * $y=arctanx \Leftrightarrow x=tany$
        * $\because -\infty < x <+\infty , \therefore -\frac{\pi}{2} < y < \frac{\pi}{2}$
        * $\because f'(x)=\frac{1}{\varphi ' (y)}$
        * $又 sec^2x=1+tan^2x, csc^2x=1+cot^2x$
        * $\therefore (arctanx)'=\frac{1}{sec^2y}=\frac{1}{1+tan^2y}=\frac{1}{x^2+1}$
    * 4
      * $y=arccotx, y'$
      * 解:
        * $y=arccot x \Leftrightarrow x=coty$
        * $\because -\infty < x < +\infty , \therefore 0<y<\pi$
        * $又 \therefore f'(x)=\frac{1}{\varphi'(y)}$
        * $(arccotx)'=-\frac{1}{csc^2y}=-\frac{1}{1+cot^2y}=-\frac{1}{1+x^2}$
  * 记: 
    * $ (arcsinx)'=\frac{1}{\sqrt{1-x^2}}$
    * $ (arccosx)'=-\frac{1}{1-x^2}$
    * $ (arctanx)'=\frac{1}{x^2+1}$
    * $ (arccotx)'=-\frac{1}{x^2+1}$
* 复杂函数的求导法则
  * 定理 3:
    * $y=f(u) 可导, u=\varphi(x) 可导, 且 \varphi '(x)\ne 0, 则 y=f[\varphi(x)]可导$
    * $且 \frac{dy}{dx}=\frac{dy}{du}*\frac{du}{dx}=f'(u)\cdot \varphi'(x)=f'[\varphi(x)]\cdot \varphi'(x)$
    * 证明: 
      * $\varphi'(x)=\lim_{\Delta \to 0}\frac{\Delta u }{\Delta x}\ne 0 \Rightarrow \Delta u = O(\Delta x)$
      * $\frac{dy}{dx}=lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=lim_{\Delta x \to 0}(\frac{\Delta y}{\Delta u}\cdot \frac{\Delta u}{\Delta x})=lim_{\Delta x\to 0}\frac{\Delta y}{\Delta u}\cdot lim_{\Delta x\to 0}\frac{\Delta u}{\Delta x}$
      * $=lim_{\Delta u \to 0}\frac{\Delta y}{\Delta u}\cdot lim_{\Delta x \to 0}\frac{\Delta u }{\Delta x}=f'(u)\cdot \varphi'(x)=f'[\varphi(x)]\cdot \varphi'(x)$
      * 即 $\frac{dy}{dx}=f'[\varphi(x)]\cdot \varphi'(x)$
  * 例子
    * 1
      * $y=e^{x^3}+sin^2\frac{1}{x}, 求 y'$
      * 解: 
        * $y'=(e^{x^3})'+(sin^2\frac{1}{x})'$
        * $=e^{x^3}\cdot 3x^2+2sin\frac{1}{x}\cdot cos\frac{1}{x}\cdot (-\frac{1}{x^2}); \ \ \ \ \varphi=u^2,u=sinv,v=\frac{1}{x}$
    * 2
      * $y=lntan(x^2+e^{2x}), 求 y'$
      * 解: 
        * $\frac{dy}{dx}=\frac{1}{tan(x^2+e^{2x})}\cdot sec^2(x^2+e^{2x})\cdot (2x+2e^{2x})$
    * 3
      * $y=e^{sin(x+\frac{1}{x})}, 求 y'$
      * 解:
        * $y'=e^{sin(x+\frac{1}{x})}\cdot cos(x+\frac{1}{x})\cdot (1-\frac{1}{x^2})$
    * 4
      * $y=arctan^2\frac{1-x}{1+x}, 求 y'$
      * 解: 
        * $y'=2arctan\frac{1-x}{1+x}\cdot \frac{1}{1+(\frac{1-x}{1+x})^2}\cdot \frac{(1-x)'(1+x)-(1-x)\cdot (1+x)'}{(1+x)^2}$
        * $=2arctan\frac{1-x}{1+x}\cdot \frac{(1+x)^2}{(1+x)^2+(1-x)^2}\cdot \frac{-1-x-1+x}{(1+x)^2}$
        * =$-2arctan \frac{1-x}{1+x}\cdot \frac{1}{x^2+1}$
* 总结: 
  * 三大工具
    1. 基本公式
       1. $(c)'=0;$
       2. $(x^a)'=ax^{a-1};$
          * $(x^n)'=nx^{n-1}$
          * $\Rightarrow$
          * $(x^a)'=(e^{alnx})')$
            * $=e^{alnx}\cdot a \cdot \frac{1}{x}=x^a\cdot a\cdot \frac{1}{x}$
            * $=ax^{a-1}$
       3. $(a^x)'=a^xlna$
          * $(e^x)'=e^x$
          * $(a^x)'=(e^{xlna})'=e^{xlna}\cdot lna=a^xlna$
       4. $(log_ax)'=\frac{1}{xlna} $
          * $(lnx)'=\frac{1}{x}$
       5. 三角函数
          1. $(sinx)'=cosx,$
          2. $(cosx)'=-sinx,$
          3. $(tanx)'=sec^2x$
          4. $(cotx)'=-csc^2x$
          5. $(secx)'=secxtanx$
          6. $(cscx)'=-cscxcotx$
       6. 反三角函数
          1. $(arcsinx)'=\frac{1}{\sqrt{1-x^2}}(-1<x<1)$
          2. $(arccosx)'=-\frac{1}{1-x^2}(-1<x<1)$
          3. $(arctanx)'=\frac{1}{1+x^2}(-\infty < x < +\infty)$
          4. $(arccotx)'=-\frac{1}{1+x^2}(-\infty < x < +\infty)$
    2. 四则
       1. $(u\pm v)'=u'\pm v';$
       2. $(uv)'=u'v+uv';$
       3. $(\frac{u}{v})'=\frac{u'v-uv'}{v^2};$
    3. 复合求导法则 - 链式法则
       * $y=f(u) 可导, u=\varphi(x) 可导, 且 \varphi'(x)\ne 0$
       * $\Rightarrow y=f[\varphi(x)] 可导, 且 \frac{dy}{dx}=\frac{dy}{du}\cdot \frac{du}{dx}=f'[\varphi(x)]\cdot \varphi'(x)$

### 第三节 高阶导数

* 定义
  * $y=f(x), f'(x)\triangleq\frac{dy}{dx} - y对 x 的 一阶导数$
  * $若 f'(x) 可导$
  * $[f'(x)]'\triangleq f''(x)=\frac{d(\frac{dy}{dx})}{dx}\triangleq \frac{d^2y}{dx^2} y对 x 的 二阶导数$
  * $记 y'',f''(x), \frac{d^2y}{dx^2}$
  * $若 f''(x) 可导$
  * $[f''(x)]'\triangleq f'''(x)=\frac{d(\frac{d^2y}{dx^2})}{dx}\triangleq \frac{d^3y}{dx^3} - y 对 x 的 三阶导数$
  * $记 y''', f'''(x), \frac{d^3y}{dx^3}$
* 高阶导数的表示:
  *  $y',y'',y''',y(4),y(5)...$
* 二阶导数 以上的导数称为 高阶导数
  * 若 $f^{(n-1)(x)} 可导, 则其导数 [f^{(n-1)}(x)]'\triangleq f^{(n)}(x) \triangleq \frac{d^ny}{dx^n}$
* 例子
  * 1
    * $y=(3x-2)^3, 求 y'''$
    * 解: 
      * $y'=4(3x-2)^3\cdot 3$
      * $y''=4\cdot 3(3x-2)^2\cdot 3^2$
      * $y'''=4\cdot3\cdot2(3x-2)^1\cdot 3^3=4!\cdot 3^3(2x-2)$
  * 2
    * $y=e^{3x}, 求 y(10)$
    * 解: 
      * $y'=3e^(3x), y''=3\cdot 3e^{3x}=3^2\cdot e^{3x}$
      * $y^{(10)}=3^10\cdot e^{3x}$
* 方法一: 归纳法
  * 例题
    * 1
      * $y=sinx, 求 y(n)$
      * 解: 
        * $y'=cosx=sin(x+\frac{\pi}{2})$,
        * $y''=-sinx=sin(x+\frac{2\pi}{2})$,
        * $y'''=-cosx=sin(x+\frac{3\pi}{2})$,
        * $y(4)=sinx=sin(x+\frac{4\pi}{2})$,
        * $sin(x+\frac{\pi}{2}+\pi)=-sin(x+\frac{\pi}{2})=-cosx$
        * $\therefore y(n)=sin(x+\frac{n\pi}{2})$
        * 即 $(sinx)^{(n)}=sin(x+\frac{n\pi}{2}) $
        * 同理 $(cosx)^{(n)}=cos(x+\frac{n\pi}{2})$
    * 2
      * $y=e^xsinx, 求 y^{(n)}$
      * 解: 
        * $y'=(e^x)'sinx+e^x(sinx)'=e^xsinx+e^xcosx$
        * $=e^x(sinx+cosx)$
        * $=\sqrt2e^x(\frac{\sqrt2}{2}sinx+\frac{\sqrt2}{2}cosx)$
        * $=\sqrt2e^xsinx(x+\frac{\pi}{4})$
        * $由归纳法, y^{(n)}=(\sqrt2)^{(n)}e^xsin(x+\frac{n\pi}{4})$
    * 3
      * $y=\frac{1}{2x+1}, 求 y^{(n)}$
      * 解: 
        * $y=(2x+1)^{-1}$
        * $y'=(-1)(2x+1)^{-2}\cdot 2$
        * $y''=(-1)\cdot (-2)(2x+1)^{-3}\cdot 2^2$
        * $y(n)=\frac{(-1)^nn!\cdot 2^n}{(2x+1)^{n+1}}$
    * 4
      * $f(x)=\frac{1}{x^2-1}, 求 f^{(n)}(x)$
      * 解: 
        * $f(x)=\frac{1}{2}(\frac{1}{x-1}-\frac{1}{x+1})$
        * $f^{(n)}(x)=\frac{1}{2}[\frac{(-1)^nn!}{(x-1)^{n+1}}-\frac{-1^nn!}{(x+1^{n+1})}]$
    * 5
      * $y=ln(2x+2), y^{(n)} (n\ge 1)$
      * 解:
        * $y'=\frac{1}{3x+2}\cdot 3$
        * $y^{(n)}=\frac{(-1)^{n-1}\cdot (n-1)!\cdot 3^{n-1}}{(3x+2)^n}\cdot 3= \frac{(-1)^{n-1}\cdot (n-1)!\cdot 3^{n}}{(3x+2)^n}$
  * 归纳
    1. $(sinx)^{(n)}=sin(x+\frac{n\pi}{2})$
    2. $(cosx)^{(n)}=cos(x+\frac{n\pi}{2})$
    3. $(\frac{1}{ax+b})^{(n)}=\frac{(-1)^nn!a^n}{(ax+b)^{n=1}}$
  * 方法二: 公式法
    * $(uv)'=u'v+uv'$
    * $(uv)''=(u'v)'+(uv')'=u''v+2u'v'+uv''$
    * 记: Leibniz 公式
      * $(uv)^{(n)}=C^0_nu^{(n)}v+C^1_nu^{(n-1)}v'+C^2_nu^{(n-2)}v''+...+C^n_nuv^{(n)}$
  * 例子: 
    * 1
      * $y=x^2e^x, 求 y^{(5)}$
      * 解: 
        * $y^{(5)}=C^0_5(e^x)^{(5)}+C^1_5(e^x)^{(4)}\cdot 2x+C^2_5(e^x)'''\cdot2+0+0$
        * $=x^2e^x+10xe^x+20e^x$
    * 2
      * $y=x^2sinx, 求 y^{(6)}$
      * 解:
        * $y^{(6)}=C^0_6(sinx)^{(6)}\cdot x^2+C^1_6(sinx)^{(5)}\cdot 2x+ C^2_6(sinx)^{(4)}\cdot 2+0+0$
        * $=x^2sin(x+\frac{6\pi}{2})+12xsin(x+\frac{5\pi}{2}+30sin(x+{\frac{4\pi}{2}}))$
        * $=-x^2sinx+12xcosx+30sinx$

### 第四节 隐函数 及由参数方程确定的函数求导 

* 隐函数求导

  * $y=f(x)$ - 显函数 

  * $F(x,y)=0 理论上可以推导为 y=f(x) , F(x,y)=0 称为 隐函数, 这个推导为 y=f(x) 的过程, 称为 隐函数的显式化$

  * $隐函数 求 \frac{dy}{dx}?$

  * $方法: F(x,y)=0 确定 y 为 x 的函数, 求 \frac{dy}{dx}, y 看成 \varphi(x)$

  * 例子: 

    * 1

      * $e^{x+y}=x^2+y+1 确定 y 为 x 的函数, 求 \frac{dy}{dx}$
      * 解:
        * $e^{x+y}=x^2+y+1 两边对 x 求导$
        * $e^{x+y}\cdot (1+\frac{dy}{dx})=2x+\frac{dy}{dx}$
        * $\Rightarrow (e^{x+y}-1)\frac{dy}{dx}=2x-e^{x+y}\Rightarrow \frac{dy}{dx} = \frac{2x-e^{x+y}}{e^{x+y}-1}$

    * 2

      * $x^y=y^x (x>0,y>0), 求 \frac{dy}{dx}$
      * 解: 
        * $x^y=y^x \Rightarrow ylnx=xlny$
        * $\therefore \frac{dy}{dx}lnx+y\cdot\frac{1}{x}=lny+x\cdot \frac{1}{y}\cdot \frac{dy}{dx}$
        * $\Rightarrow (lnx-\frac{x}{y})\frac{dy}{dx}=lny-\frac{y}{x}$
        * $\therefore \frac{dy}{dx}=\frac{lny-\frac{y}{x}}{lnx-\frac{x}{y}}$

    * 3

      * $2^{xy}+3x=y, 求 y'(0),y''(0)$

      * 解

        1. $x=0 时, y=1;$

        2. $2^{xy}+3x=y 两边同时对 x 求导, (a^x)'=a^xlna$

           * $2^{xy}\cdot ln 2 \cdot (y+x\cdot y')+3=y'$

           * $x=0, y=1 代入, y'(0)=ln2+3;$

        3. $ln2\cdot [2^{xy}\cdot (y+xy')]'+3=y' \Rightarrow ln2\cdot [2^{xy}\cdot ln2\cdot (y+xy')^2+ 2^{xy}\cdot (2y'+xy'')]=y'' $

           * $x=0,y=1,y'(0)=ln2+3 代入$
           * $ln2\cdot [ln2+2(ln2+3)]=y''(0)$
           * $y''(0)=(3ln2+6)\cdot ln2$

    * 4

      * $x-y+\frac{1}{2}siny=0 确定 y=y(x), 求 \frac{d^2y}{dx^2}$
      * 解
        * $x-y+\frac{1}{2}siny=0 两边对 x 求导$
        * $1-\frac{dy}{dx}+\frac{1}{2}cosy\frac{dy}{dx}=0 \Rightarrow \frac{dy}{dx}=\frac{2}{2-cosy}$
        * 法一: 
          * $-\frac{d^2y}{dx^2}+\frac{1}{2}\cdot [-siny\cdot (\frac{dy}{dx})^2+cosy\cdot \frac{d^2y}{dx^2}]=0$
          * $(\frac{1}{2}cosy-1)\cdot \frac{d^2y}{dx^2} = \frac{1}{2}siny\cdot \frac{4}{(2-cosy)^2}$
          * $(cosy-2)\cdot \frac{d^2y}{dx^2}=siny\cdot \frac{4}{(2-cosy)^2}$
          * $\frac{d^2y}{dx^2}=-\frac{4siny}{(2-cosy)^3}$
        * 法二: 
          * $\frac{dy}{dx}=\frac{2}{2-cosy}$
          * $\frac{d^2y}{dx^2}=\frac{2'\cdot (2-cosy)-2\cdot \frac{d(2-cosy)}{dx}}{(2-cosy)^2}$
          * $=\frac{-2\cdot siny\cdot \frac{dy}{dx}}{(2-cosy)^2}$
          * $=\frac{-4siny}{(2-cosy)^3}$

    * 5

      * $y=(1+x^2)^{sinx}, 求 y'$
      * 解: 
        * 法一:
          * $y=e^{sinx\cdot ln (1+x^2)}$
          * $\frac{dy}{dx}=e^{sinx\cdot ln (1+x^2)}\cdot [(sinx)'ln(1+x^2)+sinx\cdot (ln(1+x^2))']$
          * $=(1+x^2)^{sinx}\cdot [cosx\cdot ln(1+x^2)+sinx\cdot \frac{1}{1+x^2}\cdot 2x]$
        * 法二: 
          * $lny=sinx\cdot ln(1+x^2), 两边对 x 求导$
          * $\frac{1}{y}\cdot \frac{dy}{dx}=cosx\cdot ln (1+x^2)+sinx\cdot \frac{1}{1+x^2}\cdot 2x$
          * $\frac{dy}{dx}=(1+x^2)^{sinx}\cdot [cosx\cdot ln(1+x^2)+sinx\cdot \frac{2x}{1+x^2}]$

* 常数方程确定的函数求导
  * 由 $\begin{cases} x=\varphi(t) \\ y=\psi(t) \end{cases} 确定 y=y(x) , 称为由 常数方程而确定的 函数$
  * 定理: 
    * $\begin{cases} x=\varphi(t) \\ y=\psi(t) \end{cases}, 其中 \varphi (t), \psi (t) 可导, 且 \varphi'(t)\ne 0$
    * 则 $\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{\psi'(t)}{\varphi'(t)}$
    * 证明: 
      * $\varphi'(t)=lim_{\Delta t\to 0 }\frac{\Delta x}{\Delta t}\ne 0 \ne \Delta x = O (\Delta t)$
      * $\frac{dy}{dx}=lim_{\Delta x \to 0}\frac{\Delta y}{\Delta x}=lim_{\Delta x\to 0}\frac{\frac{\Delta y}{\Delta t}}{\frac{\Delta x}{\Delta t}}$
      * $=lim_{\Delta t \to 0}\frac{\frac{\Delta y}{\Delta t}}{\frac{\Delta x}{\Delta t}}=\frac{lim_{\Delta t \to 0}\frac{\Delta y}{\Delta t}}{lim_{\Delta t \to 0}\frac{\Delta x}{\Delta t }}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{\psi'(t)}{\varphi '(t)}$
  * 例题
    * 1
      * $\begin{cases} x=arctant \\ y=ln(1+t^2) \end{cases}, 求 \frac{dy}{dx}, \frac{d^2y}{dx^2}$
      * 解: 
        * $\frac{dy}{dx}=\frac{\frac{dy}{dt}}{\frac{dx}{dt}}=\frac{\frac{2t}{1+t^2}}{\frac{1}{1+t^2}}=2t$
        * 那么是否 $\frac{d^2y}{dx^2}=2?$, 这种想法是错误, 这里如果直接等于 2 事实上是在 对 t 求导, 而不是对 x 求导 (可能后续将偏导的时候会再讲到这个)
        * $\frac{dy}{dx}=2t\Rightarrow \frac{d^2y}{dx^2}=\frac{d(\frac{dy}{dx})}{dx}=\frac{d(2t)}{dx} $
          * $=\frac{\frac{d(2t)}{dt}}{\frac{dx}{dt}}=\frac{2}{\frac{1}{1+t^2}}=2(1+t^2)$
    * 2
      * $\begin{cases}x=a(t-sint)\\y=a(1-cost) \end{cases} (a>0) 确定 y=f(x), 求 \frac{d^2y}{dx^2}$
      * 解:
        * $\frac{dy}{dx}=\frac{dy/dt}{dx/dt}=\frac{asint}{a(1-cost)}=\frac{sint}{1-cost}$
        * $\frac{d^2y}{dx^2}=\frac{d(\frac{dy}{dx})}{dx}=\frac{d(\frac{sint}{1-cost})}{dx}=\frac{d(\frac{sint}{1-cost})/dt}{dx/dt}$
        * $=\frac{(\frac{sint}{1-cost})'}{a(1-cost)}=\frac{1}{a(1-cost)}\cdot \frac{cost\cdot (1-cost)-sin^2t}{(1-cost)^2}$

### 第五节 微分

* 导入
  * 例子
    * 1
      * $y=x^2, x_0=2, \to x=2+\Delta x , 求 \Delta y$
      * 解:
        * $\Delta y = y(2+\Delta x)-y(2)=(2+\Delta x)^2-2^2=4\Delta x + (\Delta x)^2$
        * $\because (\Delta x)^2=o(\Delta x)$
        * $\therefore \Delta y = 4\Delta x+o(\Delta x)$, 其中 $4\Delta x$ 为主要值, $o(\Delta x)$ 为次要值
    * 2
      * $v=\frac{4}{3}\pi r^3, r_0=2, r=2+\Delta r, \Delta v = ?$
      * 解: 
        * $\Delta  v= v(2+\Delta r)-v(2)$
        * $=\frac{4\pi}{3}(2+\Delta r)^3-\frac{4}{3}\pi\cdot 2^3$
        * $=\frac{4\pi}{3}[(2+\Delta r)^3-2^3]$
        * $=\frac{4\pi}{3}[2^3s+3*4\Delta x +3*2(\Delta r )^2]+(\Delta r )^3-2^3$
        * $=\frac{4\pi}{3} [12\Delta x+6(\Delta r)^2+(\Delta r )^3]$
        * $=16\pi\Delta r+8\pi(\Delta r)^2+\frac{4\pi}{3}(\Delta r)^3$
        * $\because 8\pi (\Delta r)^2+\frac{4\pi}{3}(\Delta r)^3=o(\Delta r)$
        * $\Delta v=16\pi \Delta r +o(\Delta r)$, 其中 $16\pi\Delta r $为主, $o(\Delta r)$ 为次

* 定义

  * $y=f(x) (x\in \mathbb{D}), x_0\in\mathbb{D}, x_0+\Delta x\in \mathbb{D}$

    * $\Delta y= f(x_0+\Delta x)-f(x_0)$
    * if $= A\Delta x+o(\Delta x)$
    * 称 $y=f(x) 在 x=x_0 可微, 称 A\Delta x 为 y=f(x) 在 x=x_0 的微分$, 记 $dy|_{x=x_0}, 即$
    * $dy|_{x=x_0},=A\Delta x\triangleq adx$

  * Note: 

    1. 可导 $\Leftrightarrow$ 可微

       * 证明
         * $"\Rightarrow" $
           * $设 lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=f'(x_0)$
           * $\Rightarrow \frac{\Delta y}{\Delta x}=f'(x_0)+\alpha, 其中 \alpha\to 0(\Delta x\to 0)$
           * $\Rightarrow \Delta y=f'(x_0)\Delta x+\alpha\Delta x$
           * $\because lim_{\Delta x\to 0}\frac{\alpha\Delta x}{\Delta x}=lim_{\Delta x \to 0}\alpha -0, \therefore \alpha \Delta x=o(\Delta x),$
           * $\therefore \Delta = f'(x_0)\Delta x+o(\Delta x)$
           * 即 $y=f(x) 在 x=x_0 可微$
         * $\Leftarrow$
           * 设 $\Delta y = A\Delta x+ o(\Delta x)$
           * $\Rightarrow \frac{\Delta y}{\Delta x}=A+\frac{o(\Delta x)}{\Delta x}$
           * $lim_{\Delta x\to 0}\frac{\Delta y}{\Delta x}=A , 即 f'(x_0)=A$
           * $\therefore y=f(x) 在 x=x_0 可导, 且 A=f'(x_0)$

    2. $y=f(x), x=x_0, If \Delta y =A\Delta x+o(\Delta x), 则 A=f'(x_0)$

    3. $y=f(x), x=x_0, If \Delta y = A\Delta x + o(\Delta x), 则 dy|_{x=x_0}=f'(x_0)dx$

       * $若 y=f(x) 可导, 则 dy = df(x)=f'(x)dx$
       * 如: 
         * $d(x^3)=(x^3)'dx=3x^2dx$
         * $d(e^{3x})=3\cdot e^{3x}dx$
         * $x^2dx=d(\frac{1}{3}x^3+C)$
         * $\frac{1}{1+x^2}dx=d(arctanx+C)$

       * 例子: 

         * 1

           * $y=ln(1+x^2), dy|_{x=3}=?$
           * 解: 
             * $y'=\frac{1}{1+x^2}\cdot 2x=\frac{2x}{1+x^2}$
             * $y'|_{x=3}=\frac{6}{10}=\frac{3}{5}$
             * $\therefore dy|_{x=3}=y'(3)dx=\frac{3}{5}dx$

         * 2

           * $y=sin^2(3x+2), 求 dy$
           * 解:
             * $y'=2sin(3x+2)\cdot cos(3x+2)\cdot 3=3sin(6x+4)$
             * $\therefore dy=y'dx=3sin(6x+4)dx$

         * Note:

           1. $若 y=f(x) 在 x=x_0 可微, \Delta y = f'(x_0)\Delta x+o(\Delta x)$

              * $dy|_{x=x_0}=f'(x_0)\Delta x$

              * $\Rightarrow \Delta y -dy = o(\Delta x)$

           2. $设 y=f(x) 在 x=x_0  可微$

              * $dy=f'(x_0)\Delta x = tan\alpha\Delta x$ 
              * $f'(x_0) 为 y=f(x) 在 x=x_0 对应切线斜率$
              * $f'(x_0)=k=tan\alpha$
              * 这阐明了 微分和导数的区别.

* 微分工具
  1. 公式
     1. $d(c)=(c)'dx=0;$
     2. $d(x^a)=(x^a)'dx=ax^{a-1}dx;$
     3. $d(a^x)=(a^x)'dx=a^xlnadx;$
     4. $d(log_ax)=(log_ax)'dx=\frac{1}{xlna}dx$
     5. 三角函数求微分
        1. $d(sinx)=cosxdx$
        2. $d(cosx)=-sinxdx$
        3. $d(tanx)=sec^2xdx$
        4. $d(cotx)=-csc^2xdx$
        5. $d(secx)=secxtanxdx;$
        6. $d(cscx)=-cscxcotxdx$
     6. 反三角函数求微分
        1. $d(arcx)=\frac{1}{\sqrt{1-x^2}}dx,$
        2. $d(arccosx)=-\frac{1}{\sqrt{1-x^2}}dx$
        3. $d(arctanx)=\frac{1}{1+x^2}dx$
        4. $d(arccotx)=-\frac{1}{1+x^2}dx$
  2. 四则
     1. $(u\pm v)'=u'\pm v'\Leftrightarrow d(u\pm v)=du\pm dv$
     2. $(uv)'=u'v+uv' \Leftrightarrow d(uv)=vdu+udv$
     3. $(\frac{u}{v})'=\frac{u'v-uv'}{v^2}\Leftrightarrow d(\frac{u}{v})=\frac{vdu-udv}{v^2}$
  3. 复合 $y=f(u)$
     * case1: 
       * u 为自变量
         * $dy=f'(u)du;$
     * case2: 
       * $u = \varphi (x), y=f[\varphi(x)]$
         * $\frac{dy}{dx}=f'[\varphi(x)]\cdot \varphi'(x)$
         * $\Rightarrow = dy = f'[\varphi (x)]\varphi'(x)dx=f'[\varphi(x)]\cdot d[\varphi(x)]$
         * $=f'(u)du$ - 一阶微分形式不变 性
  4. 例子: 
     * 1
       * $y=sin(3x+2), dy$
       * 解: 
         * 法一
           * $y'=3cos(3x+2)$
           * $dy=3cos(3x+2)dx$
         * 法二
           * 令 $3x+2=u, y=sinu$
           * $dy=f'(u)du=cosu\cdot du$
           * $=cos(3x+2)\cdot d(3x+2)$
           * $=3cos(3x+2)dx$
     * 2
       * $y=e^{x^2}, 求 dy$
       * 解
         * 法一
           * $y'=2xe^{x^2},$
           * $dy=2xe^{x^2}dx$
         * 法二: 
           * $令 x^2=u, y=e^u$
           * $dy=f'(u)du = e^u\cdot du$
           * $=e^{x^2}\cdot d(x^2)=2xe^{x^2}dx$

* 近似计算

  * 设 $y=f(x) 在 x=x_0 可微$
  * $\Delta y = f(x_0+\Delta x)-f(x_0)=f'(x_0)\Delta x+o(\Delta x)$
  * $\Rightarrow \Delta y \approx f'(x_0)\Delta x$
  * $\Rightarrow f(x_0+\Delta x)\approx f(x_0) + f'(x_0)\Delta x$
  * 或 $f(x)-f(x_0)\approx f(x_0)+f'(x_0)(x-x_0)$
  * $\Rightarrow f(x) \approx f(x_0)+f'(x_0)(x-x_0)$

  * 例题
    * 1
      * 求 $sin30度 30 分 的近似值$
      * 解
        * $f(x)=sinx, x_0=\frac{\pi}{6}, \Delta x = 30'=1/2 度 = \frac{\pi}{360}$
        * $f'(x)=cosx$
        * $\because f(x_0+\Delta x)\approx f(x_0)+f'(x_0)\Delta x$
        * $\therefore sin30度30分 = f(\frac{\pi}{6}+\frac{\pi}{360})\approx f(\frac{\pi}6)+f'(\frac{\pi}{360})=\frac{1}{2}+\frac{\sqrt{3}}{2}\cdot \frac{\pi}{360}$
    * 2
      * $\sqrt{1.04} \approx ?$
      * 解: 
        * $f(x)=\sqrt{x},x_0=1, \Delta x=0.04$
        * $f'(x)=\frac{1}{2\sqrt{x}}$
        * $f(x_0)=1, f'(x_0)=\frac{1}{2}$
        * $\because f(x_0)+\Delta x\approx f(x_0)+f'(x_0)\Delta x$
        * $\therefore \sqrt{1.04}=f(1+0.04\approx f(1)+f'(1)*0.04$
        * $=1+\frac{1}{2}*0.04=1.02$
  * Note: 
    * $x\to 0 时$,
    * $f(x)=f(0+x)\approx f(0)+f'(0)x$
      1. $ ^n\sqrt{1+x}{}\approx1+\frac{x}{n}$
         * $f(x)=^n\sqrt{1+x}{}=(1+x)^\frac{1}{n}$
         * $f'(x)=\frac{1}{n}(1+x)^{\frac{1}{n}-1}*1$
         * $f(0)=1, , f'(0)=\frac{1}{n}$
         * $f(x)\approx f(0)+f'(0)x = 1+\frac{1}{n}x$
      2. $e^x\approx 1+x$
         * $f(x)=e^x, f'(x)=e^x$
         * $f(0)=1, f'(0)=1$
         * $f(x)\approx f(0)+f'(0)x=1+x$
      3. $ln(1+x)\approx x$ 
