
# golang 获取当前目录

```go
path,_:=os.Getwd()
fmt.println(path)
```


> Getwd returns a rooted path name corresponding to the current directory. If the current directory can be reached via multiple paths (due to symbolic links), Getwd may return any one of them.
> 
> Getwd返回与当前目录对应的根路径名。 如果可以通过多个路径访问当前目录（由于符号链接），Getwd可能会返回其中任何一个。