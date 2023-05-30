+++
date = "2018-07-23"
title = "composer/satis 配置文件介绍"
slug = "composersatis-ca7qi"
categories = [ "gist" ]
tags = [ "gist" ]
katex = false
headline = ""
+++
## 前置操作(satis安装)

```bash
#这里的 /var/www/packagist.satis.cc 只是举个例子，以自己实际的文件夹为准
git clone https://github.com/composer/satis.git  /var/www/packagist.satis.cc
```

然后 在 nginx 加一个 `packagist.satis.cc` 的配置，指向 `/var/www/packagist.satis.cc/public`(略) 

## 例示配置

对里面的 `/var/www/packagist.satis.cc/satis.json` 文件的配置

```json
{
  "name": "Easy Repository",
  "homepage": "http://packagist.satis.cc",
  "repositories": [
    {"type": "vcs","url": "https://gitlab.local.com/aBigPackage/helloWorld"},
    {"type": "composer", "url": "https://packagist.laravel-china.org"}
  ],
  "archive": {
    "directory": "dist",
    "format": "tar",
    "skip-dev": true,
    "prefix-url": "http://packagist.satis.cc"
  },
  "abandoned":{
    "lastcraft/simpletest" : "simpletest/simpletest"
  },
  "require":{
    "monolog/monolog": "*",
    "darkaonline/l5-swagger": "~5.4",
    "laravel/laravel":"~5.4",
    "league/flysystem-aws-s3-v3":"*",
    "zircote/swagger-php":"*",
    "simpletest/simpletest":"*"
  },
  "require-all": false,
  "require-dependencies": true,
  "require-dev-dependencies": true
}
```

## 配置解释

```python
// Composer 私有源的名称，可随意
"name": "Easy Repository",

// 建立之后home页面的地址(用于查看这个源有哪些package)
"homepage": "http://packagist.satis.cc",

// 获取package的地址
/** 
  这里如果你是需要从私有的git源获取package的话，就参照如下这样写就可以了
  (带.git和不带.git似乎都ok)
  {"type": "vcs","url": "https://gitlab.local.com/aBigPackage/helloWorld"}
  
  如果你是需要构建内网的源，且内外网分离的情况下从外网获取package到内网，就参照下面这样写就好了
  (没有必要挨个去写需要引用的package的github地址)
  {"type": "composer", "url": "https://packagist.laravel-china.org"}
*/
"repositories": [
  {"type": "vcs","url": "https://gitlab.local.com/aBigPackage/helloWorld"},
  {"type": "composer", "url": "https://packagist.laravel-china.org"}
],

//如果需要satis将package下载到本地，直接从本地拉取，则需要配置这一项
//(内网源必须配置此项)
"archive": {
  "directory": "dist",

  //tar or zip
  "format": "tar",

  //是否需要为分支创建下载(默认只对有tag的提交创建下载)
  "skip-dev": false,
  "prefix-url": "http://packagist.satis.cc"
},

// 被抛弃或替换的package
"abandoned":{
  //true表示这个 package 真正的被抛弃
  "lox/simpletest":true
  //表示 lastcraft/simpletest 被 simpletest/simpletest 替换
  "lastcraft/simpletest" : "simpletest/simpletest"
},

// 需要 satis 的全部的 package
"require":{
  "monolog/monolog": "*",
  "darkaonline/l5-swagger": "~5.4",
  "laravel/laravel":"~5.4",
  "league/flysystem-aws-s3-v3":"*",
  "zircote/swagger-php":"*",
  "simpletest/simpletest":"*"
},

//是否需要将配置的源的全部的package都拉取
"require-all": false,
//是否自动解决依赖
"require-dependencies": true
//是否自动解决dev依赖
"require-dev-dependencies": true
```

## build
在  `/var/www/packagist.satis.cc` 文件夹下执行命令：

```bash
# 全部需要的package重新检查更新并构建
# 强烈推荐追加 --skip-errors 参数，否则碰到某些已经被放弃的 package 会卡住构建
php bin/satis build satis.json public/ --skip-errors

# 仅仅重新检查更新并构建指定的几个包
php bin/satis build satis.json public/ A/package B/other-package

# 如果只想扫描单个存储库并更新其中找到的所有包，请将VCS存储库URL作为可选参数传递：
php bin/satis build --repository-url https://only.my/repo.git satis.json public/
```

## 使用 Composer 私有源

有两种方法可以让composer去使用私有源

### 局部
1. 在 composer.json 里添加
```json
"repositories": [
  {
    "type": "composer",
    "url": "http://packagist.satis.cc"
  }
],
```

### 全局
2. 将composer全局的源换成私有源
```bash
composer config -g repo.packagist composer https://packagist.laravel-china.org
```

### 引入

在引入的时候，如果因为`其他 package 已经被改的面目全非导致报错 无法引入你需要的package`，推荐 `--ignore-platform-reqs`参数

```bash
composer require xxx/xxxpackage --ignore-platform-reqs
```

## FAQ

1. composer 报 SSL 相关问题
  * 这个可以网上找一下解决方案，错误信息搜一下就有了。。。

2. 对 satis 执行 build 的时候的参数有没有什么文档可以看啊！
  * 推荐直接在命令行下使用以下命令看参数列表，快捷方便
```bash
php bin/satis build --help
//---- or ----
php bin/satis --help
```


3. `待补充`

## more 

个人认为主要的配置项大概是这么些，如果有更多需求，例如需要http验证，ssl验证等的配置请查阅 [官方文档](https://getcomposer.org/doc/articles/handling-private-packages-with-satis.md)

---

> 参考来源:  
> * [Composer satis: 官方手册 (对各个配置项的介绍极度详细，推荐)](https://getcomposer.org/doc/articles/handling-private-packages-with-satis.md)
> * <https://laravel-china.org/topics/1900/use-satis-to-build-a-private-composer-warehouse>
> 
> 在此基础上进行 修改，整理，编辑
> 
> ---------
>
> links:
> * [composer/satis](https://github.com/composer/satis)

