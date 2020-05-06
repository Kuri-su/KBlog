# Golang Study - Reflect

反射包有两个比较重要的函数和类型.

* `reflect.TypeOf` 能获取类型信息, 返回值类型为 Type
* `reflect.ValueOf` 能获取数据的运行时表示, 也就是值, 返回值类型为 Value



反射三大法则: 

1. 从 Interface 变量可以反射出反射对象

   我们认为 Go 语言的类型和反射类型处于两个不同的世界. 那么 上述的 typeOf 函数和 valueOf 函数就是这两个世界的桥梁.

2. 从反射对象 可以获取 Interface{} 变量

   使用 

   ```go
   reflect.ValueOf(1).Interface().(Int) 
   ```

3. 要修改反射对象, 其值必须可设置



