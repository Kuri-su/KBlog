# Prof. Andrew Ng ML 2014 Course Summary Note

[TOC]

## L1 Introduction

// skip note

## L2 Linear Regression with One Variable

* question category
  * Regression problem (回归问题)
  * Classification problem (分类问题)
* symbol introduction
  * $m$ : number of training examples
  * $x$ : "input" variable/features
  * $y$ : "output" variable | "target" variable
  * $(x,y)$ : single training example
  * $(x^{(i)},y^{(i)})$ : $i^{th}$ training example (i row example)
* **hypothesis** (假设函数) <u>in one variable linear regression</u>
  * $h_\theta(x)=\theta_0+\theta_1 x$
    * $\theta$ : model parameters (constant)
* linear regression (线性回归)
  * univariate/one variable linear regression (单一变量线性回归)
* **Cost functions** (损失函数/代价函数) <u>in one variable linear regression</u>
  * $\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)}),y^{(i)})^2 ,\ \ minimize$
    * A.K.A. Squared error cost function (平方误差函数)
  *  def $J(\theta_0,\theta_1)=\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)}),y^{(i)})^2$
  * want minimize $J(\theta_0,\theta_1)$
* **Gradient descent - (local optimum question)**(梯度下降) 
  * Have some function $J(\theta_0,\theta_1) $or $J(\theta_0,\theta_1,\theta_2, ... , \theta_n)$, want $min_{\theta_0,\theta_1}J(\theta_0,\theta_1)$ or $min_{\theta_0,\theta_1}J(\theta_0,\theta_1,...,\theta_n)$
  * outline: 
    * start with some $\theta_0, \theta_1$
    * keep changing $\theta_0, \theta_1$ to reduce $J(\theta_0, \theta_1)$, until we hopefully end up at a minimum.
  * **Algorithm**: 
    * repeat until convergence: 
      * $\theta_j:=\theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta_0,\theta_1) , ($ for $j=0$ and $j=1$)
        * symbol description: 
          * $\alpha$ : learning rate (学习率/步长)
    * code form
      * $tmp0:=\theta_0-\alpha\frac{\vartheta}{\vartheta\theta_0}J(\theta_0,\theta_1)$
      * $tmp1:=\theta_1-\alpha\frac{\vartheta}{\vartheta\theta_1}J(\theta_0,\theta_1)$
      * $\theta_0:=tmp0$
      * $\theta_1:=tmp1$
  * about $\alpha$
    * If $\alpha$ is too small , gradient descent can be slow.
    * If $\alpha$ is too large, gradient descent can overshoot the minimum, It way fail to converge , or even diverge.
  * but as gradient descent runs, you will automatically take smaller and smaller steps. As we approach a local minimum, gradient descent will automatically take smaller steps. So, no need to decrease $\alpha$ over time.

* **Gradient descent for linear regression** (Put together gradient descent and the squared error cost function)
  * repeat until convergence: 
    * $\theta_j:=\theta_j - \alpha \frac{\partial}{\partial \theta_j}J(\theta_0,\theta_1) , $ (for $j=0$ and $j=1$) $(*)$
  * $J(\theta_0,\theta_1)=\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2$  $(**)$
  * Linear Regression Model
    * $h_\theta(x)=\theta_0+\theta_1 x$
  * So, put $(**)$ into $(*)$, we can got this
    *  $\theta_0,j=0: \frac{\vartheta}{\vartheta \theta_0}J(\theta_0,\theta_1)=\frac{\vartheta}{\vartheta \theta_0}(\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2) $
      * Let $f(u)=\frac{1}{2m} \sum\limits_{i=1}^{m}(u)^2, u(\theta_0)=h_\theta(x^{(i)})-y^{(i)})$
      * use **the Chain rule**, $f(u(\theta_0))'=f'[u(\theta_0)] \cdot u'(\theta_0)$
      * So,$\frac{\vartheta}{\vartheta\theta_0}(\frac{1}{2m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2) = \frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})\cdot  \frac{\vartheta}{\vartheta \theta_0}(h_\theta(x^{(i)})-y^{(i)})$
      * $= \frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})\cdot  \frac{\vartheta}{\vartheta \theta_0}(\theta_0+\theta_1 x-y^{(i)})= \frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})\cdot  (\frac{\vartheta\theta_0}{\vartheta \theta_0}+ \frac{\vartheta\theta_1x^{(i)}}{\vartheta \theta_0}- \frac{\vartheta y^{(i)}}{\vartheta \theta_0})$
      * then because $\frac{\vartheta\theta_0}{\vartheta \theta_0}$, $ \frac{\vartheta\theta_1x^{(i)}}{\vartheta \theta_0}$,$ \frac{\vartheta y^{(i)}}{\vartheta \theta_0}$ is want to get partial derivative about $\theta_0$ , we can get 
        * $\frac{\vartheta\theta_0}{\vartheta \theta_0} =1$
        * $ \frac{\vartheta\theta_1x^{(i)}}{\vartheta \theta_0}=0$
        * $ \frac{\vartheta y^{(i)}}{\vartheta \theta_0}=0$
      * that mean $\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})\cdot  \frac{\vartheta}{\vartheta \theta_0}(h_\theta(x^{(i)})-y^{(i)}) = 1 $,  
      * so $\theta_0, j=0:\frac{\vartheta}{\vartheta \theta_0}J(\theta_0,\theta_1)=\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})$ 
    * $\theta_1,j=1:\frac{\vartheta}{\vartheta \theta_1}J(\theta_0,\theta_1)=\frac{\vartheta}{\vartheta \theta_1}(\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2) $
      * at the same way , we can got $\frac{\vartheta}{\vartheta \theta_1}(\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2)=\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})\cdot  (\frac{\vartheta\theta_0}{\vartheta \theta_1}+ \frac{\vartheta\theta_1x^{(i)}}{\vartheta \theta_1}- \frac{\vartheta y^{(i)}}{\vartheta \theta_1})$
        * $\frac{\vartheta\theta_0}{\vartheta \theta_1} =0$
        * $ \frac{\vartheta\theta_1x^{(i)}}{\vartheta \theta_1}=x^{(i)}$
        * $ \frac{\vartheta y^{(i)}}{\vartheta \theta_1}=0$
      * $\theta_1,j=1: \frac{\vartheta}{\vartheta \theta_1}J(\theta_0,\theta_1)=\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)}),y^{(i)})\cdot x^{(i)}$
  * This method is called  **"Batch" Gradient Descent**.
    * **"Batch": Each step of gradrent descent uses all the training examples**
  * In the future , used **normal equations methods** (正规方程组方法) can directly find the minimum value of $J$, without the multi-step gradient descent.

## L3 Linear Algebra Review 

// moved to tail 

## L4 Linear Regression with Multiple Variables

* L4-1 **Multiple features** (variables)
  * Notation: 
    * $n$ : number of features
    * $x^{(i)}$ : input (features) of $i^{th}$ training example
    * $x^{(i)}_j$ : value of feature $j$ in $i^{th} training example$
  * In this Lesson, there have been some changes to the **hypothesis** , **cost function** and **gradient descent**.
  *  **Hypothesis**
    * Previously: $h_\theta (x)=\theta_0+\theta_1 x$
    * Now: $h_\theta(x)=\theta_0+$

## L5 Octave/Matlab Tutorial

// skip

## L6

## L7



## L16

// unlearned

## L17

// unlearned

## L18 Application Example: Photo OCR

## L19 Conclusion

// skip

## L3 Linear Algebra Review 

// TODO

## ref

* https://www.coursera.org/learn/machine-learning
* https://scruel.gitee.io/ml-andrewng-notes/
* http://www.ai-start.com/ml2014/
* https://github.com/SrirajBehera/Machine-Learning-Andrew-Ng
* https://cs229.stanford.edu/lectures-spring2022/main_notes.pdf





这个问题似乎是在问线性回归中如何得到梯度下降的更新规则。我们需要首先明确，这里的损失函数 $J(\theta_0,\theta_1)$ 是均方误差函数，然后 $h_\theta(x)$ 是线性回归的假设函数。

公式 (*) 是梯度下降的更新规则，其中 $\alpha$ 是学习率，$J(\theta_0,\theta_1)$ 是损失函数，$\frac{\partial}{\partial \theta_j}J(\theta_0,\theta_1)$ 是损失函数对参数 $\theta_j$ 的偏导数。

公式 (**) 是均方误差损失函数，我们可以看到其实是对所有样本误差的平方和的平均。

$h_\theta(x)=\theta_0+\theta_1 x$ 是假设函数，用于对输入 $x$ 做预测。

对于 $\theta_0$，我们需要计算损失函数对 $\theta_0$ 的偏导数：

$\frac{\partial}{\partial \theta_0}J(\theta_0,\theta_1)=\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})$

这个偏导数实际上就是预测值 $h_\theta(x^{(i)})$ 与实际值 $y^{(i)}$ 之间差值的平均。所以，将这个偏导数代入到公式 (*) 中，就可以得到梯度下降的更新规则：

$\theta_0:=\theta_0 - \alpha \frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})$ 

这就是为什么我们能得到这样的更新规则。这个过程就是在通过梯度下降的方式不断更新参数，以最小化损失函数，进而找到一组能最好地拟合数据的参数。



这是一个很好的问题，关键在于理解链式求导法则（chain rule）。

首先，我们看损失函数 $J(\theta_0,\theta_1)$：
$$
J(\theta_0,\theta_1)=\frac{1}{2m} \sum\limits_{i=1}^{m}(h_\theta(x^{(i)}) - y^{(i)})^2
$$

这里 $(h_\theta(x^{(i)}) - y^{(i)})^2$ 是平方函数，而其内部的部分 $(h_\theta(x^{(i)}) - y^{(i)})$ 可以看做是一个关于 $\theta_0$ 的函数（因为 $h_\theta(x^{(i)}) = \theta_0+\theta_1 x^{(i)}$）。那么，我们可以用链式法则来计算偏导数。

链式法则就是对复合函数的求导法则，其基本形式是：
$$
\frac{df(g(x))}{dx} = \frac{df(g(x))}{dg} \cdot \frac{dg(x)}{dx}
$$

用链式法则，我们可以得到：
$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})^2 = 2(h_\theta(x^{(i)}) - y^{(i)}) \cdot \frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})
$$

由于 $h_\theta(x^{(i)}) = \theta_0+\theta_1 x^{(i)}$，所以
$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)}) = 1
$$

所以：
$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})^2 = 2(h_\theta(x^{(i)}) - y^{(i)})
$$

最后，我们求和并除以 $2m$，就得到了最后的结果：
$$
\frac{\partial}{\partial \theta_0}J(\theta_0,\theta_1)=\frac{1}{m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})
$$

在这个过程中，关键就是理解链式法则。它让我们可以分步骤对复合函数求导，先对外部函数求导，然后再对内部函数求导，最后将结果相乘。

---



对不起，如果我没有清楚地解释这个过程。在这个情况下，我们实际上使用了链式法则来求解复合函数的导数。具体如下：

对于一个关于 $\theta_0$ 的复合函数，我们有 $(h_\theta(x^{(i)}) - y^{(i)})^2$。这个复合函数可以被看做是两个函数的组合，即外部函数是 $f(u)=u^2$，内部函数是 $u = h_\theta(x^{(i)}) - y^{(i)}$。我们想要求解这个复合函数关于 $\theta_0$ 的导数。

使用链式法则，我们首先对外部函数 $f(u)$ 求导得到 $2u$，然后对内部函数 $u$ 求导得到 $\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})$。然后我们将这两个导数相乘，得到了复合函数的导数，即：

$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})^2 = 2(h_\theta(x^{(i)}) - y^{(i)}) \cdot \frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})
$$

在这里，$\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})$ 是 $1$，因为 $h_\theta(x^{(i)}) = \theta_0 + \theta_1 x^{(i)}$ 相对于 $\theta_0$ 的导数为 $1$。

所以最后我们得到：

$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})^2 = 2(h_\theta(x^{(i)}) - y^{(i)})
$$

这就是链式法则在这个求导过程中的应用。希望这个解释更清楚一些。

---

$\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})$ 是 $1$，因为我们这里在求解关于 $\theta_0$ 的偏导数。这里的 $h_\theta(x^{(i)}) = \theta_0 + \theta_1 x^{(i)}$ 是关于 $\theta_0$ 的线性函数。

在求偏导数时，我们把除了我们关注的变量（这里是 $\theta_0$）以外的所有变量看作常数。所以，对于 $h_\theta(x^{(i)})$ 这个函数，我们看 $\theta_1 x^{(i)}$ 为常数，而 $y^{(i)}$ 也是常数。于是有：

$$
\frac{\partial}{\partial \theta_0}(\theta_0 + \theta_1 x^{(i)}) = 1
$$
和
$$
\frac{\partial}{\partial \theta_0}(y^{(i)}) = 0
$$

所以，我们得到：

$$
\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)}) = 1 - 0 = 1
$$

这就是为什么 $\frac{\partial}{\partial \theta_0}(h_\theta(x^{(i)}) - y^{(i)})$ 等于 $1$。