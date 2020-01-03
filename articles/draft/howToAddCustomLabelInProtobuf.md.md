# 如何为 protoc-gen-go 添加自定义标签支持

[TOC]

## protoc-gen-go 结构

```shell
.
├── descriptor                    // proto 文件中的所有可用信息
│   ├── descriptor.pb.go
│   └── descriptor.proto
├── doc.go
├── generator
│   ├── generator.go
│   ├── internal
│   │   └── remap
│   │       ├── remap.go
│   │       └── remap_test.go
│   └── name_test.go
├── golden_test.go
├── go.mod
├── go.sum
├── grpc
│   └── grpc.go
├── link_grpc.go
├── plugin
│   ├── plugin.pb.go
│   ├── plugin.pb.golden
│   └── plugin.proto
└── main.go

```

