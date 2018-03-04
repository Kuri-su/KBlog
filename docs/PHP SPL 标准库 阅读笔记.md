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
  > 描述待补  
  > 按照 [php官方手册](http://php.net/manual/zh/spl.datastructures.php#spl.datastructures) 的顺序排列
* SplDoublyLinkedList 双向链表
  它为 SplStack(栈) 和 SplQueue(队列) 提供了一个合适的实现
  > 补方法列表和注释
  * SplStack(栈)
    先进后出
  * SplQueue(队列)
    先进后出
* SplHeep 堆
  > 猜测这个堆是顺序表实现的,待方法列表和补充
  * SplMaxHeap 最大堆
  * SplMinHeap 最小堆 
  * SplPriorityQueue 基于最大堆实现的优先队列
* SplFixedArray 定长数组
  > 定长数组,且似乎只允许范围内的整数作为索引
* SplObjectStorage 对象存储
  > 感觉是先把对象序列化,然后获取哈希值之后再用散列表存储
  
  ## 迭代器
  
  
  ## 接口
  
  
  ## 异常
  
  
  ## SPL函数
    > 例如 `Composer` 的类自动加载 就有用到 `spl_autoload_register` 这个 spl 函数
   
  ## 文件处理
  
  
  ## 各种类以及接口
