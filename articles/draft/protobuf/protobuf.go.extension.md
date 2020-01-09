# Protobuf Golang 插件和自定义标签实现

## 爲什麼需要自定義標籤



## 如何開發自定義標籤

>  在開發自定義標籤之前, 建議首先對 `protobuf-gen-go` 的生命週期做一定的了解, 可以參考 [這篇文章]().

本篇以自定義一個 用於 標識字段是否需要自動添加 `omitempty json tag` 的標籤 `use_omitempty`爲例, 來講述如何開發自定義標籤.

對於自定義的標籤, 我們首先需要讓 protobuf-gen-go標籤註冊到 protobuf-gen-go 中, 這裏以 proto

開發自定義組件有兩種方式, 這裏分開講解

* 一種是以 plugin 的形式插入修改,
* 另一種是直接修改  protoc-gen-go 的邏輯

### Plugin 形式



### 修改 protoc-gen-go/generator 代碼





## 如何測試











ref: 

> [protobuf .(精華版)]()