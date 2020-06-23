# PromQL 处理 NaN 数据 输出结果异常

> PromQL process NaN data result error

[TOC]

## 缘起 && 现象

这个问题通常出现在

## 解决方案

这里先贴上 解决方案, 以上面的例子为例, 通过筛选掉 结果为 NaN,  例如下面这样.

```go
// before
avg(nan_metrics{label="label"})

// after
avg(nan_metrics{label="label"} > 0)
```

即可让结果正常显示,

## 深挖原因

## 总结

## Ref

> * TODO