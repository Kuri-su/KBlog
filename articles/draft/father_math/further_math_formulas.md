# Further Math Formulas

[TOC]

## Prepare

### Trigonometric function

* basic
  * $sin^2x+cos^2x=1$ 
  * $secx=\frac{1}{cosx}$
  * $cscx=\frac{1}{sinx}$
  * $sec^2x=1+tan^2x$ , $tan^2x=sec^2x-1$
  * $csc^2x=1+cot^2x$
  * $tanx=\frac{sinx}{cosx}$
  * $sinx=\frac{tanx}{cosx}$
  * $tan\frac{\pi}{4}=1$
  * $sinx=-sin(x+\pi)$
  * $sin\frac{\pi}{2}=1$
  * $sec\frac{\pi}{4}=\sqrt{2}$
  * $secx=hypotenuse/adjacent=\frac{1}{cosx}$, ($c/a$)
  * $cscx= hypotenuse/opposite=\frac{1}{sinx}$, ($c/b$)
  * $cotx=adjacent/opposite=\frac{1}{tanx}$, ($a/b$)
* Double-angle formulas (Power-up formulas)
  * $\sin 2x = 2\sin x \cos x$
  * $\cos 2x = \cos^2 x - \sin^2 x = 2\cos^2 x - 1 = 1 - 2\sin^2 x$
  * $\tan 2x = \frac{2\tan x}{1-\tan^2 x}$
* Half-angle formulas 
  * $\sin \frac{x}{2} = \pm\sqrt{\frac{1-\cos x}{2}}$
  * $\cos \frac{x}{2} = \pm\sqrt{\frac{1+\cos x}{2}}$
* Addition and subtraction formulas
  * $\sin(\alpha \pm \beta) = \sin \alpha \cos \beta \pm \cos \alpha \sin \beta$
  * $\cos(\alpha \pm \beta) = \cos \alpha \cos \beta \mp \sin \alpha \sin \beta$
  * $\tan(\alpha \pm \beta) = \frac{\tan \alpha \pm \tan \beta}{1 \mp \tan \alpha \tan \beta}$
* Sum-to-product formulas
  * $\sin \alpha + \sin \beta = 2\sin \frac{\alpha + \beta}{2} \cos \frac{\alpha - \beta}{2}$
  * $\sin \alpha - \sin \beta = 2\cos \frac{\alpha + \beta}{2} \sin \frac{\alpha - \beta}{2}$
  * $\cos \alpha + \cos \beta = 2\cos \frac{\alpha + \beta}{2}\cos \frac{\alpha - \beta}{2}$
  * $\cos \alpha - \cos \beta = -2\sin \frac{\alpha + \beta}{2}\sin \frac{\alpha - \beta}{2}$
* Product-to-sum formulas
  * $\sin \alpha \cos \beta = \frac{1}{2}[\sin(\alpha + \beta) + \sin(\alpha - \beta)]$
  * $\sin \alpha \sin \beta = -\frac{1}{2}[\cos(\alpha + \beta) - \cos(\alpha - \beta)]$
  * $\cos \alpha \cos \beta = \frac{1}{2}[\cos(\alpha + \beta) + \cos(\alpha - \beta)]$

### Logarithm

* $lnx=log_ex$
* $ln'x=\frac{1}{x}$
* $log'_ax=\frac{1}{xlna}$
* $a^b=e^{b*ln(a)}$
* $log_ab=\frac{ln(b)}{ln(a)}$
* $ln(ab)=ln(a)+ln(b)$
* $ln(a/b)=ln(a)+-ln(b)$
* $ln(a^n)=nln(a)$

### Others

* $(x+y)^n=C^n_0 x^ny^0+C^n_1 x^{n-1}y^1+C^n_2 x^{n-2}y^2+...+C^n_{n-1} x^{1}y^{n-1}+C^n_n x^0y^n$
* $C^n_k=\frac{n!}{k!(n-k)!}, $
  * $e.g. C^{49}_{6}=\frac{49!}{6!43!}$
* quadratic formula (一元二次求根公式)
  * $if \Delta>0,x_{1,2}=\frac{-b\pm i\sqrt{b^2-4ac}}{2a}$
  * $if \Delta=0, x_{1,2}=-\frac{b}{2a}$
  * $if \Delta <0, x_{1,2}=\frac{-b\pm i\sqrt{4ac-b^2}}{2a} $, but is $\mathbb{C}$ (复数)
* parity check
  * Even function * Odd function = Odd function
  * Even function * Even function = Even function
  * Odd function * Odd function = Even function
  * Even function' = Odd function
  * Odd function' = Even function
  * Even function / Odd function = Odd function
  * Odd function / Even function = Odd function
  * 1/Odd function = Odd function
  * $1/Even function = Even function
  * btw
    * Odd function :  $g(-t)=-g(t)$
    * Even function : $g(-t)=g(t)$
* inequality
  * $||b|-|a|| \leq |b-a| \leq |a|+|b|$
  * $a^2+b^2 \geq 2ab$ or $|ab|\leq \frac{a^2+b^2}{2}$
    * if $a_i\geq 0 (i=1,2,...,n)$, then $\frac{a_1+a_2+a_3+...+a_n}{n}\geq \sqrt[n]{a_1a_2a_3....a_n}$
  * $Assume \ a_i,b_i(i=1,2,...,n)$, then
    * $(a_1b_1+a_2b_2+....+a_nb_n)^2\leq (a_1^2+a_2^2+....+a_n^2)(b_1^2+b_2^2+....+b_n^2)$
* sequence
  * $(x+1)^n=x^n+nx^{n-1}+...+1$
* Partial Fraction Decomposition
  * $\frac{k}{(ax+b)(ax+c)}=\frac{A}{(ax+b)}+\frac{B}{(ax+c)}$

* Circle
  * $x^2+y^2=c$
  * oval
    * $\frac{x^2}{a^2}+\frac{y^2}{b^2}=c$,
    * $Ax^2+By^2+Cx+Dy+E=0$
    *  if a=b, then this oval is a ture circle


## Limits

### Important limits
> Tips: 
>
> 1. $x\to inf$ 时, 可以考虑用 1/x 化为0以化简
> 2. $e^\frac{1}{x}, $
>    *  $if\ x\to0^+, e^\frac{1}{x}= \inf$ 
>    *  $if\ x\to0^-, e^\frac{1}{x}= 1 $ 

1. $lim_{x\to0}(1+x)^{\frac{1}{x}}=e$
   * normally, $lim_{\Delta\to0}(1+\Delta)^{\frac{1}{\Delta}}=e$, also , it can use to infinity situations, the important thing is $\Delta \to 0$
2. $lim_{x\to0}{\frac{sinx}{x}}=1$, 
   * because sinx and x are equivalent infinitesimals.


### Equivalent infinitesimals

> Tips: 
>
> 安全的使用等价无穷小的条件: 
>
> 1. 仅在乘除重使用
> 2. 保留足够高阶的项
>
> 这里列出的结论大多只是泰勒展开第一阶的结论, 仅仅做参考, 谨慎使用, 直接相减会造精度不够, 答案有误差, 
>
> 如果实在不知道怎么解就直接泰勒展开

1. $x\sim sinx\sim tanx\sim arcsinx \sim arctanx \sim ln(1+x) \sim e^x-1 $
2. $1-cosx \sim \frac{1}{2}x^2$
3. $(1+x)^a-1 \sim ax\ (a\ne0)$
4. $ln(1+2x)\sim 2x$
5. 
