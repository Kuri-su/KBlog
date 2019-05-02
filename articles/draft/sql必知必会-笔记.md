# sql 必知必会 Note

## TOC
* [SQL](#SQL)
* [DQL 数据查询语句](#)
    * [a]()
* [DML 数据操作语句](#)
* [DDL 数据定义语句](#)

<!--DCL-->

## SQL

SQL Structured Query Language (结构化查询语言)

标准的SQL 由 ANSI 标准委员会 管理,称为 ANSI SQL. 所有的 DBMS 即使有自己的SQL拓展,也都支持ANSI SQL ,但是支持程度各不相同.

## DQL

### SELECT 

SELECT 的用处是从一个表或多个表中 **检索** 信息, 同时也可以和别的语句灵活搭配, 发挥强大的作用

```sql
SELECT prod_name , price
FROM Products;

# 通常不推荐这么写,会影响检索性能,以及占用不必要的带宽
SELECT *
FROM Products;
```

* tips: 
    * 关于 select 数据的排序,在未明确指定的排序的情况下,是未排序的,这个顺序与底层的存储顺序有关
    * SQL 建议加上分号结尾, 增加可读性, 当然, 这并不是强制的
    * SQL 建议上面的例子一样, 在合适的地方换行, 增加可读性
    * SQL 语句是 **不区分大小写** 的, 但是推荐对关键字使用大写, 表名和列名使用小写, 增加可读性. 但无论是使用关键字大写还是关键字小写, 建议全文统一标准

#### DISTINCT

DISTINCT 的用处去去除 SELECT 语句的重复项

```sql
# 将 DISTINCT  关键字放到列名的前面
SELECT DISTINCT vend_id
FROM Products;
```

* tips
    * distinct 关键字将作用于全部的列, 不仅仅是跟在后面的那一列. 指定的列如果不完全相同, 则也会被检索出来

#### LIMIT && OFFSET
`TODO`