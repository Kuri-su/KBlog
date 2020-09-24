# Golang Testing

[TOC]

测试的话, 无非是 单元测试和集成测试

## Unit Test

什么是单元测试这里就不赘述. 但在 <单元测试的艺术> 这本书里, 提到一个关于什么是优秀的单元测试的定义, 可以分享一下, 

![](https://raw.githubusercontent.com/Kurisu-public/img/master/image-20200909131853194.png)

这段定义是由下面 优秀的单元测试 应该有的特性所 总结出来的. 虽然在刚开始可能比较难以做到, 但我觉得应该以其为目标吧

![image-20200909132025699](https://raw.githubusercontent.com/Kurisu-public/img/master/image-20200909132025699.png)

这里详细说一下 上面特性的几个部分.

1. 为什么要任何人 都可以很快的运行它, 很多情况下, 在大型项目中, 我们都是多人开发的. 那么在多人开发过程中, 经常出现 A 同学 改了代码之后, 影响到 B 同学的功能, 这个通常称为 `偶然引入缺陷`, 那么这个时候, 如果 A 同学 可以跑全量单元测试, 那么就可以很快发现这个问题, 否则亦然反之.
2. 它的结果是稳定的, 以及 它应该能完全控制被测试的单元 这两点, 需要配合 Mock 来做. 毕竟代码中, 有不可控制的外部依赖是难以避免的, 这样的话, 它的结果将很难稳定下来, 进而导致我们无法对结果进行断言, 进而影响自动化和 CI 流程, 最终影响 测试所能产生的效果. 另外如果 Test 不能完全控制被测试的单元, 举个例子, 不能 Mock 一些依赖项, 那将导致这个测试只能在一些环境下面运行, 或者 运行的前置条件很多, 最终 让整个流程很难高效的自动化.

所以最后觉得, 确实需要做到上面的这些, 才能让后面的整个测试流程, 更加高效 和 自动化.

另外 Unit Test 有几个必备的特性, 基本上每个测试框架(组合),都要实现, 用来提高 测试效率 和 可维护性

*  Assert (断言)
*  Fake(伪造): 
   * Mock(假对象)   
   * Stub(打桩)
   * ...

### Ginkgo + Gomega

#### GoTesting

这里展示 一个 GoTesting 测试 的例子

* GoTesting: https://books.studygolang.com/The-Golang-Standard-Library-by-Example/chapter09/09.1.html

GoTesting 包的缺陷比较明显, 没有 最基本的 断言, 也没有 Mock 等机制.

Go 的 Testing 库有很多, 例如 `testify` / `gocheck` , 这里着重讲 ginkgo

// Live Demo 表现传统框架存在的问题

### Ginkgo

Ginkgo 的简介 `Go 语言的一个行为驱动开发（BDD，Behavior-Driven Development）风格的测试框架，通常和库 Gomega 一起使用`,但我们先不管什么是 BDD, 来看 Ginkgo 的 用法结构

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
            By("init variables and mock controller")
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

###### 结构

* Describe/Context  你可以理解成 HTML 里的 DIV…… 只是圈定区块, 而没有太多实际动作

  * Describe 用于描述你的代码的一个行为
  * Context 用于区分上述行为的不同情况，通常为参数不同导致

* it(item)

  * 实际的测试 Case

* By 

  * 用于给逻辑复杂的块添加更加详细的文档

* BeforeEach/JustBeforeEach/JustAfterEach/AfterEach

  * 执行顺序  BeforeEach ->  JustBeforeEach -> It -> JustAfterEach -> AfterEach

* BeforeSuite/AfterSuite

  * 在整个测试套件执行之前/之后，进行准备/清理。和套件代码写在一起：

    ```go
    func TestBooks(t *testing.T) {
        RegisterFailHandler(Fail)
     
        RunSpecs(t, "Books Suite")
    }
     
    var _ = BeforeSuite(func() {
        dbClient = db.NewClient()
        err = dbClient.Connect(dbRunner.Address())
        Expect(err).NotTo(HaveOccurred())
    })
     
    var _ = AfterSuite(func() {
        dbClient.Cleanup()
    })
    ```

#### 特性

* 支持性能测试

  * Measure 代码块

* ginkgo  执行当前文件夹下的测试

* ginkgo -r 递归文件夹执行所有测试

* 你可以给 上面所有的结构方法前面加上 X 或者 F 前缀, 分别表示 Skip 掉这一块或者 Focus 也就是只测这一块, 例如上面的测试可以这样, 这个通常在于你只想 专注与某些测试用例调试的时候,

  ```go
  
  // 定义 测试用例
  var _ = Describe("Output", func() {
      // 测试模块
  	XDescribe("save to many files", func() {
  		// ……
  	})
  })
  
  ```

* Ginkgo 的特性还有很多, 这里先提这些

 #### Gomega

Gomega 通常与 Ginkgo 搭配使用, 它是 一个 匹配/断言 库, 还提供了 方便测试过程的 一些方便使用的包 `ghttp` , `gexec`, `gbytes`, `gstruct` .

## Mock

mock 测试：就是在测试过程中，对于某些不容易构造或者 不容易获取的对象，用一个虚拟的对象来创建以便测试的测试方法。

常见的会被 mock 的 对象包括 `外部依赖`/ `IO 操作`/`数据库操作` 等

Mock 的基本思路是 通过 Interface 去屏蔽掉 对固定库的依赖, 从而提供 可以 Mock 对象的空间 (毕竟通过 Interface 抽象后, 只要实现了 Interface 的 对象都可以传入), 当然也有更加 hack 的库, 但是我们这里仅仅说基本思路. 和标准实现

// Live Demo

### GoMock

Go 里面用的比较多的 mock 框架 有 `github.com/golang/mock`, `github.com/vektra/mockery`, 这里主要说 gomock

gomock 集成了 Mock / Stub 到一起, 另外在 所有依赖都被抽成 Interface 的前提下, Fake 也会变得很简单.

gomock 和 ginkgo 一样,提供了命令行工具, 你可以通过 gomock 的命令行工具, 对 Interface 生成一个实现了 该 Interface 的 对象, 在此之后, 我们就可以进行针对 Interface 的 Mock 注入了.

// Live Demo

基本 Mock Demo

```go
// 业务代码
type Foo interface {
  Bar(x int) int
}

// 被 Mock 依赖 的方法
func SUT(f Foo) {
 // ……
}
```

```go
// 测试代码
func TestFoo(t *testing.T) {
  // 创建控制器
  ctrl := gomock.NewController(t)

  // Assert that Bar() is invoked.
  // Mock 情况汇总和检查
  defer ctrl.Finish()

  // 从生成的文件中, New 一个针对 Interface 的 Mock 对象出来
  m := NewMockFoo(ctrl)

  // Asserts that the first and only call to Bar() is passed 99.
  // Anything else will fail.
  // 对入参进行断言 , 并指定出参
  m.
    EXPECT().
    Bar(gomock.Eq(99)).
    Return(101)

  // 将 Mock 对象传给 SUT 方法进行调用
  SUT(m)
}
```

在 Mock 了之后, 由于我们完全可以控制 Mock 对象的行为, 所以打桩也会变得非常容易, 下面演示 基本打桩 Demo

```go
// 业务代码
type Foo interface {
  Bar(x int) int
}

// 被 Mock 依赖 的方法
func SUT(f Foo) {
 // ……
}
```

```go
// 测试代码
func TestFoo(t *testing.T) {
  ctrl := gomock.NewController(t)
  defer ctrl.Finish()

  m := NewMockFoo(ctrl)

  // Does not make any assertions. Executes the anonymous functions and returns
  // its result when Bar is invoked with 99.
  m.
    EXPECT().
    Bar(gomock.Eq(99)).
    DoAndReturn(func(_ int) int { // 打桩
      time.Sleep(1*time.Second)
      return 101
    }).
    AnyTimes() // 规定该方法的运行次数

  // Does not make any assertions. Returns 103 when Bar is invoked with 101.
  m.
    EXPECT().
    Bar(gomock.Eq(101)).
    Return(103).
    AnyTimes()

  SUT(m)
}
```

在 mock 之后,所有的代码都会变得可以测试, 但这又有一个问题, Mock 的话必须要 将依赖改成 接口, 这对既有代码是十分不友好的, 如果我们写完代码再写测试, 这会导致 之后写 测试的时候, 要回去疯狂的改代码.

那我们能不能先写测试, 后写代码呢, 那这样其实 就是 测试驱动开发(TDD), 也称 测试优先

### TDD

通常 TDD 的形式是一个螺旋, 在一切的之前,一边编写测试用例, 一边初步规定代码的结构, 然后运行所有测试用例, 这时 所有测试用例都会失败, 接着编写代码, 使 方法可以通过所有的测试用例, 这样我们就完成了功能.

![image-20200910011716281](https://raw.githubusercontent.com/Kurisu-public/img/master/image-20200910011716281.png)

TDD 其实很简单. 但实施时候, 其实很容易走形……

![image-20200910012027654](https://raw.githubusercontent.com/Kurisu-public/img/master/image-20200910012027654.png)

TDD 会改变你写代码的习惯和结构, 并思考如何写出可以测试的代码, 提升代码质量

另外提一下, 代码质量需要注意的点有很多, 不要只注意 写的好不好康, 优雅不优雅, 还要注意 代码的 可测试性, 健壮性, 

### BDD

BDD 是以 TDD 为基底 提出来的东西, TDD 中 由于测试先行, 所以测试的目标就 决定了需求, 但如果由于需求的理解错误, 将导致代码直接变成无用代码.

我们先看几个 BDD 的例子: 

```go
// 用例名称 Scenario(情景)
Scenario: Check Inbox
  // 入参
  Given a user "Tom" with password "123"
  And a user "Jerry" with password "abc"
  And an email to "Tom" from "Jerry"
  // 断言
  When I sign in as "Tom" with password "123"
  Then I should see one email from "Jerry" in my inbox

// 用例名称 Scenario(情景)
Scenario: Redirect user to originally requested page after logging in
  // 入参
  Given a user "Tom" exists with password "123"
  And I am not logged in
  // 断言
  When I navigate to the home page
  Then I am redirected to the login form
  // 断言
  When I fill in "Username" with "tom"
  And I fill in "Password" with "123"
  And I press "Login"
  Then I should be on the home page
```

而 BDD 的重点是通过与利益相关者的讨论取得对预期的软件行为的清醒认识。它通过用自然语言书写非程序员可读的测试用例扩展了测试驱动开发方法。

行为驱动开发人员使用混合了领域中统一的语言的母语语言来描述他们的代码的目的。这让开发者得以把精力集中在代码应该怎么写，而不是技术细节上，而且也最大程度的减少了将代码编写者的技术语言与商业客户、用户、利益相关者、项目管理者等的领域语言之间来回翻译的代价。 

然而

然而

然而

由于我们做的不是业务开发……所以上面这些对我们来说, 更多的空间在于我们有更好的结构来书写我们的测试用例. 这里又要讲回前面没讲的 Ginkgo 上

#### Ginkgo BDD

### TDD Mock

## Other

1. 测试覆盖率
   1. Ginkgo -cover
2. 边缘用例
   1. 边缘用例的作用更多在于测试覆盖率, 想得到的列出来就好

## Integration Testing

### 依赖资源的生成

集成测试的重点在于 需要模拟环境和方便修改配置, 

// TODO
