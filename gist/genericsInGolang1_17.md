# Genericity in Golang 1.17

[TOC]

泛型编程(`Generic Programing`)是 程序设计语言 的一种风格 或者 范式, 允许开发者在 `强类型语言` 中 编写一些 运行时才决定的类型. 这将提升在 强类型语言 中 代码的灵活度, 并让开发者写出更加简洁的代码. 各个语言中都有各种对 泛型  的支持 : 

* `C#`, `Java`, `.Net`, `Rust`, `Swift`, `TypeScript`, `Golang` 中称为 `泛型`
* `Scala`, `Jiula`, `Haskell` 中称为 `参数多态`
* `C++` 中称为 `模板`

下面对各个语言中的泛型来做一些介绍

## C++ 模板

泛型在 C++ 中称为模板, C++ 有两种模板, `函数模板` 和 `类模板` , 函数模板很好理解, 就函数里支持泛型, 举个例子, 一个比大小的函数, 同时支持 int / float / string 类型

```cpp
#include <iostream>
#include <string>

// from https://www.runoob.com/cplusplus/cpp-templates.html

using namespace std;

// template <typename type> ret-type func-name(parameter list)
template <typename T>
inline T const& Max (T const& a, T const& b)  // 下面 const 是 修饰 变量的, 表示不可变
{ 
    return a < b ? b:a; 
} 
int main ()
{
    int i = 39;
    int j = 20;
    cout << "Max(i, j): " << Max(i, j) << endl; 
 
    double f1 = 13.5; 
    double f2 = 20.7; 
    cout << "Max(f1, f2): " << Max(f1, f2) << endl; 
 
    string s1 = "Hello"; 
    string s2 = "World"; 
    cout << "Max(s1, s2): " << Max(s1, s2) << endl; 
 
    return 0;
}
```

那 `类模板` 是解决什么问题的呢? 我们可以通过下面这个例子来了解, 通常是类可以支持多种数据结构来使用时, 会使用 `类模板` , 例如 数据结构的实现, 堆, 栈,

```cpp
#include <iostream>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

// from https://www.runoob.com/cplusplus/cpp-templates.html
 
using namespace std;

// template <class type> class class-name
 
// 类声明
template <class T>
class Stack { 
  private: 
    vector<T> elems;     // 元素 
 
  public: 
    void push(T const&);  // 入栈
    void pop();               // 出栈
    T top() const;            // 返回栈顶元素
    bool empty() const{       // 如果为空则返回真。
        return elems.empty(); 
    } 
}; 
 
// 类方法实现
template <class T>
void Stack<T>::push (T const& elem) 
{ 
    // 追加传入元素的副本
    elems.push_back(elem);    
} 
// 类方法实现
template <class T>
void Stack<T>::pop () 
{ 
    if (elems.empty()) { 
        throw out_of_range("Stack<>::pop(): empty stack"); 
    }
    // 删除最后一个元素
    elems.pop_back();         
} 
// 类方法实现
template <class T>
T Stack<T>::top () const 
{ 
    if (elems.empty()) { 
        throw out_of_range("Stack<>::top(): empty stack"); 
    }
    // 返回最后一个元素的副本 
    return elems.back();      
} 
 
int main() 
{ 
    try { 
        Stack<int>         intStack;  // int 类型的栈 
        Stack<string> stringStack;    // string 类型的栈 
 
        // 操作 int 类型的栈 
        intStack.push(7); 
        cout << intStack.top() <<endl; 
 
        // 操作 string 类型的栈 
        stringStack.push("hello"); 
        cout << stringStack.top() << std::endl; 
        stringStack.pop(); 
        stringStack.pop(); 
    } 
    catch (exception const& ex) { 
        cerr << "Exception: " << ex.what() <<endl; 
        return -1;
    } 
}
```

## Golang 泛型

在 Golang 1.17 前, 对于程序中运行时才确定的类型, gopher 们通常使用 `interface 类型` + `assert(断言)` 的方式来处理, 会有多个 `if else` 语句来对程序支持的多个类型进行判断 和 分别处理. 

而在 Golang 1.17 中, 预计 Golang 会初步添加对 泛型 的支持, 但由于 1.17 尚未 release , 我们仅能通过一些此前的技术草案 和 提案 来一窥 Golang 泛型 的样子.

https://www.4async.com/2021/08/golang-117-generics/

https://tonybai.com/2020/06/18/the-go-generics-is-coming-and-supported-in-go-1-17-at-the-earliest/

## Rust 泛型

Rust 中和 Golang 类似, 在方法名后添加 `<T>` 来支持

```rust
fn max(array: &[i32]) -> i32 {
    let mut max_index = 0;
    let mut i = 1;
    while i < array.len() {
        if array[i] > array[max_index] {
            max_index = i;
        }
        i += 1;
    }
    array[max_index]
}

fn main() {
    let a = [2, 4, 6, 3, 1];
    println!("max = {}", max(&a));
}
```

上面只能支持 i32(int32) , 而其实它可以支持 f64(float64) 的比大小, 所以可以将上面的函数用泛型来改写

```rust
fn max<T>(array: &[T]) -> T {
    let mut max_index = 0;
    let mut i = 1;
    while i < array.len() {
        if array[i] > array[max_index] {
            max_index = i;
        }
        i += 1;
    }
    array[max_index]
}
```

## Common Lisp
https://zh.wikipedia.org/wiki/%E6%B3%9B%E5%8C%96%E5%87%BD%E6%95%B0

## Java
https://www.runoob.com/java/java-generics.html
