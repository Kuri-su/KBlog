
今天 leetcode 周赛, 一道 dfs 活生生的跪在了 slice 的机制上... 因为 slice 是引用类型, 所以函数间对 slice 的修改都会落到同一个数组上... 导致得不到预期的结果.

尝试 copy 无果... 以如下的方式 copy 仍然无法深拷贝成功

```go
func main(){
  a := [][]int{
    {1, 2, 3},
    {4, 5, 6},
  }
  b := make([][]int, 3, 3)
  copy(b, a)

  b[1][2] = 999

  fmt.printf("%+v", a)
}

// output:
// [{1,2,3},{4,5,999}]
```

这种不符合预期的原因, 其实是因为初始化的问题, 导致 b 直接使用了 a 的底层数组

我们使用 `make([][]int,3,3)` 初始化到的 b 数组实际上长的像下面这样
```
{
	0:nil
	1:nil
    2:nil
}
```

这样复制的话, 可能直接 b 就用了 a 的底层数组.

所以正确的复制姿势是这样的...

```go
func main(){
  a := [][]int{
    {1, 2, 3},
    {4, 5, 6},
  }
  b := make([][]int, 3, 3)
  for key, value := range b {
    b[key] = make([]int, 3, 3)
    copy(b[key], a[key])
  }

  b[1][2] = 999

  fmt.printf("%+v", a)
}
// output:
// [{1,2,3},{4,5,6}]
```

好的问题解决

// 丢了周赛挺进前五十的机会, SAD TAT