# Ginkgo test get start

[TOC]

Ginkgo 是 Go 预演的 一个 测试框架(Get Start 先不用管 BDD), 通常一些特别的框架会有自己独特的理念和规则, 很不幸也很幸运 , Ginkgo 也是一样.

Ginkgo  和别的框架不一样的地方在于, 它有一个 规定执行顺序和执行方式的 层级结构.

## 结构

Ginkgo 的结构 是一种类似于 HTML 的层级结构, 但 Ginkgo 的结构相比 HTML 要简单很多.

Ginkgo 的层级结构 主要由 三种元素构成. 

* 结构元素 : Describe/Context/When
  * // TODO
* 执行用例元素: It/Specify
  * // TODO
* 性能测试元素: Measure

除了构成结构的元素, 还有 可以用于插入前后中间件的 元素 可供使用

* `BeforeEach` && `AfterEach`
  * // TODO
* `JustBeforeEach` && `JustAfterEach`
  * // TODO
* `BeforeSuite` && `AfterSuite`
  * // TODO

除此之外, 还有一些 不参与构建 层级结构 的元素可供使用: 

* `By` 

## 生命周期

## T

## T

## T

## T

## T

## T

## T