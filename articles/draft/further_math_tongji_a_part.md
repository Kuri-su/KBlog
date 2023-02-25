# Further Mathematic (tongji) (A part)

看起来上册的 七章, 基本是 把 高中的 数学从根上重新定义了一次

第一章 , 重新定义 什么时函数, 并 加入极限的概念

第二章, 使用极限来定义导数, 并使用 微分重新定义导数?

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

       1. Sgn 函数, 符号函数

       $$
       y = sgn x =\begin{cases} -1, &  x < 0, \\ 0, &  x = 0, \\ 1, & x > 0. \end{cases}
       $$

       

       2.  狄利克雷 (Dirichlet) 函数
          $$
          f(x) = \begin{cases} 1, & \text{如果 }  x \in \mathbb{Q} \\ 0, & \text{如果 } x \notin \mathbb{Q} \end{cases}
          $$

       3. 取整函数(左取整函数)
          $$
          y= [x] \\
          e.g. [\surd{2}]=1 , [-0.3]=-1, [3]=3
          $$

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
      3. (保号性)















