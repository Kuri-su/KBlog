# Further Mathematic lecture (tongji) (A part) cross Jiafeng Tang

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
      * 

![image-20230411183058481](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411183058481.png)

![image-20230411183125825](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411183125825.png)

### 第一节 微分中值定理 (part B)

#### Largrange

* ⭐️ Lagrange 中值定理
  * 定理
    * 当 如下条件同时满足的时候, 式子$\exists \xi (a,b), 使 f'(\xi) = \frac{f(b)-f(a)}{b-a}$, 成立 
      1. $f(x)\in C[a,b]$
      2. $f(x) 在 (a,b) 内可导$
         1. 闭区间内可导
    * 可以看到 Lagrange 中值定理 比 Rolle 中值定理少了 $f(a)=f(b) $ 的限制, 所以 Rolle 是 Lagrange 中值定理的 一种特殊情况

![image-20230411183808686](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411183808686.png)

![image-20230411183853121](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411183853121.png)

![image-20230411183920384](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411183920384.png)

![image-20230411184009818](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184009818.png)

![image-20230411184126770](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184126770.png)

![image-20230411184201325](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184201325.png)

![image-20230411184421669](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184421669.png)

![image-20230411184455478](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184455478.png)

![image-20230411184521958](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184521958.png)

#### Canchy

* ⭐️ Canchy 中值定理
  * 定理: 当 如下条件成立时, 公式 $\exists \xi \in (a,b) , 使 \frac{f(b)-f(a)}{g(b)-g(a)}=\frac{f'(\xi)}{g'(\xi)}$ 成立
    1. $f(x), g(x) \in C[a,b]$
    2. $f(x),g(x) 在 (a,b) 内可导$
    3. $g'(x)\ne 0 (a<x<b)$
       * 这个是比 Lagrange 多的内容
  * 

![image-20230411184713789](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184713789.png)

![image-20230411184733473](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184733473.png)

![image-20230411184909042](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184909042.png)

![image-20230411184950482](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411184950482.png)

![image-20230411185016133](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185016133.png)

![image-20230411185043692](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185043692.png)

![image-20230411185121384](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185121384.png)

![image-20230411185223117](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185223117.png)

![image-20230411185245233](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185245233.png)

![image-20230411185350488](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185350488.png)

![image-20230411185428250](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230411185428250.png)

### 第二节 罗必达法则

![image-20230412182536643](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182536643.png)

![image-20230412182614883](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182614883.png)

* .

#### $\frac{0}{0} $型

* 定理: 
  1. $\frac{0}{0} 型$
     * 若函数满足如下条件, 则 $lim_{x\to a}\frac{f(x)}{F(x)}=A$
       * 1. $f(x), F(x) 在 x=a 的 去心邻域 内 可导 且 F'(x) \ne 0$
         2. $lim_{x\to a}f(x)=0, lim_{x\to a}F(x)=0;$
         3. $lim_{x\to a}\frac{f'(x)}{F'(x)}=A$
     * 

![image-20230412132126079](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412132126079.png)

![image-20230412182653835](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182653835.png)

![image-20230412182705785](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182705785.png)

![image-20230412182726139](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182726139.png)

![image-20230412182820288](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182820288.png)

![image-20230412182852599](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182852599.png)

![image-20230412182751196](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412182751196.png)

再次详细解释证明过程

![image-20230412183041192](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183041192.png)

![image-20230412183057872](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183057872.png)

![image-20230412183111442](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183111442.png)

![image-20230412183124918](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183124918.png)

![image-20230412183138510](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183138510.png)

#### $\frac{\infty}{\infty }$型

![image-20230412183152824](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183152824.png)

![image-20230412183210923](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183210923.png)

![image-20230412183225236](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183225236.png)

![image-20230412183237399](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183237399.png)

![image-20230412183252315](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183252315.png)

![image-20230412183318926](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183318926.png)

![image-20230412183333195](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183333195.png)

![image-20230412183349054](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183349054.png)

![image-20230412183401531](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183401531.png)

![image-20230412183420369](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183420369.png)

![image-20230412183440995](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230412183440995.png)

### 第三节 泰勒公式 Taylor

![image-20230425152354682](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152354682.png)

![image-20230425152414209](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152414209.png)

>  在分数上下阶次相同的时候使用等价无穷小是相对安全的

![image-20230425152445055](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152445055.png)

![image-20230425152541110](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152541110.png)

![image-20230425152607372](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152607372.png)

![image-20230425152633001](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152633001.png)

![image-20230425152712674](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152712674.png)

![image-20230425152736899](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152736899.png)

![image-20230425152759755](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152759755.png)

麦克劳林公式是解决 $\frac{0}{0}$ 型的优秀方法, 

![image-20230425152845663](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152845663.png)

![image-20230425152902108](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152902108.png)

![image-20230425152914864](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152914864.png)

![image-20230425152932329](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152932329.png)

![image-20230425152943959](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152943959.png)

![image-20230425152957748](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425152957748.png)

![image-20230425153022117](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153022117.png)

![image-20230425153044216](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153044216.png)

![image-20230425153105379](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153105379.png)

![image-20230425153123467](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153123467.png)

![image-20230425153136169](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153136169.png)

![image-20230425153200586](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153200586.png)

![image-20230425153216843](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153216843.png)

### 第四节 函数单调性 与 曲线的凹凸性

![image-20230425153311528](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153311528.png)

![image-20230425153326456](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153326456.png)

![image-20230425153347700](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153347700.png)

![image-20230425153409583](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153409583.png)

![image-20230425153428956](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153428956.png)

![image-20230425153551896](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153551896.png)

![image-20230425153610670](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153610670.png)

![image-20230425153633952](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153633952.png)

![image-20230425153702700](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153702700.png)

![image-20230425153721348](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153721348.png)

![image-20230425153737218](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153737218.png)

![image-20230425153759453](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153759453.png)

#### 曲线凹凸性

![image-20230425153905220](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153905220.png)

![image-20230425153920478](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153920478.png)

![image-20230425153938181](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425153938181.png)

![image-20230425164424534](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164424534.png)

![image-20230425164450769](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164450769.png)

![image-20230425164503575](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164503575.png)

![image-20230425164524479](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164524479.png)

![image-20230425164555885](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164555885.png)

![image-20230425164615754](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164615754.png)

![image-20230425164634487](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164634487.png)

![image-20230425164652088](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230425164652088.png)

![image-20230427182239604](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182239604.png)

![image-20230427182259389](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182259389.png)

![image-20230427182319550](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182319550.png)



### 第五节 极值与最值

$0<|x-x_0|<\delta $ 叫做 $x_0$的 去心邻域

![image-20230427182417619](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182417619.png)

![image-20230427182434116](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182434116.png)

![image-20230427182449487](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182449487.png)

![image-20230427182511263](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182511263.png)

![image-20230427182522350](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182522350.png)

![image-20230427182539572](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182539572.png)

![image-20230427182556061](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182556061.png)

![image-20230427182612514](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230427182612514.png)

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



## 第四章 不定积分

### 第一节 不定积分的概念与性质

### 第二节 积分方法-换元积分法(一) 

### 第二节 积分方法-换元积分法(二) 

### 第三节 分部积分法

## 第五章 定积分

### 第一节 定积分的概念与性质(一)

### 第一节 定积分的概念与性质(二)

### 第二节 基本公式
