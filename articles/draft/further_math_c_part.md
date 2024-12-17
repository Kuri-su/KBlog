# Further Mathematic lecture (tongji) full notes  (C part) cross Jiafeng Tang

[TOC]

## 第五章 定积分

### 第一节 定积分的概念与性质(一) - (引论)

#### 定积分概念引论

* 引子: 一元 不规则

例子1：曲线梯形面积S？

1. $a=x_0<x_1<x_2<...<x_n=b$
   * $[a,b]=[x_0,x_1]\cup[x_1,x_2]\cup...\cup[x_{n-1},x_n]$
   * $\Delta x_1=x_1-x_0, \Delta x_2=x_2-x_1,..., \Delta x_n=x_n-x_{n-1}$
   * $(\Delta x_i=x_i-x_{i-1}, 1\leq i\leq n)$

2. $\forall \xi_i\in[x_{i-1},x_i]$
	* $\Delta S_i \approx f(\xi_i)\Delta x_i \quad (1\leq i\leq n)$
	* $S \approx \sum_{i=1}^n f(\xi_i)\Delta x_i$

3. $\lambda = \max \{\Delta x_1, \Delta x_2, ..., \Delta x_n\}$
	* $S = \lim_{\lambda \to 0} \sum_{i=1}^n f(\xi_i)\Delta x_i$

例2.  $v=v(t)$，$t\in[a,b]$，$S=?$

1. $a=t_0<t_1<t_2<...<t_n=b$,

	* $[a,b]=[t_0,t_1]\cup[t_1,t_2]\cup...\cup[t_{n-1},t_n]$

	* $\Delta t_i=t_i-t_{i-1} \quad (1\leq i\leq n)$

2°. $\forall \xi_i \in [t_{i-1},t_i]$

$\Delta S_i \approx v(\xi_i)\Delta t_i \quad (1 \leq i \leq n)$;

$S \approx \sum_{i=1}^n v(\xi_i)\Delta t_i$;

3°. $\lambda = \max{\Delta t_1, \Delta t_2,...,\Delta t_n}$

$\therefore S = \lim_{\lambda \to 0}\sum_{i=1}^n v(\xi_i)\Delta t_i$

定积分之定义
 设 $f(x)$ 在 $[a,b]$ 上有界。

1°. $a=x_0<x_1<...<x_n=b$, $\Delta x_i=x_i-x_{i-1} \quad (1 \leq i \leq n)$; (分法) 

2°. $\forall \xi_i \in [x_{i-1},x_i]$, $\sum_{i=1}^n f(\xi_i)\Delta x_i$; (取法)

3°. $\lambda = \max{\Delta x_1, \Delta x_2,...,\Delta x_n}$

若 $\lim_{\lambda \to 0}\sum_{i=1}^n f(\xi_i)\Delta x_i$ 存在，且 $f(x)$ 在 $[a,b]$ 上可积， 则称此极限为 $f(x)$ 在 $[a,b]$ 上的定积分，记作 $\int_a^b f(x)dx$。

$\lim_{\lambda \to 0}\sum_{i=1}^n f(\xi_i)\Delta x_i = \int_a^b f(x)dx$

Notes: 

1. $L: y=f(x)\geq 0 \quad (a \leq x \leq b)$     则 $A = \int_a^b f(x)dx$;		$v=v(t) \quad (a \leq t \leq b)$  		则 $S = \int_a^b v(t)dt$

1. $\lim_{\lambda \to 0}\sum_{i=1}^n f(\xi_i)\Delta x_i$ 与 $[a,b]$ 的分割及 $\xi_i$ 取法无关；换句话说, $\lim_{\lambda \to 0}\sum_{i=1}^n f(\xi_i)\Delta x_i$  与 [a,b] 间隔大小的取值 以及 $\xi_i$ 取法无关
3. $f(x)$ 在 $[a,b]$ 上有界不一定可积。如：$f(x)=\begin{cases} 1, & x\in \mathbb{Q} \ , 0, & x\in \mathbb{R}\backslash\mathbb{Q} \end{cases}$




![image-20230515124905994](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124905994.png)

![image-20230515124924200](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124924200.png)

![image-20230515124936951](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515124936951.png)

4. 若 fx 在 区间内连续或只存在有限个第一类间断点, 则在 [a,b] 上可积

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

### 第二节 积分基本公式 - 积分标准计算公式 - 牛顿莱布尼兹公式

![image-20230515130130839](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130130839.png)

![image-20230515130143293](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130143293.png)

![image-20230515130216736](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130216736.png)

![image-20230515130233732](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130233732.png)

![image-20230515130251992](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130251992.png)

![image-20230515130317161](/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230515130317161.png)

积分上限函数

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

## 第六章 定积分的应用

### 第一节 元素法

### 第二节 几何应用

### 第三节 定积分在物理学上的应用

## 第七章 微分方程

### 第一节 基本概念

### 第二节 可分离变量的微分方程

### 第三节 齐次微分方程

### 第四节 一阶线性微分方程

### 第五节 可降阶的高阶微分方程

### 第六节 高阶线性微分方程

<img src="/Users/kurisuamatist/Library/Application Support/typora-user-images/image-20230519130058899.png" alt="image-20230519130058899" style="zoom: 50%;" />

part 3 高阶线性微分方程

### 第七节 常系数齐次线性微分方程

这后面的都没听, 不需要截图了, 晚点练到这里再来听吧

### 第八节 常系数非齐次线性微分方程

### 第九节 欧拉方程

### 第十节 常系数线性微分方程组解法举例

