
1. 前往 <https://uappexplorer.com/snaps> 搜索需要的 snap 包， 例如 `RedisDesktopManager`

1. 下载对应架构的 snap 包

1. 下载完成后，在同一目录执行以下命令即可
```bash
$ sudo snap install xxx.snap --dangerous
```

---- 

追加一种来自 [junkoBlog](https://blog.shunwww.cn/2019/02/19/yuque/proxy-snap/) 的方法

由于直接设置 http_proxy 环境变量无法设置上, 作者在 snapd 中直接设置 proxy, 方法如下:

```bash
# 前置操作, 修改  systemctl edit 使用的编辑器为 VIM, 如果不介意 Nano 可以跳过这一步
$ sudo echo "export SYSTEMD_EDITOR=\"/bin/vim\" " >> /etc/profile
$ source /etc/profile

# 开始设置代理
$ sudo systemctl edit snapd
加上：
[Service]
Environment="http_proxy=http://127.0.0.1:port"
Environment="https_proxy=http://127.0.0.1:port"

#保存退出。
$ sudo systemctl daemon-reload
$ sudo systemctl restart snapd
```

实测相当有效


