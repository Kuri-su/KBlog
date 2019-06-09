
首先, 修改 `/etc/resolv.conf` 是没有用的, 因为 Ubuntu 上有 systemd-resolvd 服务, 所以要么直接关掉这个服务, 然后去修改 `/etc/resolv.conf` 添加上 DNS 服务器的地址

```shell
sudo systemctl stop systemd-resolvd
sudo systemctl disable systemd-resolvd
sudo systemctl mask systemd-resolvd
```

或者 修改 `/etc/sys/resolved.conf` 文件, 在 `DNS` 那一行添加上自己的 DNS

```
[Resolve]
DNS=8.8.8.8 8.8.4.4 114.114.114.114
LLMNR=no
```
然后重启服务
```shell
sudo systemctl restart systemd-resolvd
```
