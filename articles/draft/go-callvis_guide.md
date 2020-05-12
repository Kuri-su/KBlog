# Go-callvis Guide

## What's



## Install



## 

## Use

### Options

* -focus string
  *  聚焦于具体的包或者 import Path 上 (default "main")
* -group string
  * 使用 `包(pkg)` 或者 `类型(type)` 进行聚合, 以逗号分隔
* -ignore string
  * 排除一些包, 包路径之间 使用 逗号分隔 ,
  * example: ignore: github.com/A/B/config,github.com/A/B/pkg/config 
* -include string
  * 引入具有指定前缀的包, 使用逗号分隔
* -limit string
  * 将包的路径限制为给定前缀, 使用逗号分隔
* -minlen uint
  * 最小边长(用于更宽的输出)( default 2)
* -nodesep float
  * 最小节点间距, 同一等级中两个节点之间的最小间距( default 0.35)
* -nointer
  * bool, 忽略对未导出函数的调用
* -nostd
  * bool , 忽略对标准库的引用
* -tags []string
  * go build tags 
* -tests
  * bool, 引入测试代码
* -file
  * output filename 
* -format
  * 输出文件格式, [svg | png | jpg ] (default svg)
* -debug
  * 输出大量日志

