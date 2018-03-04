# 离线安装 GitBook-cli

### 前置准备
安装 `node.js` , 参照官网步骤 [link](https://nodejs.org/en/)
  
### 步骤
1. 首先在有网的机器上使用指令安装 `gitbook-cli` ( 也需要安装 node.js )
```shell
  npm install -g gitbook-cli
```

2. 接着前往目录 `C:\Users\${yourUsername}\AppData\Roaming\npm` 复制以下 两个文件 和 一个文件夹  
  ```
      node_modules/gitbook-cli
      gitbook
      gitbook.cmd
  ```    
将以上三个文件复制到离线的电脑的 `C:\Users\${yourUsername}\AppData\Roaming\npm` 目录内即可(文件夹复制到 `node_modules` 内)

### 测试
启动终端运行 `gitbook` , 如果出现提示则运行成功 


> 在线安装只需要 前往[GitbookIO/gitbook-cli](https://github.com/GitbookIO/gitbook-cli) 根据 `readme.md` 的提示安装即可
