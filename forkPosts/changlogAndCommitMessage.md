# commit message 编写指北

### 编写规范化 commit message 的目的

1. 提供更多的历史信息,方便快速浏览和暂时回滚
    > 可以使用命令 `git log HEAD --pretty=format:%s`  预览此前的提交信息.

2. 可以快速过滤某些 commit (比如文档改动) , 以便快速查找信息

3. 可以直接从 commit 生成 Change Log (过滤出 feature 和 fix type 的 提交即可)

### Git commit日志参考案例
  * [angular](https://github.com/angular/angular)
  * [commit-message-test-project](https://github.com/cpselvis/commit-message-test-project)
  * [babel-plugin-istanbul](https://github.com/istanbuljs/babel-plugin-istanbul)
  * [conventional-changelog](https://github.com/conventional-changelog/conventional-changelog)

### 总体方案
参考 `Angular` 的 Git commit 提交规范, 也有参考 `Tencent IVWeeb` 团队 对于 Git commit 和工作流规范的总结
![]()

### Git commit 日志格式规范

```
<type>(<scope>): <subject>
<BLANK LINE //空一行>
<body>
<BLANK LINE //空一行>
<footer>
```

每次提交, `commit message` 都包括三个部分 : `Header`, `Body`, `Footer` .

其中, Header 是必须的, Body 和 Footer 可以忽略.

不管是 哪一个部分, 任何一行都不得查过72个字符(或 100个字符 ). 这是为了避免自动换行影响美观

##### Header
Header 部分尽量只有一行, 包括三个字段: `type`(必须) , `scopt`(可选) , `subject`(必须)

1. type 
    `type` 用于说明 commit 的类别 , 只允许使用下面的七个标识
    ```
    feat    : 新功能,新特性(feature)
    fix     : 修复 Bug
    docs    : 仅仅修改了文档，比如 README, CHANGELOG, CONTRIBUTE等等(documentation)
    style   : 仅仅修改了空格、格式缩进、都好等等，不改变代码逻辑(不影响代码运行的变动)
    refactor: 代码重构，没有加入新功能或者修复bug......
    perf    : 优化相关，比如提升性能、体验......
    test    : 测试用例，包括单元测试、集成测试......
    chore   : 改变构建流程、或者增加依赖库、辅助工具......
    revert  : 回滚到上一个版本
    ```
    如果 `type` 为 `feat` 和 `fix`, 则该 commit 肯定会出现在 Change log 之中. 其他情况可以自行决定是否需要放入 ChangeLog中.

2. scope
    `scope` 用于说明 commit 影响的范围, 比如 数据层, 控制层, 视图层...... , 视项目的不同而不同

3. subject 
    `subject` 是 commit 目的的简短描述 , 不超过50个字符
    ```
        # 以动词开头,使用第一人称现在时, 比如 change, 而不是 changed 或者 changes
        # 第一个字母小写
        # 结尾不加句号
    ```

##### Body
Body 部分是对本次 commit 的详细描述，可以分成多行。下面是一个范例。
```
    More detailed explanatory text, if necessary.  Wrap it to 
    about 72 characters or so. 

    Further paragraphs come after blank lines.

    - Bullet points are okay, too
    - Use a hanging indent
```

有两个注意点 : 
1. 使用第一人称现在时，比如使用change而不是changed或changes。
2. 应该说明代码变动的动机，以及与以前行为的对比。

##### Footer
Footer 部分只用于两种情况.
1. 不兼容改动
    如果当前代码与上一个版本不兼容,则 Footer 部分 以 `BREAKING CHANGE` 开头, 后面是对变动的描述, 以及变动理由和迁移方法
    ```js
    BREAKING CHANGE: isolate scope bindings definition has changed and
    the inject option for the directive controller injection was removed.
    
    To migrate the code follow the example below:
    
    Before:
    
    scope: {
      myAttr: 'attribute',
      myBind: 'bind',
      myExpression: 'expression',
      myEval: 'evaluate',
      myAccessor: 'accessor'
    }
    
    After:
    
    scope: {
      myAttr: '@',
      myBind: '@',
      myExpression: '&',
      // myEval - usually not useful, but in cases where the expression is assignable, you can use '='
      myAccessor: '=' // in directive's template change myAccessor() to myAccessor
    }
    
    The removed `inject` wasn't generaly useful for directives so there should be no code using it.
    ```
2. 关闭 Issue
    ```
        Closes #111
    ```
    ```
        Closes #112, #122, #132
    ```

##### 对于 Revert type 的 规范
如果当前 commit 用于撤销以前的 commit，则必须以 `revert:` 开头，后面跟着被撤销 Commit 的 Header
```
revert: feat(pencil): add 'graphiteWidth' option

This reverts commit 667ecc1654a317a13331b17617d973392f415f02.
```
Body部分的格式是固定的，必须写成`This reverts commit <hash>.`，其中的hash是被撤销 commit 的 SHA 标识符。

如果当前 commit 与被撤销的 commit，在同一个发布（release）里面，那么它们都不会出现在 Change log 里面。如果两者在不同的发布，那么当前 commit，会出现在 Change log 的 `Reverts` 小标题下面。



**Tencent IVWeb 的 格式要求:**
```
# 标题行：50个字符以内，描述主要变更内容
#
# 主体内容：更详细的说明文本，建议72个字符以内。 需要描述的信息包括:
#
# * 为什么这个变更是必须的? 它可能是用来修复一个bug，增加一个feature，提升性能、可靠性、稳定性等等
# * 他如何解决这个问题? 具体描述解决问题的步骤
# * 是否存在副作用、风险? 
#
# 尾部：如果需要的化可以添加一个链接到issue地址或者其它文档，或者关闭某个issue。
```

#### Git分支与版本发布规范

* 基本原则：master为保护分支，不直接在master上进行代码修改和提交。
* 开发日常需求或者项目时，从master分支上checkout一个feature分支进行开发或者bugfix分支进行bug修复，功能测试完毕并且项目发布上线后，将feature分支合并到主干master，并且打Tag发布，最后删除开发分支。分支命名规范：
    * 分支版本命名规则：分支类型 _ 分支发布时间 _ 分支功能。比如：feature_20170401_fairy_flower
    * 分支类型包括：feature、 bugfix、refactor三种类型，即新功能开发、bug修复和代码重构
    * 时间使用年月日进行命名，不足2位补0
    * 分支功能命名使用snake case命名法，即下划线命名。
* Tag包括3位版本，前缀使用v。比如v1.2.31。Tag命名规范：
    * 新功能开发使用第2位版本号，bug修复使用第3位版本号
    * 核心基础库或者Node中间价可以在大版本发布请使用灰度版本号，在版本后面加上后缀，用中划线分隔。alpha或者belta后面加上次数，即第几次alpha：
        * v2.0.0-alpha.1
        * v2.0.0-belta.1
* 版本正式发布前需要生成changelog文档，然后再发布上线。

`updateing 接入说明`


> 文章源 来自: 
> * https://ivweb.io/topic/58ba702bdb35a9135d42f83d -> https://github.com/feflow/git-commit-style-guide
> * http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html
> * https://docs.google.com/document/d/1QrDFcIiPjSLDn3EL15IJygNPiHORgU1_OOAqWjiDU5Y/edit#heading=h.greljkmo14y0  
> 
> 在此基础上有做 修改 和 编辑

