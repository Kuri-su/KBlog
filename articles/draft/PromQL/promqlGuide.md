# PromQL Guide

[TOC]

这篇文章的面向群体是 还不太了解 PromQL 和 想要开始使用的 PromQL 的人群.

PromQL 全称  Prometheus Query Language, 是在 Prometheus 上使用的 DSL . 那么既然是 DSL , 那么就会有一些格式规定

\# 文档翻译系列 XD

## Format 格式

一个 PromQL 语句可以由 如下几个部分组成

* metrics 指标名
* labels 
* 运算符和关键字
* 常量
* 时间范围选择器

// TODO

然后在 一个 PromQL 在运算完之后, 有四种可能的输出

* 瞬时向量
  * 某一个瞬时查询到的全部数据
* 范围向量
  * 一段时间内的 查询到的全部数据
* 常量
* 字符串(暂未投入使用)

// TODO

## Operators 运算符和关键字



## Functions 函数

## Advanced 高级



## Common collocation 常见搭配



## Ref

* https://prometheus.io/docs/prometheus/latest/querying

