+++
date = "2019-05-24"
title = "Container/list-golang"
slug = "containerlist-golang-zeux0"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = "链表实现的双向链表"
+++

> 链表实现的双向链表

主要的 `struct` 有两个, 双向链表 `List` 和  `Element` (Node)

```go
type Element struct {
    next, prev *Element

    list *List

    Value interface{}
}

type List struct {
    root Element // list 的 哨兵
    len  int
}

```

Golang 的 `List` 是存在哨兵的, 它自带一个 `root`, 作为起始

我们从 `New` 方法开始

```go
func New() *List { return new(List).Init() }

func (l *List) Init() *List {
    l.root.next = &l.root
    l.root.prev = &l.root
    l.len = 0
    return l
}
```

使用 `new` 关键字给 `list` 分配内存, 然后调用 `Init` 初始化哨兵, 讲哨兵的前后指针都指向自己, 并初始化 `list` 的 `len`.

~~哨兵前后都指向自己, 做成一个环, 然后可以立刻拿到自己的头和尾, 这个设计真的很棒~~

#### insert

```go
func (l *List) insert(e, at *Element) *Element {
    /**
    这样在判断的时候会认为是指向了 nil
    且这样会很容易的找到尾巴
    ┌----------┐
    ∨          ∨
    root ----> at
               ^
               to
               e

    OR
    
    ┌---------------------------┐
    ∨                           ∨
    root ----> at <---> b <---> c
                        ^
                        to
                        e
     */

    /**
                        n
                        |
	root <---> at <---> b <---> c

                        e
	 */
	n := at.next

	/**
                        n
                        |
	root ----> at <---- b <---> c
               |
               |
               └------->e
	 */
	at.next = e

	/**
                        n
                        |
	root ----> at <---- b <---> c
               |↑
               |└-------┐
               └------->e
	 */
	e.prev = at

	/**
	                    ┌---------┐
                        n         |
                        |	      |
	root ----> at <---- b <---> c |
               |↑                 |
               |└-------┐         |
               └------->e---------┘
	 */
	e.next = n
	/**
	                    ┌---------┐
                      n-┤         |
                      | ↓	      |
	root ----> at     | b <---> c |
               |↑     └--┐        |
               |└-------┐↓        |
               └------->e---------┘
	 */
	n.prev = e

	e.list = l
	l.len++
	return e
}
```

#### remove

```go
func (l *List) remove(e *Element) *Element {
    /**
    ┌---------------------------┐
    ∨                           ∨
    root ----> at <---> e <---> c
     */

    /**
    ┌---------------------------┐
    ∨                           ∨
    root ----> at ------------> c
               ^                ^
               └------- e <-----┘
	 */
	e.prev.next = e.next

    /**
    ┌---------------------------┐
    ∨                           ∨
    root ----> at <-----------> c
               ^                ^
               └------- e ------┘
    */
	e.next.prev = e.prev
	/**
    ┌---------------------------┐
    ∨                           ∨
    root ----> at <-----------> c
               ^
               └------- e
    */
	e.next = nil // avoid memory leaks
	/**
    ┌---------------------------┐
    ∨                           ∨
    root ----> at <-----------> c

                        e
    */
	e.prev = nil // avoid memory leaks
	e.list = nil
	l.len--
	return e
}
```

#### move

```go
func (l *List) move(e, at *Element) *Element {
    /**
    ┌-----------------------------------┐
    ∨                                   ∨
    root ----> at <---> c <---> e <---> d
    */
	if e == at {
		return e
	}
    /**
    ┌-----------------------------------┐
    ∨                                   ∨
    root ----> at <---> c ------------> d
                        ^               ^
                        └------ e <-----┘
    */
	e.prev.next = e.next
    /**
    ┌-----------------------------------┐
    ∨                                   ∨
    root ----> at <---> c <-----------> d
                        ^               ^
                        └------ e ------┘
    */
	e.next.prev = e.prev

    /**
    ┌-----------------------------------┐
    ∨                  n|               ∨
    root ----> at <---> c <-----------> d
                        ^               ^
                        └------ e ------┘
    */
	n := at.next
    /**
    ┌-----------------------------------┐
    ∨                  n|               ∨
    root ----> at <---- c <-----------> d
                |       ^               ^
                |       └------ e ------┘
                └---------------^
    */
	at.next = e
    /**
    ┌-----------------------------------┐
    ∨                  n|               ∨
    root ----> at <---- c <-----------> d
                ^                       ^
                |               e ------┘
                └---------------^
    */
	e.prev = at
	/**
    ┌-----------------------------------┐
    ∨                  n|               ∨
    root ----> at <---- c <-----------> d
                ^       ^               ^
                |       └------ e ------┘
                └---------------^
    */
	e.next = n
	/**
    ┌-----------------------------------┐
    ∨                  n|               ∨
    root ----> at       c <-----------> d
                ^       ^
                |       └------>e
                └---------------^
    */
	n.prev = e

    /**
    ┌-----------------------------------┐
    ∨                                   ∨
    root ----> at <---> e <---> c <---> d
    */
	return e
}

```

同时, `Element` 和 `List` 对外提供若干个方法

#### Element
```go
// 获取 链表 的 当前节点 的 下一个节点
func (e *Element) Next() *Element {
    // 如果下一个节点是 链表的哨兵节点, 则当前已经在尾部, 返回 nil, 符合预期
	if p := e.next; e.list != nil && p != &e.list.root {
		return p
	}
	//...
}
// 获取 链表 的 当前节点 的 上一个节点
func (e *Element) Prev() *Element {
    // 如果上一个节点是 链表的哨兵节点, 则当前已经在尾部, 返回 nil, 符合预期
	if p := e.prev; e.list != nil && p != &e.list.root {
		return p
	}
	//...
}
```


#### List
```go
// 当前链表长度
func (l *List) Len() int { return l.len }

// 获取链表头部元素
func (l *List) Front() *Element {
	if l.len == 0 {
		return nil
	}
	return l.root.next
}

// 获取链表尾部元素
func (l *List) Back() *Element {
	if l.len == 0 {
		return nil
	}
	return l.root.prev
}

// 删除节点
func (l *List) Remove(e *Element) interface{} {
    // 传入的这个节点如果属于当前 list, 则删除, 否则不删除
    // 删除后的节点的 prev , next , list 属性都为 nil, 可以根据这个判断是否删除成功
	if e.list == l {
		// if e.list == l, l must have been initialized when e was inserted
		// in l or l == nil (e is a zero Element) and l.remove will crash
		l.remove(e)
	}
	return e.Value
}

// 从头部 push 节点
func (l *List) PushFront(v interface{}) *Element {
    // 防止因为是自己手动实例化的 结构体而没有初始化的问题,
    // 检查是否已经初始化, 也就是哨兵的 尾节点是否指向自己
	l.lazyInit()
	// 在 root 后面插入元素
	return l.insertValue(v, &l.root)
}

// 从尾部插入元素
func (l *List) PushBack(v interface{}) *Element {
	l.lazyInit()
	// 在尾部的前一个元素后插入元素
	return l.insertValue(v, l.root.prev)
}

// 在给定节点前插入节点
func (l *List) InsertBefore(v interface{}, mark *Element) *Element
// 在给定节点后插入节点
func (l *List) InsertAfter(v interface{}, mark *Element) *Element


// 将给定节点挪到 哨兵 的后面, 也就是链表的头部
func (l *List) MoveToFront(e *Element)
// 将给定节点挪到 哨兵 的前面, 也就是链表的尾部
func (l *List) MoveToBack(e *Element)
// 将给定节点挪到 给定节点 的后面
func (l *List) MoveBefore(e, mark *Element)
// 将给定节点挪到 给定节点 的后面
func (l *List) MoveAfter(e, mark *Element)

// 合并链表 在链表头部哨兵后逐步插入别的链表的全部节点,
// 步骤如下
/*
往 A(root<->a<->b) 链表插入 B(root<->c<->d)

root<->c<->d
root<->b<->c<->d
root<->c<->b<->c<->d
 */
func (l *List) PushFrontList(other *List) {
	l.lazyInit()
	// 每次运行结束更新 i (other 链表的长度), e (other 链表的尾节点)
	for i, e := other.Len(), other.Back(); i > 0; i, e = i-1, e.Prev() {
		l.insertValue(e.Value, &l.root)
	}
}
```