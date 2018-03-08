# PHP SPL

从手册上可以分成以下几个部分

* 数据结构 `datastructures`
* 迭代器
* 接口
* 异常
* SPL 函数
* 文件处理
* 其他的类以及接口

## 数据结构

#### SplDoublyLinkedList 
> **双向链表**

它为 SplStack(栈) 和 SplQueue(队列) 提供了一个合适的实现
> 补方法列表和注释

#### SplStack
> **栈**

#### SplQueue
> **队列**


---
#### SplHeap 

> **堆**

SplHeap 实现了接口 迭代器 `Iterator` 和 `Countable`

**类摘要:**
```php
abstract SplHeap implements Iterator , Countable {

    /* 方法 */
    public __construct ( void )
    abstract protected int compare ( mixed $value1 , mixed $value2 )
    public int count ( void )
    public mixed current ( void )
    public mixed extract ( void )
    public void insert ( mixed $value )
    public bool isCorrupted ( void )
    public bool isEmpty ( void )
    public mixed key ( void )
    public void next ( void )
    public void recoverFromCorruption ( void )
    public void rewind ( void )
    public mixed top ( void )
    public bool valid ( void )
}
```

**方法介绍**:
~~`SplHeap::compare`待尝试，文档里写的是比较两个数~~  
`SplHeap::__construct` — 构造函数，创建一个空的堆  
`SplHeap::count` — 计算当前堆中的元素数量 `这个方法是实现了 Countable 接口的 count 方法`  
`SplHeap::current` — 获取迭代器当前指向的节点，~~返回值类型待测试~~  
`SplHeap::extract` — Extracts a node from top of the heap and sift up  
`SplHeap::insert` — Inserts an element in the heap by sifting it up  
`SplHeap::isCorrupted` — Tells if the heap is in a corrupted state  
`SplHeap::isEmpty` — Checks whether the heap is empty  
`SplHeap::key` — Return current node index  
`SplHeap::next` — Move to the next node  
`SplHeap::recoverFromCorruption` — Recover from the corrupted state and allow further actions on the heap  
`SplHeap::rewind` — Rewind iterator back to the start (no-op)  
`SplHeap::top` — Peeks at the node from the top of the heap  
`SplHeap::valid` — Check whether the heap contains more nodes  

---

##### SplMaxHeap 最大堆
  * SplMinHeap 最小堆
  * SplPriorityQueue 基于最大堆实现的优先队列

---

#### SplFixedArray 定长数组

  > 定长数组,且只允许范围内的整数作为索引

---

#### SplObjectStorage 对象存储

  > 感觉是先把对象序列化,然后获取哈希值之后再用散列表存储

---


















> 描述待补  
> 按照 [php官方手册](http://php.net/manual/zh/spl.datastructures.php#spl.datastructures) 的顺序排列

  
## 迭代器


## 接口
#### Countable 
> 计数接口

## 异常


## SPL函数
  > 例如 `Composer` 的类自动加载 就有用到 `spl_autoload_register` 这个 spl 函数
  
## 文件处理


## 各种类以及接口
