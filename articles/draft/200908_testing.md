# Golang Testing

[TOC]

测试的话, 无非是 单元测试和集成测试, 这篇大部分都是 拾人牙慧 的内容 : )

## Unit Test

什么是单元测试这里就不赘述. 但在 <单元测试的艺术> 这本书里, 提到一个关于什么是优秀的单元测试的定义, 可以分享一下, 

![](/home/kurisu/.config/Typora/typora-user-images/image-20200909131853194.png)

这段定义是由下面 优秀的单元测试 应该有的特性所 总结出来的. 虽然在刚开始可能比较难以做到, 但我觉得应该以其为目标吧

![image-20200909132025699](/home/kurisu/.config/Typora/typora-user-images/image-20200909132025699.png)

这里详细说一下 上面特性的几个部分.

1. 为什么要任何人 都可以很快的运行它, 很多情况下, 在大型项目中, 我们都是多人开发的. 那么在多人开发过程中, 经常出现 A 同学 改了代码之后, 影响到 B 同学的功能, 这个通常称为 `偶然引入缺陷`, 那么这个时候, 如果A 同学 可以跑全量单元测试, 那么就可以很快发现这个问题, 否则亦然反之.
2. 它的结果是稳定的, 以及 它应该能完全控制被测试的单元 这两点, 需要配合 Mock 来做. 毕竟代码中, 有不可控制的外部依赖是难以避免的, 这样的话, 它的结果将很难稳定下来, 进而导致我们无法对结果进行断言, 进而影响自动化和CI 流程, 最终影响 测试所能产生的效果. 另外如果 Test 不能完全控制被测试的单元, 举个例子, 不能 Mock 一些依赖项, 那将导致这个测试只能在一些环境下面运行, 或者 运行的前置条件很多, 最终 让整个流程很难高效的自动化.

所以最后觉得, 确实需要做到上面的这些, 才能让后面的整个测试流程, 更加高效 和 自动化.

另外 Unit Test 有几个必备的特性, 基本上每个测试框架(组合),都要实现, 用来提高 测试效率 和 可维护性

*  Assert (断言)
* Mock(假对象) / Fake(伪造) / Stub(打桩)

### Ginkgo + Gomega

#### GoTesting

这里展示 一个 GoTesting 测试 的例子

* GoTesting: https://books.studygolang.com/The-Golang-Standard-Library-by-Example/chapter09/09.1.html

GoTesting 包的缺陷比较明显, 没有 最基本的 断言, 也没有 Mock 等机制.

### Ginkgo

Ginkgo 的简介 `Go语言的一个行为驱动开发（BDD， Behavior-Driven Development）风格的测试框架，通常和库Gomega一起使用`,但我们先不管什么是 BDD, 来看 Ginkgo 的 用法结构

#### 初始化测试代码

```shell
# 安装 ginkgo 命令
$ go get -u github.com/onsi/ginkgo/ginkgo
# 生成执行入口
$ ginkgo bootstrap
# 为 文件 或者 文件夹 生成基本测试文件结构
$ ginkgo generate output.go
```

#### 书写结构

```go
package output_test

import (
	"testing"

	. "github.com/onsi/ginkgo"
	. "github.com/onsi/gomega"
)

// 执行入口
func TestOutput(t *testing.T) {
	RegisterFailHandler(Fail)
	RunSpecs(t, "Output Suite")
}


// 定义 测试用例
var _ = Describe("Output", func() {
    // 测试模块
	Describe("save to many files", func() {
        // 定义变量
		var (
			savePath   = "output.test.file"
			content    = []byte("Vasari's account of the Mona Lisa comes from his biography of Leonardo published in 1550, 31 years after the artist's death. It has long been the best-known source of information on the provenance of the work and identity of the sitter. Leonardo's assistant Salaì, at his death in 1524, owned a portrait which in his personal papers was named la Gioconda, a painting bequeathed to him by Leonardo.")
			mockCtl    *gomock.Controller
			osFileMock *util.MockOSFileOperateIF
		)

        // 前置操作 , 可以想象成 前置中间件
        // 通常用来初始化一些操作
		BeforeEach(func() {
			config.MergeLogfilesSwitch = false
            // 初始化 Mock
			mockCtl = gomock.NewController(GinkgoT())
            // 生成 Mock 对象
			osFileMock = util.NewMockOSFileOperateIF(mockCtl)
			util.OSFileOperate = osFileMock
		})

        // 后置操作
        // 通常用来 清理环境和一些总结事项
		AfterEach(func() {
			mockCtl.Finish()
		})

        // 一个 Case
		It("when it is a basic success case", func() {
            // Mock 断言
			osFileMock.EXPECT().
				MakeDirWithFilePath(gomock.Eq(savePath)).
				Return(nil).Times(1)
            // Mock 断言
			osFileMock.EXPECT().
				WriteFile(gomock.Eq(savePath), gomock.Eq(content), os.FileMode(0644)).
				Return(nil).Times(1)

			testSaveToFileSuccess(savePath, content)
		})

	})
})


// testSaveToFileSuccess
func testSaveToFileSuccess(savePath string, content []byte) {
	var err error
    // 调用
	err = output.Save(savePath, content)
    // 断言
	gomega.Expect(err).To(gomega.BeNil())
}

// checkFileContentIsEqual
func checkFileContentIsEqual(filePath string, content []byte) {
	var err error

	// 判断文件是否存在
	_, err = os.Stat(filePath)
	gomega.Expect(err).To(gomega.BeNil())

	// 判断文件内容是否一致
	fileContent, err := ioutil.ReadFile(filePath)
	gomega.Expect(err).To(gomega.BeNil())
	gomega.Expect(fileContent).To(gomega.Equal(content))
}


```

// TODO 细讲一下这里的结构 `Describe/IT` 那些

// TODO 还有X 和 F 前缀

// TODO 以及命令行使用, 例如 `ginkgo -r`/`ginkgo`

 #### Gomega

Gomega 通常与 Ginkgo 搭配使用, 它是 一个 匹配/断言 库, 还提供了 方便测试过程的 一些方便使用的包

* ghttp
* gexec
* gbytes
* gstruct

## Mock

### GoMock

### TDD

### BDD

### TDD Mock

### Stub && Fake

## Other

1. 测试覆盖率
2. 边缘用例

## Integration Testing

### 依赖资源的生成

