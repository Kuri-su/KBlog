# Genericity in Golang 1.17

[TOC]

泛型编程(`Generic Programing`)是 程序设计语言 的一种风格 或者 范式, 允许开发者在 `强类型语言` 中 编写一些 运行时才决定的类型. 这将提升在 强类型语言 中 代码的灵活度, 并让开发者写出更加简洁的代码. 各个语言中都有各种对 泛型  的支持 : 

* `C#`, `Java`, `.Net`, `Rust`, `Swift`, `TypeScript`, `Golang` 中称为 `泛型`
* `Scala`, `Jiula`, `Haskell` 中称为 `参数多态`
* `C++` 中称为 `模板`

下面对各个语言中的泛型来做一些介绍

## C++ 模板

// TODO

## Golang 泛型

在 Golang 1.17 前, 对于运行时才确定的类型, gopher 们通常使用 `interface 类型` + `assert(断言)` 的方式来处理, 会有多个 `if else` 语句来对程序支持的多个类型进行判断 和 分别处理. 

而在 Golang 1.17 中, 预计 Golang 会初步添加对 泛型 的支持, 但由于 1.17 尚未 release , 我们仅能通过一些此前的技术草案 和 提案 来一窥 Golang 泛型 的样子.

## Rust 泛型

Rust 中和 Golang 类似, 在方法名后添加 `<T>` 来





## Common Lisp
// TODO

## Java
// TODO

## C
// TODO