
最初按自己想的,应该这样就可以了
```go
package main

import (
	"os/exec"
)

func main(){
	fmt.println("hello world")
	cmd := exec.Comand("clear")
	cmd.Run()
}
```

然后查阅了一些博客

参考 [link](https://my.oschina.net/u/2004526/blog/847140#h1_4)

其实需要指定 `cmd` 的 `标准输出(Stdout)` 为 `os` 的 `标准输出(Stdout)`
```go
cmd.Stdout = os.Stdout
```

最终完整的代码如下
```go
package main

import (
	"os"
	"os/exec"
)

func main(){
	fmt.println("hello world")
	cmd := exec.Comand("clear")
    cmd.Stdout = os.Stdout
	cmd.Run()
}
```
---

亦可以使用如下方式清屏
```go
fmt.Printf("\x1bc")
// OR
fmt.Printf("\x1b[2J")

// 以上两种同一个意思
```
详细 前往 [利用 ANSI 支持的样式玩出不一样的 stdout](https://kuricat.com/gist/ansi-stdout-6s4pi)