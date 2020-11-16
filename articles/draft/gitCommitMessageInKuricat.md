# git commit message in kuricat Studio

[TOC]

此前有一篇 [丢到垃圾桶的文章](https://github.com/Kuri-su/KBlog/blob/master/articles/trash/changlog_and_commit_message.md) 参考 Google 上搜的到的 `Git Commit Message 规范` 做了个总结, 但在 实践接近三年后, 笔者发现自己能够记住的只有 `feat`&& `fix`&&`docs` 这三个提交类型, 于是乎决定 明确 在 `KuriCat stuidio` 用的 Git Commit Message 规范, 这套规范后续或许将有所发展. 

这个规范仅仅做最简单的约束, 不会提及任何 lint 或者 第三方工具, 心情不好的时候根本不想理那些复杂的 Git Commit Message 规范, 尽量还是把注意力放在关键的地方.

## 结构

```xml
<type(更改类型)>(<scope(影响范围)>): <subject(主题)>
<BLANK LINE (空一行)>
<body>
<BLANK LINE (空一行)>
<footer>
```

和  Angular 的规范一样的结构, 大多数情况是只写第一行即可, 第一行的元素全部必填, 后面的 body 和 footer 是选填. 

* Body 在于对目前更变的详细描述, 以及一些更变动机
* Footer 通常只用于 `描述不兼容改动` 和 `关闭 issue ` 的场景

尽量每行在 72 字以内, 方便阅读, 超过的话手动换行即可

### 更变类型

```go
// 代码相关
feat: 新特性 / 代码重构 / 性能和体验优化
fix : 修复
style : 代码整理, 不影响逻辑

// 测试和文档
docs: 更新文档
test: 添加测试用例
other: 修改依赖版本 / 修改 ci ...
stash: 提交暂存代码
```



