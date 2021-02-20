# [zh-CN] Cryptonote writepaper  

[TOC]

> 目前仅仅包括部分内容, 有翻译不准确或者错误的地方欢迎到 [这里提 Issue 指正](https://github.com/Kuri-su/KBlog)

## 4.2 Definitions (定义)

### 4.2.1 Elliptic curve parameters (椭圆曲线参数)

> As our base signature algorithm we chose to use the fast scheme EdDSA, which is developed and implemented by D.J. Bernstein et al. [18]. Like Bitcoin’s ECDSA it is based on the elliptic curve discrete logarithm problem, so our scheme could also be applied to Bitcoin in future.

作为基础签名算法, 我们选择使用 EdDSA(Edwards-curve Digital Signature Algorithm 爱德华兹曲线数字签名算法)  和 Bitcoin 的 ECDSA (椭圆曲线数字签名算法)一样, EdDSA 也是基于 椭圆曲线离散对数问题, 所以未来 比特币也可以使用 Cryptonote 方案 : )

> Common parameters are:

公共参数如下: 

* $q$ : `一个质数;` a prime number; $q$ = $ 2^{255} $−19;
* $d$ : `Fq 的一个元素`an element of $F_q$ ; $d$ = −121665/121666;
* $E$ : `椭圆曲线方程` an elliptic curve equation; $-x^2 + y^2 = 1 + dx^2y^2$
* $G$ : `一个基点(位于座标轴上)`; a base point; $G=(x,-4/5)$
* $l$ : `基点的素数阶` a prime order of the base point; $l= 2^{252} + 27742317777372353535851937790883648493;$
* $H_s$ : `哈希函数` a cryptographic hash function  $\{0,1\}^∗ \rightarrow F_q $;
* $H_p$ : `确定性哈希函数` a deterministic hash function $E(F_q) \rightarrow E(F_q )$.

### 4.2.2 Terminology (术语)

> Enhanced privacy requires a new terminology which should not be confused with Bitcoin entities.

// TODO

**private ec-key**  is a standard elliptic curve private key: a number $a //TODO$

**public ec-key** is a standard elliptic curve public key: a point $A = aG$;

**one-time key-air** is a pair of private and public ec-keys;

**private user key** is a pair (a,b) of two different private ec-keys;

**tracking key** is a pair (a,B) of private and public ec-key ( where $B=bG $ and $a  b$ // TODO)

**public user key** is a pair (A,B) of two public ec-keys derived from (a,b);

**standard address** is a representation of a public user key given into human friendly string with error correction;

**trucated address** is a representation of the second half (point B) of a public user key given into human friendly string with error correction.

> The transaction structure remains similar to the structure in Bitcoin: every user can choose several independent incoming payments (transactions outputs), sign them with the corresponding private keys and send them to different destinations.



> Contrary to Bitcoin’s model, where a user possesses unique private and public key, in the proposed model a sender generates a one-time public key based on the recipient’s address and some random data. In this sense, an incoming transaction for the same recipient is sent to a one-time public key (not directly to a unique address) and only the recipient can recover the corresponding private part to redeem his funds (using his unique private key). The recipient can spend the funds using a ring signature, keeping his ownership and actual spending anonymous. The details of the protocol are explained in the next subsections.

### 4.3 Unlinkable payments (无法连接的交易)

> Classic Bitcoin addresses, once being published, become unambiguous identifier for incoming payments, linking them together and tying to the recipient’s pseudonyms. If someone wants to receive an “untied” transaction, he should convey his address to the sender by a private channel. If he wants to receive different transactions which cannot be proven to belong to the same owner he should generate all the different addresses and never publish them in his own pseudonym.

// TODO ZH && Img

> We propose a solution allowing a user to publish a single address and receive unconditional unlinkable payments. The destination of each CryptoNote output (by default) is a public key, derived from recipient’s address and sender’s random data. The main advantage against Bitcoin is that every destination key is unique by default (unless the sender uses the same data for each of his transactions to the same recipient). Hence, there is no such issue as “address reuse” by design and no observer can determine if any transactions were sent to a specific address or link two addresses together.

// TODO ZH && Img