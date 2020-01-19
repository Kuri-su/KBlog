# Protocal Buffer 原理与实现

[TOC]

## Encoding

### Varint 方法

我们可以在 Protobuf 的 Go 实现的  proto/encode.go:72 找到相关的代码.

```go
// EncodeVarint returns the varint encoding of x.
// This is the format for the
// int32, int64, uint32, uint64, bool, and enum
// protocol buffer types.
// Not used by the package itself, but helpful to clients
// wishing to use the same encoding.
func EncodeVarint(x uint64) []byte {
    var buf [maxVarintBytes]byte
    var n int
    for n = 0; x > 127; n++ {
        buf[n] = 0x80 | uint8(x&0x7F)
        x >>= 7
    }
    buf[n] = uint8(x)
    n++
    return buf[0:n]
}
```

这里有把备注也一起列出来, 笔者发现github 上的开源项目很喜欢把一些讲解写在备注里, 所以之后看代码的时候多看些注释, 这里把注释也一并翻译







ref:

> [Google Protocol Buffer 的使用和原理 - IBM](https://www.ibm.com/developerworks/cn/linux/l-cn-gpb/index.html#major4)
>
> [高效的数据压缩编码方式 Protobuf - encode](https://halfrost.com/protobuf_encode/#base128varints)
>
> [高效的序列化/反序列化数据方式 Protobuf - decode](https://halfrost.com/protobuf_decode/#)
>
> [详解varint编码原理](https://segmentfault.com/a/1190000020500985)

