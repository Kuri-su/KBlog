{"title": "Git Large File Storage 初见指南","description": "Git Large File Storage 快速入门","category": "Git","tag": ["Git"],"page_image":"/assets/git-large-file-storage.jpg"}

[TOC]

在 Git 中我们的最佳实践是 **不要使用 Git 跟踪大型的二进制文件**, 但是往往可能有一些特殊的需求. 所以我们可以考虑使用 `Git Large File Storage (LFS)` 来处理.

## Git Large File Storage 是什么

[`Git Large File Storage (LFS)`](https://github.com/git-lfs/git-lfs) 是一个由 GitHub 开发的 Git 扩展项目, 于 2013/09/22 创建. 用于增强 Git 对大文件追踪的支持.

众所周知, Git 在储存二进制文件时, 效率堪忧, 因为 Git 默认会压缩和储存每一次提交的快照, 如果二进制文件很多, 会使得 Git 的 clone 效率变得非常低.

如何解决这个问题呢, 那就要介绍 Git LFS 了.
> Git LFS 处理大型二进制文件的方式是用 "文件指针" 进行替换, 这些文本指针实际上是包含二进制文件信息的文本文件, 大小不到 1kb。文本指针存储在 Git 中，而大文件本身通过 HTTPS 托管在 Git LFS 服务器上。

那么下面演示下如何安装和使用 Git LFS

## 如何使用 Git LFS

### 安装 Git LFS

你可以通过两种方式安装 Git LFS

* APT / brew
* 二进制包

#### APT 的方式安装

前往 [git-lfs.github.com](https://git-lfs.github.com/) 点击 `Install Vx.x.x via PackageCloud` 在跳转的页面中选择合适的安装方式, 目前支持的安装方式有 `deb`,`rpm`,`node`,`python`,`gem`

然后运行如下

```bash
# In Ubuntu
# 检查和安装 apt Repository
$ curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
# 通过 apt 安装　git-lfs
$ sudo apt install git-lfs

# In MacOS
$ brew install git-lfs
```

还支持通过 `deb`,`rpm`,`node`,`python`,`gem` 的方式安装,[详细参阅](https://packagecloud.io/github/git-lfs/install)

#### 二进制包

前往 [git-lfs release](https://github.com/git-lfs/git-lfs/releases) 页面, 下载合适的平台的二进制包, 然后运行包中的 `install.sh`

例如位于 linux_amd64 , 运行如下指令即可

```bash
$ tar -zxvf git-lfs-linux-amd64-v2.7.2.tar.gz
$ tree .
    ├── CHANGELOG.md
    ├── git-lfs
    ├── git-lfs-linux-amd64-v2.7.2.tar.gz
    ├── install.sh
    └── README.md
$ sudo ./install.sh
```

-----

### Git LFS 使用介绍

那么如何在项目中使用 Git LFS 呢, 让我们从零开始尝试使用 Git LFS 吧

```bash
# 创建这个 DEMO 的文件夹
$ mkdir git-lfs-demo && cd git-lfs-demo

# 在当前目录创建一个 20M 的大文件
$ dd if=/dev/zero of=a-big-file.pdf bs=1M count=20

# git 初始化
$ git init

# 将 a-big-file.pdf 使用 git lfs
# 你也可以利用 git lfs track "*.pdf" 指定 全部的 pdf 文件
$ git lfs track "a-big-file.pdf"

# 接着添加远程库
$ git remote add origin git@github.com:x/x.git

# 然后提交文件
$ git add -A && git commit -a -m "git lfs test" && git push origin master

# 然后访问 github 接口查看该文件的大小
$ curl https://api.github.com/repos/x/x | grep size

# 可以看到这里的 size 写着 0, 因为是 m 为单位, 所以意味着我们上传的东西远小于 1M
# 至此, 将二进制文件 git lfs 的形式上传到 git 仓库成功
```

git-lfs 常用的指令包括如下:

```bash
$ git lfs track
# 将一个或者一类文件以 git lfs 的方式加入到版本控制中 (实质是修改 .gitattributes 文件)
$ git lfs untrack
# 将一个或者一类文件从 仓库中移除

$ git lfs status
# 类似于 git status , 显示 git lfs 方式的文件在 暂存区的状态

$ git lfs lock
# 锁定一个或者一些文件, 只允许当前的用户对这些文件进行修改, 防止在多人协作的场景下冲突
$ git lfs unlock
# 同上, 解锁一个或者一些文件

$ git lfs migrate
# 用来将当前已经被 git 储存库保存的文件以 git lfs 的保存 (将 git 对象转为 lfs 对象)
# 例如如果将当前远程不存在的的所有 pdf 文件清除
# git lfs migrate import --include="*.pdf"
#
# 如果是已经上传到中心服务器的内容, 则需要指定分支 (可能需要 push --force)
# git lfs migrate import --include="*.mp4" --include-ref=refs/origin/master --include-ref=refs/origin/dev --include-ref=refs/origin/test
#
# 然后使用如下命令清理 .git 目录
# git reflog expire --expire-unreachable=now --all && git gc --prune=now

$ git lfs ls-files
# 展示全部使用 git lfs 方式加入版本控制的文件

$ git lfs prune
# 删除全部旧的 Git LFS 文件

$ git lfs fetch
$ git lfs pull
$ git lfs push
$ git lfs checkout
# 正常情况下会随着 git pull/push 一起执行
# 如果在 git pull/push 的过程中断了, 导致二进制文件没有被拉取的时候, 可以使用这些命令
```

可以通过 `git lfs --help` 指令看到 `git lfs` 的全部指令,

## 各个平台的支持情况

为了防止滥用, 各个平台对 Git LFS 有不同的限制

### GitHub

`GitHub` 的全部 Repo 的 Git LFS 内容不得超过 `1G`, 流量限制 `1G`, 限制的还是比较严格的, [详情](https://github.com/settings/billing)

可以使用每个月 `$5` 的钞能力增加限制, 每个月订阅的费用每上升 `$5`, 内容大小和流量限制上升 `50G`.

### BitBucket

BitBucket 免费账号 File Storage 限制为 1GB, $2/month 的 `Standard` 账号为 5GB $5/month 的`Premium` 账号为 10GB

### GitLab

GitLab 没有找到 Git LFS 限制的相分描述, 但是他们有提到单个 Repo 的储存限制为 10G, 想必是包含了 Git LFS 内容的大小在内.

### Gitee

码云中, Git LFS 功能只对付费企业和个人开放, 内容大小限制未知.

## 结语

虽然 Git LFS 能给我们在大文件上传 版本库带来很多便利, 但是还是推荐谨慎使用.


> ref:
> 
> https://git-lfs.github.com/
>
> https://github.com/git-lfs/git-lfs
>
> https://github.com/git-lfs/git-lfs/wiki/Tutorial
> 
> https://about.gitlab.com/2015/04/08/gitlab-dot-com-storage-limit-raised-to-10gb-per-repo/
> 
> https://cloud.tencent.com/developer/article/1010589
> 
> https://blog.csdn.net/aixiaoyang168/article/details/76012094
> 
> https://www.oschina.net/news/61374/github-lfs
> 
> https://www.infoq.cn/article/2015/04/github-large-file-storage
> 
> https://help.github.com/en/articles/collaboration-with-git-large-file-storage
> 
> https://www.jianshu.com/p/ed2b6081f529
> 
> https://blog.csdn.net/aixiaoyang168/article/details/76012094
> 
> https://gitee.com/help/articles/4235#article-header0