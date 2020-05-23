
> 过去的做法：  
> 1. ~~前往 <https://uappexplorer.com/snaps> 搜索需要的 snap 包， 例如 `RedisDesktopManager`~~
> 1. ~~下载对应架构的 snap 包~~
> 1. ~~下载完成后，在同一目录执行以下命令即可~~

但现在 `uappexplorer` 已经下线, 我们无法从 `uappexplorer` 中获取 SnapApp 的 `.snap 文件` .  但我们仍然可以通过 snapcraft API 获取 `.sanp 文件` , 以下方法来自 [askUbuntu](https://askubuntu.com/questions/1075694/how-to-get-snap-download-url) :

1. 通过 [snapcraft.io](snapcraft.io) 页面找到你需要的 snap 包的 url , 这里以 `redisDesktopManager` 为例, 它的url 是 `https://snapcraft.io/redis-desktop-manager`

2. 使用一个 http header 中带有 `Snap-Device-Series` 的 get 请求 `api.snapcaft.io` 获取 snap 的下载链接, curl 方式如下所示

   ```shell
   # 这里将上面 获取到的 url 中的 redis-desktop-manager 填入下面 请求的地址中
   # curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/{{packageName}}
   $ curl -H 'Snap-Device-Series: 16' http://api.snapcraft.io/v2/snaps/info/redis-desktop-manager # | jq
   ```

   然后我们会得到一个类似于这样的响应(因篇幅原因, 部分输出省略)

   ```json
   {
     "channel-map": [
       {
         "channel": {
           "architecture": "amd64",
           "name": "stable",
           // ...
         },
         "download": {
           //...
           "size": 416350208,
           "url": "https://api.snapcraft.io/api/v1/snaps/download/Iw3a6EauULwaud5DO0ixtrJg8o6VXaey_335.snap"
         },
         "revision": 335,
         "type": "app",
         "version": "2019.5-c57dd5f"
       },
       {
         "channel": {
           "architecture": "arm64",
           "name": "stable",
           // ...
         },
         "created-at": "2018-11-02T13:22:00.292564+00:00",
         "download": {
           //...
           "size": 405401600,
           "url": "https://api.snapcraft.io/api/v1/snaps/download/Iw3a6EauULwaud5DO0ixtrJg8o6VXaey_180.snap"
         },
         "revision": 180,
         "type": "app",
         "version": "0.9.8+git"
       },
         // ......
     ]
   }
   ```

3. 我们可以看到这里返回了 不同架构对应的 `.snap 文件` 的 `info` 和 url , 接着我们从中使用到自己需要的平台的对应的 url 进行下载即可, 这里假设我们使用的时 `amd64` , 那么使用以下命令下载即可: 

   ```shell
   $ wget https://api.snapcraft.io/api/v1/snaps/download/Iw3a6EauULwaud5DO0ixtrJg8o6VXaey_335.snap 
   ```

4. 下载完成后进行安装即可: 

    ```shell
    $ sudo snap install xxx.snap --dangerous
    ```

----

追加一种来自 [junkoBlog](https://blog.shunwww.cn/2019/02/19/yuque/proxy-snap/) 的方法

由于直接设置 http_proxy 环境变量无法设置上, 作者在 snapd 中直接设置 proxy, 方法如下:

```bash
# 前置操作, 修改  systemctl edit 使用的编辑器为 VIM, 如果不介意 Nano 可以跳过这一步
$ sudo tee -a /etc/profile <<-'EOF' 
export SYSTEMD_EDITOR="/bin/vim"
EOF
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