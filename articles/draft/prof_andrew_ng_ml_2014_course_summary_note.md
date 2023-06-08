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
  * **Hypothesis**
    * Previously: $h_\theta (x)=\theta_0+\theta_1 x$
    * Now: $h_\theta(x)=\theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3$
      *  $h_\theta(x)=\theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3 + .... + \theta_n x_n$
    * For convenience of notation, **define** $x_0=1, (x^{(i)}_0=1)$
      * Let $x=\begin{bmatrix} x_0 \\ x_1 \\ x_2 \\ . \\ . \\ x_n \end{bmatrix}$  , $\theta=\begin{bmatrix} \theta_0 \\ \theta_1 \\ \theta_2 \\ . \\ . \\ \theta_n \end{bmatrix}$
    *  $h_\theta(x)=\theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3 + .... + \theta_n x_n$
      * $=\theta^T x$
* L4-2 **Gradient descent for multiple variables**
  * Hypothesis: $h_\theta(x)=\theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3 + .... + \theta_n x_n$
  * Parameters: $\theta_0, \theta_1, \theta_2 ,... , \theta_n$, 
  * $\theta $ without subscript means a matrix, n+1 dimension vector
  * Cost function: $J(\theta_0,\theta_1,\theta_2,...,\theta_n)=\frac{1}{2m}\sum\limits_{i=1}^{m}(h_\theta(x^{(i)})-y^{(i)})^2$
  * Gradient descent
    * 


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


