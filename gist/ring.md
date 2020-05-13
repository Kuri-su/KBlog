
# Container/ring

> 环状双向链表 (无哨兵)

相较于 List , ring 因为不需要哨兵快速找到头尾, 所以只有一个 struct `ring` (环)

```go
type Ring struct {
    // 前后节点
    next, prev *Ring
    Value      interface{}
}
```

创建一个环, 使用 New 函数, 创建一个有 n 个容量的环

```go
func New(n int) *Ring {
    if n <= 0 {
        return nil
    }
    r := new(Ring)
    p := r
    for i := 1; i < n; i++ {
        p.next = &Ring{prev: p}
        p = p.next
    }
    p.next = r
    r.prev = p
    return r
}
```

同时提供 Len() 函数, 获取当前 ring 的容量

```go
func (r *Ring) Len() int {
    n := 0
    if r != nil {
        n = 1
        // 即时的去遍历一次 ring 获取当前长度
        for p := r.Next(); p != r; p = p.next {
            n++
        }
    }
    return n
}
```

为在 ring 中移动当前操作的指针, 提供了 move 方法, 支持正向移动和反方向移动 (向左或向右移动)

```go
func (r *Ring) Move(n int) *Ring {
    if r.next == nil {
        /*
        避免 a:=&ring.Ring{}
        然后直接拿来用而没有初始化从而报错的情况
         */
        return r.init()
    }
    switch {
    case n < 0:
        // 负数加到 0
        for ; n < 0; n++ {
            r = r.prev
        }
    case n > 0:
        // 正数减到 0
        for ; n > 0; n-- {
            r = r.next
        }
    }
    return r
}
```

也可以给加入环节点或者删除环节点 (类似于)

```go
func (r *Ring) Link(s *Ring) *Ring {
    /**
    ┌-----------------------┐
    ∨                       ∨
    a <---> r <---> b <---> c
            ^
                add s
    ___
    OR
    __
    ┌-----------------------┐
    ∨                       ∨
    a <---> r <---> b <---> c
            ^

    ┌-----------------------┐
    ∨                       ∨
    d <---> f <---> s <---> g
                    ^

    s will add after r
    */

    /*
    ┌-----------------------┐
    ∨              n|       ∨
    a <---> r <---> b <---> c

    ┌-----------------------┐
    ∨                       ∨
    d <---> f <---> s <---> g
     */
    n := r.Next()

    if s != nil {
        /*
        ┌-----------------------┐
        ∨              n|       ∨
        a <---> r <---> b <---> c

        ┌-----------------------┐
        ∨      p|               ∨
        d <---> f <---> s <---> g
        */
        p := s.Prev()

        // Note: Cannot use multiple assignment because
        // evaluation order of LHS is not specified.

        /*
        ┌-----------------------┐
        ∨              n|       ∨
        a <---> r <---- b <---> c
                └----┐
                     |
               p|    └--↓
        d <---> f <---> s <---> g
        ^                       ^
        └-----------------------┘
        */
        r.next = s
        /*
        ┌-----------------------┐
        ∨              n|       ∨
        a <---> r <---- b <---> c
                ↑----┐
                     |
               p|    └--↓
        d <---> f ----> s <---> g
        ^                       ^
        └-----------------------┘
        */
        s.prev = r
        /*
        ┌-----------------------┐
        ∨              n|       ∨
        a <---> r       b <---> c
                ↑----┐  |
                ┌----┼--┘
               p|    └--↓
        d <---> f ----> s <---> g
        ^                       ^
        └-----------------------┘
        */
        n.prev = p
        /*
        ┌-----------------------┐
        ∨              n|       ∨
        a <---> r       b <---> c
                ↑----┐  ↑
                ┌----┼--┘
               p↓    └--↓
        d <---> f       s <---> g
        ^                       ^
        └-----------------------┘
        */
        p.next = n
        /*
            ┌-------------------------------------------------------┐
            ∨                                      p|      n|       ∨
            a <---> r <---> s <---> g <---> d <---> f <---> b <---> c
         */
    }
    return n
}
```

所以最终是将 r 节点和 s 节点进行链接, 将 r 的后驱节点和 s 的前驱节点进行链接, 组成一个新的双向链表实现的环

而 Unlink() 方法则是 调用的 link 方法并做了一些变化

```go
func (r *Ring) Unlink(n int) *Ring {
    if n <= 0 {
        return nil
    }
    return r.Link(
        // 获取 r 的 n 个节点之后的那个 b 节点
        r.Move(n + 1)
        // 然后将 当前的 r 节点和 b 节点连接起来
        // 则中间的这些节点相当于从环中被排除掉
    )
}
```

最后, Ring 还提供一个 Do() 方法, 允许使用闭包函数遍历 整个 Ring

```go
func (r *Ring) Do(f func(interface{})) {
    if r != nil {
        f(r.Value)
        for p := r.Next(); p != r; p = p.next {
            f(p.Value)
        }
    }
}
```