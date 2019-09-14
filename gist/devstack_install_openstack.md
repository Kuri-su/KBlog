
在献祭了四个晚上之后, 终于在 ubuntu 上用 devstack 成功安装 openstack, 那么请问成功的秘诀是什么, 成功的秘诀就是, 别看 CSXN 上的那些教程, 一顿操作猛如虎, 最后完全安装不上. 一个 local.conf 文件几百行, 结果最后 几行的 local.conf 更加顶用, 另外千万别设置国内的 git 镜像, 虽然拉的慢, 但是能跑! 也不要拉那些很老的稳定分支, 直接拉 master 即可.

![](http://img.cdn.kuri.link/img/openstack_success_v.png)

下面将介绍如何在 Ubuntu 上安装 devstack, 绝对没有猛如虎的操作, 简单佛系低门槛安装.

1. 准备

打开你的 PS4 或者 准备一部电影 或者 打开你还没写完的代码 / 文章

2. 更新你的系统并且重启

```shell
$ sudo apt update
$ sudo apt -y upgrade
$ sudo apt -y dist-upgrade
$ sudo apt install git -y

$ sudo reboot
```

3. 创建并切换到 stack 用户

```shell
$ sudo useradd -s /bin/bash -d /opt/stack -m stack

# sudo 不需要密码
$ echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

$ sudo su - stack
```

4. 下载和配置 devstack

```shell
$ cd /opt/stack/
$ git clone https://git.openstack.org/openstack-dev/devstack
$ cd devstack
$ cat > local.conf <<EOF
[[local|localrc]]

# Password for KeyStone, Database, RabbitMQ and Service
ADMIN_PASSWORD=YOUPASSWORD
DATABASE_PASSWORD=YOUPASSWORD
RABBIT_PASSWORD=YOUPASSWORD
SERVICE_PASSWORD=YOUPASSWORD

# Host IP - get your Server/VM IP address from ip addr command
# 修改成你的机器的 IP
HOST_IP=192.168.10.100
EOF
```

如果你的系统是 19.04 之类的比较新的系统, 由于 openstack 未在该系统上测试过, 所以你需要在 local.conf 中加上

```shell
$ cat >> local.conf <<EOF
FORCE=yes
EOF
```

然后你可以设置下 APT 的镜像源, 以及 pip 的镜像源

设置 ustc 的 apt 镜像 (此处示例为 19.04, 如为其他版本则需要自行修改)

```shell
$ cat > /etc/apt/sources.list <<EOF
# See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
# newer versions of the distribution.
deb http://mirrors.ustc.edu.cn/ubuntu disco main restricted
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco main restricted

## Major bug fix updates produced after the final release of the
## distribution.
deb http://mirrors.ustc.edu.cn/ubuntu disco-updates main restricted
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-updates main restricted

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team. Also, please note that software in universe WILL NOT receive any
## review or updates from the Ubuntu security team.
deb http://mirrors.ustc.edu.cn/ubuntu disco universe
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco universe
deb http://mirrors.ustc.edu.cn/ubuntu disco-updates universe
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-updates universe

## N.B. software from this repository is ENTIRELY UNSUPPORTED by the Ubuntu
## team, and may not be under a free licence. Please satisfy yourself as to
## your rights to use the software. Also, please note that software in
## multiverse WILL NOT receive any review or updates from the Ubuntu
## security team.
deb http://mirrors.ustc.edu.cn/ubuntu disco multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco multiverse
deb http://mirrors.ustc.edu.cn/ubuntu disco-updates multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-updates multiverse

## N.B. software from this repository may not have been tested as
## extensively as that contained in the main release, although it includes
## newer versions of some applications which may provide useful features.
## Also, please note that software in backports WILL NOT receive any review
## or updates from the Ubuntu security team.
deb http://mirrors.ustc.edu.cn/ubuntu disco-backports main restricted universe multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-backports main restricted universe multiverse

## Uncomment the following two lines to add software from Canonical's
## 'partner' repository.
## This software is not part of Ubuntu, but is offered by Canonical and the
## respective vendors as a service to Ubuntu users.
# deb http://archive.canonical.com/ubuntu disco partner
# deb-src http://archive.canonical.com/ubuntu disco partner

deb http://mirrors.ustc.edu.cn/ubuntu disco-security main restricted
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-security main restricted
deb http://mirrors.ustc.edu.cn/ubuntu disco-security universe
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-security universe
deb http://mirrors.ustc.edu.cn/ubuntu disco-security multiverse
# deb-src http://mirrors.ustc.edu.cn/ubuntu disco-security multiverse
EOF
```

设置 pip 镜像

```shell
$ mkdir ~/.pip 
$ echo > ~/.pip/pip.conf <<EOF
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
EOF
```

强烈建议不要设置 git 镜像为国内, 血泪教训, (不清楚是同步问题还是怎样, 各种异常)

5. 运行 devstack 安装 openstack

```shell
$ ./stack.sh
```

然后你就可以继续做你的事情了, 等到安装完之后会显示安装所花的时间以及 账号密码, 以及 dashboard 的地址

> ps: 
>
> 中间可能会碰到获取 Etcd 失败的问题, 可以手动下载,然后移动到 `/opt/stack/devstack/files` 下

6. 访问 openstack 开始享用把
   
![](http://img.cdn.kuri.link/img/openstack_dashboard_v.jpg)


如果安装中碰到问题可以到 [kblog](https://github.com/Kuri-su/KBlog) 发 issue 讨论