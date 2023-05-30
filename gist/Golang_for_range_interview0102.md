+++
date = "2019-06-09"
title = "关于 Golang for range 的一道面试题"
slug = "golang-for-range-y6mtl"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "题目大概是这样子, 挺短的题目, 问输出是什么"
+++
题目大概是这样子, 挺短的题目, 问输出是什么

```go
package main

import "fmt"

func main() {
    i := 12
    arr := []int{1, 2, 3, 4}
    for key := range arr {
        arr = append(arr, 5)
        fmt.Printf("%+v", arr)
        if key > i {
            break
        }
    }
}

```



当场迟疑了... 因为一般我们都知道如果像下文这样, 则 `value` 被拷贝了一次, 但是对 `arr` 的修改话就比较少遇到...

```go
for key , value := range arr {
	...
}
```

我答得是,` 会不停的死循环下去 `, 然后回来试下, 实际的输出是
```
[1 2 3 4 5][1 2 3 4 5 5][1 2 3 4 5 5 5][1 2 3 4 5 5 5 5]
//GG
```

也就是说 `arr` 被在拿来遍历的时候, 就已经被 `copy` 了一遍了, 循环遍历的是 `arr` 一开始进入循环时候的模样, 此后对 `arr` 的修改虽然会体现在 `arr` 上, 但是并不会改变循环的次数.

下面直接输出地址看看,

```go
...

func main() {
    i := 12
    arr := []int{1, 2, 3, 4}
    fmt.Println(unsafe.Pointer(&arr))
    for key := range arr {
        fmt.Println(unsafe.Pointer(&arr))
        arr = append(arr, 5)
        if key > i {
            break
        }
    }
}

/*
    0xc00000c060
    0xc00000c060
    0xc00000c060
    0xc00000c060
    0xc00000c060
*/
```
