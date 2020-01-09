# protoc-gen-go 生命周期

# protoc-gen-go 源码阅读

## 目录结构

```shell
.
├── descriptor             
│   ├── descriptor.pb.go
│   └── descriptor.proto
├── ...
├── generator
│   ├── generator.go
│   ├── internal
│   │   └── remap
│   │       ├── remap.go
│   │       └── ...
│   └── ...
├── ...
├── ...
├── main.go
└── plugin
    ├── plugin.pb.go
    ├── plugin.pb.golden
    └── plugin.proto
```



## protoc-gen-go -> main.go

```go
package main

import (
   "io/ioutil"
   "os"

   "github.com/golang/protobuf/proto"
   "github.com/golang/protobuf/protoc-gen-go/generator"
)

func main() {
   // 首先创建一个 代码生成器 generator
   // 这会 new 一个 Generator 的结构体， 关于结构体的字段翻译会放在下面
   // 然后会初始化 Generator的 bytes.Buffer 对象 以及
   // Request 会初始化成 全新的 CodeGeneratorRequest 对象
   // Response 会初始化成 全新的 CodeGeneratorResponse 对象
   // CodeGeneratorResponse 对象中会保存着代码生成过程中的错误状态信息.
   // 而 上面這兩個結構體的方法和字段被定義在 plugin.proto
   // 下面會列出
   g := generator.New()

   // 从标准输出读入 CodeGeneratorRequest 信息
   data, err := ioutil.ReadAll(os.Stdin)
   if err != nil {
      g.Error(err, "reading input")
   }

   // 将读取到的信息序列化後, 得到 CodeGeneratorRequest
   if err := proto.Unmarshal(data, g.Request); err != nil {
      g.Error(err, "parsing input proto")
   }

   if len(g.Request.FileToGenerate) == 0 {
      g.Fail("no files to generate")
   }

    // 將 CodeGeneratorRequest 中傳遞給代碼生成器的參數 設置到 protoc 插件的代碼生成器中.
   g.CommandLineParameters(g.Request.GetParameter())

   // Create a wrapped version of the Descriptors and EnumDescriptors that
   // point to the file that defines them.
    // 前面的proto.Unmarshal(...)操作将stdin中的请求反串行化成了CodeGeneratorRequest，
    // 这里的g.WrapTypes()将请求中的一些descriptors进行进一步封装，方便后面引用
   g.WrapTypes()

    // ??
   g.SetPackageNames()
    // ??
   g.BuildTypeNameMap()

   // 生成所有的源代碼文件
   g.GenerateAllFiles()

   // Send back the results.
    // 反序列化 Response 後 , 寫入到 stdout
   data, err = proto.Marshal(g.Response)
   if err != nil {
      g.Error(err, "failed to marshal output proto")
   }
   _, err = os.Stdout.Write(data)
   if err != nil {
      g.Error(err, "failed to write output proto")
   }
}
```

// Generator 

```go
// Generator is the type whose methods generate the output, stored in the associated response structure.
type Generator struct {
	*bytes.Buffer

	Request  *plugin.CodeGeneratorRequest  // The input.
	Response *plugin.CodeGeneratorResponse // The output.

	Param             map[string]string // Command-line parameters.
	PackageImportPath string            // Go import path of the package we're generating code for
	ImportPrefix      string            // String to prefix to imported package file names.
	ImportMap         map[string]string // Mapping from .proto file name to import path

	Pkg map[string]string // The names under which we import support packages

	outputImportPath GoImportPath                   // Package we're generating code for.
	allFiles         []*FileDescriptor              // All files in the tree
	allFilesByName   map[string]*FileDescriptor     // All files by filename.
	genFiles         []*FileDescriptor              // Those files we will generate output for.
	file             *FileDescriptor                // The file we are compiling now.
	packageNames     map[GoImportPath]GoPackageName // Imported package names in the current file.
	usedPackages     map[GoImportPath]bool          // Packages used in current file.
	usedPackageNames map[GoPackageName]bool         // Package names used in the current file.
	addedImports     map[GoImportPath]bool          // Additional imports to emit.
	typeNameToObject map[string]Object              // Key is a fully-qualified name in input syntax.
	init             []string                       // Lines to emit in the init function.
	indent           string
	pathType         pathType // How to generate output filenames.
	writeOutput      bool
	annotateCode     bool                                       // whether to store annotations
	annotations      []*descriptor.GeneratedCodeInfo_Annotation // annotations to store
}
```

// CodeGeneratorRequest  

```protobuf
// An encoded CodeGeneratorRequest is written to the plugin's stdin.
// 一個 encode 之後的 CodeGeneratorRequest 將會寫到 plugin 的 standfard input(標準輸入)
message CodeGeneratorRequest {
  // The .proto files that were explicitly listed on the command-line.  The
  // code generator should generate code only for these files.  Each file's
  // descriptor will be included in proto_file, below.
  // protoc 命令執行時, 我們在命令行中列出來需要驚醒處理的 .proto 文件的名稱, 代碼生成器應該只爲這些 .proto 文件生成源代碼文件.每一個 .proto 文件成功解析之後, 會生成一個 FileDescriptorProto 對象, 這個對象會加入到下面的 proto_file 字段中.
  repeated string file_to_generate = 1;

  // The generator parameter passed on the command-line.
  // protoc 命令行程序中傳遞給插件程序 代碼生成器的參數代碼
  optional string parameter = 2;

  // FileDescriptorProtos for all files in files_to_generate and everything
  // they import.  The files will appear in topological order, so each file
  // appears before any file that imports it.
  //
  // protoc guarantees that all proto_files will be written after
  // the fields above, even though this is not technically guaranteed by the
  // protobuf wire format.  This theoretically could allow a plugin to stream
  // in the FileDescriptorProtos and handle them one by one rather than read
  // the entire set into memory at once.  However, as of this writing, this
  // is not similarly optimized on protoc's end -- it will store all fields in
  // memory at once before sending them to the plugin.
  // 
  // protoc 命令行 中列出的所有的 .proto 文件都被添加到了 file_to_generate 字段中, 
  // 這些文件和他們引入的文件會以拓撲順序排序, 也就是被引入的 proto 文件會出現在 引用他們的 proto 文件的前面, 這樣可以允許插件流式傳輸, 但是目前的實現沒有這樣的優化, 僅僅一次將所有的信息通過 stdin 輸入給插件
  //
  // Type names of fields and extensions in the FileDescriptorProto are always
  // fully qualified.
  repeated FileDescriptorProto proto_file = 15;

  // The version number of protocol compiler.
  optional Version compiler_version = 3;
}
```

// CodeGeneratorResponse

```protobuf

// The plugin writes an encoded CodeGeneratorResponse to stdout.
// 插件會將 encode 的 CodeGeneratorResponse 結構體輸出到 stdout
message CodeGeneratorResponse {
  // Error message.  If non-empty, code generation failed.  The plugin process
  // should exit with status code zero even if it reports an error in this way.
  //
  // This should be used to indicate errors in .proto files which prevent the
  // code generator from generating correct code.  Errors which indicate a
  // problem in protoc itself -- such as the input CodeGeneratorRequest being
  // unparseable -- should be reported by writing a message to stderr and
  // exiting with a non-zero status code.
  // 如果錯誤信息非空則標識代碼生成失敗, 然而這種情況下, 仍然應該返回一個狀態0
  // 
  // 但是如果錯誤是由 protoc 引起, 例如 由於輸入的字串無法成功被序列化成 CodeGeneratorRequest 對象, 那麼這種情況應該 返回一個非0狀態碼標識異常.
  optional string error = 1;

  // Represents a single generated file.
  // 描述待生成的 源代碼文件
  message File {
    // The file name, relative to the output directory.  The name must not
    // contain "." or ".." components and must be relative, not be absolute (so,
    // the file cannot lie outside the output directory).  "/" must be used as
    // the path separator, not "\".
    //
    // If the name is omitted, the content will be appended to the previous
    // file.  This allows the generator to break large files into small chunks,
    // and allows the generated text to be streamed back to protoc so that large
    // files need not reside completely in memory at one time.  Note that as of
    // this writing protoc does not optimize for this -- it will read the entire
    // CodeGeneratorResponse before writing files to disk.
    // 保存待生成的 源代碼文件對於 輸出目錄的文件名
    optional string name = 1;

    // If non-empty, indicates that the named file should already exist, and the
    // content here is to be inserted into that file at a defined insertion
    // point.  This feature allows a code generator to extend the output
    // produced by another code generator.  The original generator may provide
    // insertion points by placing special annotations in the file that look
    // like:
    //   @@protoc_insertion_point(NAME)
    // The annotation can have arbitrary text before and after it on the line,
    // which allows it to be placed in a comment.  NAME should be replaced with
    // an identifier naming the point -- this is what other generators will use
    // as the insertion_point.  Code inserted at this point will be placed
    // immediately above the line containing the insertion point (thus multiple
    // insertions to the same point will come out in the order they were added).
    // The double-@ is intended to make it unlikely that the generated code
    // could contain things that look like insertion points by accident.
    //
    // For example, the C++ code generator places the following line in the
    // .pb.h files that it generates:
    //   // @@protoc_insertion_point(namespace_scope)
    // This line appears within the scope of the file's package namespace, but
    // outside of any particular class.  Another plugin can then specify the
    // insertion_point "namespace_scope" to generate additional classes or
    // other declarations that should be placed in this scope.
    //
    // Note that if the line containing the insertion point begins with
    // whitespace, the same whitespace will be added to every line of the
    // inserted text.  This is useful for languages like Python, where
    // indentation matters.  In these languages, the insertion point comment
    // should be indented the same amount as any inserted code will need to be
    // in order to work correctly in that context.
    //
    // The code generator that generates the initial file and the one which
    // inserts into it must both run as part of a single invocation of protoc.
    // Code generators are executed in the order in which they appear on the
    // command line.
    //
    // If |insertion_point| is present, |name| must also be present.
    // 上面一段話待翻譯
    // 寫入到源代碼中的插入點位置, 方便後面的插件在插入點處驚醒擴展其他內容
    optional string insertion_point = 2;

    // The file contents.
    // 寫入到文件或者文件插入點的內容
    optional string content = 15;
  }
  // 所有待生成源代碼文件列表
  repeated File file = 15;
}
```



// TODO [https://hitzhangjie.github.io/2017/05/23/Protoc%E5%8F%8A%E6%8F%92%E4%BB%B6%E5%B7%A5%E4%BD%9C%E5%8E%9F%E7%90%86%E5%88%86%E6%9E%90(%E7%B2%BE%E5%8D%8E%E7%89%88).html#243-proto-gen-go-generator%E5%AE%9E%E7%8E%B0%E5%88%86%E6%9E%90](https://hitzhangjie.github.io/2017/05/23/Protoc及插件工作原理分析(精华版).html#243-proto-gen-go-generator实现分析)



ref: 

> [Protoc及其插件工作原理分析(精华版)](https://hitzhangjie.github.io/2017/05/23/Protoc及插件工作原理分析(精华版).html)
>
> [protoc-gen-go 介绍与源代码分析](https://blog.csdn.net/u013272009/article/details/100018002)

