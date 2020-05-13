
# Mysql 常用函数列举 

主要有以下几类函数 

* [高级函数](#mysql-advanced-functions)
* [数字函数](#mysql-numeric-functions)
* [日期函数](#mysql-date-functions)
* [字符串函数](#mysql-string-functions)

## MySQL Advanced Functions

func|description|exampleLink
-|-|-
case|等价于大部分语言的 `Switch Case`|[link](#case)
if(expr,result1,result2)|与大部分编程语言中的 `if` 大意相同, 如果 `expr` 成立, 结果返回 `v1` , 否则返回 `v2`|[link](#if-expr-result1-result2-)
ifnull(expr,expr2)|如果 `expr` 的值不等于 `null`, 则返回 expr, 否则返回 expr2
isnull(expr)|判断 expr 是否等于 null, 返回 0 和 1
last_insert_id()获取最近生成的 自增长 值|
nullif(expr1,expr2)|如果 expr1 == expr2 ,则日返回 null, 否则返回 expr1
bin(x) / binary(s)| `bin` : 将括号中的值转为二进制编码(`12 => 1100`) <br>`binary`: 将 `字符串` 转为 `二进制字符串`|[link](#bin-x-binary-s-)
cast(x as type)  |转换数据类型|[link](#cast-x-as-type-)
conv(x,h1,h2)|将 x 转换进制 从 h1 到 h2|[link](#conv-x-h1-h2-)

##### case

```sql
select CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
```

#### if(expr,result1,result2)

```sql
select if(expr,result1,result2)
```

#### bin(x) / binary(s)

```sql
select bin(14);
select binary('kurisu');
```  
          
#### cast(x as type)  

```sql
select cast('2019-06-15' as DATE )
```

#### conv(x,h1,h2)
    
```sql
select conv(12,8,2)
```
    
#### 非常用函数

```sql
# 返回参数中的第一个非空表达式 (从左到右)
select coalesce(expr1,expr2,expr3, ... ,exprn)
# 返回服务器的连接数
select connection_id()
# 转换字符集
select convert(expr1 using fontSet)
# 返回当前用户
select current_user()
# 返回当前数据库名字
select database()
# 返回当前用户
select session_user()
# 返回当前用户
select system_user()
# 返回当前用户
select user()
# 返回数据库的版本号
select version()
```

---

## MySQL Numeric Functions
func|description
-|-|-
ABS(x)|返回 x 的绝对值　　
ACOS(x)|求 x 的反余弦值(参数是弧度)
ASIN(x)|求反正弦值(参数是弧度)
ATAN(x)|求反正切值(参数是弧度)
ATAN2(n, m)|求反正切值(参数是弧度)
AVG(expression)|返回一个表达式的平均值，expression 是一个字段
CEIL(x)|返回大于或等于 x 的最小整数　
CEILING(x)|返回大于或等于 x 的最小整数　
COS(x)|求余弦值(参数是弧度)
COT(x)|求余切值(参数是弧度)
COUNT(expression)|返回查询的记录总数，expression 参数是一个字段或者 * 号
DEGREES(x)|将弧度转换为角度　　
n DIV m|整除，n 为被除数，m 为除数
EXP(x)|返回 e 的 x 次方　　
FLOOR(x)|返回小于或等于 x 的最大整数　　
GREATEST(expr1, expr2, expr3, ...)|返回列表中的最大值
LEAST(expr1, expr2, expr3, ...)|返回列表中的最小值
LN|返回数字的自然对数
LOG(x)|返回自然对数(以 e 为底的对数)　　
LOG10(x)|返回以 10 为底的对数　　
LOG2(x)|返回以 2 为底的对数
MAX(expression)|返回字段 expression 中的最大值
MIN(expression)|返回字段 expression 中的最小值
MOD(x,y)|返回 x 除以 y 以后的余数　
PI()|返回圆周率(3.141593）　　
POW(x,y)|返回 x 的 y 次方　
POWER(x,y)|返回 x 的 y 次方　
RADIANS(x)|将角度转换为弧度　　
RAND()|返回 0 到 1 的随机数　　
ROUND(x)|返回离 x 最近的整数
SIGN(x)|返回 x 的符号，x 是负数、0、正数分别返回 -1、0 和 1　
SIN(x)|求正弦值(参数是弧度)　　
SQRT(x)|返回x的平方根　　
SUM(expression)|返回指定字段的总和
TAN(x)|求正切值(参数是弧度)
TRUNCATE(x,y)|返回数值 x 保留到小数点后 y 位的值（与 ROUND 最大的区别是不会进行四舍五入）

---

## MySQL Date Functions

`//TODO`

# MySQL String Functions

`//TODO`