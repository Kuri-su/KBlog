# [zh-CN] Cryptonote writepaper  

[TOC]

> 目前仅仅包括部分内容, 有翻译不准确或者错误的地方欢迎到 [这里提 Issue 指正](https://github.com/Kuri-su/KBlog)

## 4.2 Definitions

### 4.2.1 椭圆曲线参数

> As our base signature algorithm we chose to use the fast scheme EdDSA, which is developed and implemented by D.J. Bernstein et al. [18]. Like Bitcoin’s ECDSA it is based on the elliptic curve discrete logarithm problem, so our scheme could also be applied to Bitcoin in future.

作为基础签名算法, 我们选择使用 EdDSA(Edwards-curve Digital Signature Algorithm 爱德华兹曲线数字签名算法)  和 Bitcoin 的 ECDSA (椭圆曲线数字签名算法)一样, EdDSA 也是基于 椭圆曲线离散对数问题, 所以未来 比特币也可以使用 Cryptonote 方案 : )

> Common parameters are:

公共参数如下: 

* $q$ : `一个质数;` a prime number; $q$ = $ 2^{255} $−19;
* $d$ : `Fq 的一个元素`an element of $F_q$ ; $d$ = −121665/121666;
* $E$ : `椭圆曲线方程` an elliptic curve equation; $-x^2 + y^2 = 1 + dx^2y^2$
* $G$ : `一个基点(位于座标轴上)`; a base point; $G=(x,-4/5)$
* $l$ : `基点的素数阶` a prime order of the base point; $l= 2^{252} + 27742317777372353535851937790883648493;$ 
* $H_s$ : `哈希函数` a cryptographic hash function  $\{0,1\}^∗ \rightarrow F_q $;
* $H_p$ : `确定性哈希函数` a deterministic hash function $E(F_q) \rightarrow E(F_q )$.

### 4.2.2 术语

> Enhanced privacy requires a new terminology which should not be confused with Bitcoin entities.

// TODO



