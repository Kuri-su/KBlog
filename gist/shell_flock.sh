
[TOC]

在 Linux 中的两条进程同时编辑文件产生并发冲突时, 我们第一反应就会想到使用 ` 锁 ` 来解决这个问题, 这里就介绍 `flock`,

## flock

flock 有三种写法 :

1. flock [options] <file>|<directory> <command> [<argument>...]
1. flock [options] <file>|<directory> -c <command>
1. flock [options] <file descriptor number(fd)>

### 将锁加在文件上以防止冲突
flock 可以将锁加在某个文件上 (以及文件夹), 来防止并发冲突. 你可以使用如下两种方式, 执行你的 shell

```shell
# 第一种方式
$ cd /xxx/xxx/myProject && flock -n /tmp/fffflock.lock  "git reset HEAD --hard"
# 第二种方式
$ flock -n /tmp/fffflock.lock -c  "cd /xxx/xxx/myProject && git reset HEAD --hard"
```

第一种方式会认为第一个词 git 是命令, 然后后面的全部是参数, 所以如果使用和第二种一样的写法, 会导致执行失败.
而第二种就类似于我们平常使用的 shell , 他会正常的识别 && 和 管道符.

### 将锁加在 文件描述符 (fd) 上

flock 也可以对某个 fd 加锁, 这种通常用于一个进程的子进程中.

关于 fd, 由于 Linux  一切皆文件的哲学, 所以我们常用的 stdout 就是 fd 1, stderr 就是 fd 2, 我们也可以自定义 fd

```shell
TODAY=`date +%Y%m%d`
(
  flock -xn 100 || exit 1
  git reset HEAD --hard
  git pull
) 100>/tmp/fffflock.lock
```

## 结

这样我们就可以避免两个进程同时对一个文件的读写而产生错误了.

## 附录

Flock Options:

* -s, --shared                             共享锁
* -x, --exclusive                          独占锁，默认类型
* -u, --unlock                             解锁, (通常不需要手动解锁, 默认 -c 后的命令退出时, FD 会关闭, 会将文件解锁)
* -n, --nonblock                           非阻塞，若指定的文件正在被其他进程锁定，则立即以失败 (1) 返回
* -w, --timeout <secs>                     若指定的文件正在被其他进程锁定，则等待指定的秒数；指定为 0 将被视为非阻塞
* -o, --close                              锁定文件后与执行命令前，关闭用于引用加锁文件的文件描述符
* -E, --conflict-exit-code <number>        若指定 - n 时请求加锁的文件正在被其他进程锁定，或指定 - w 时等待超时，则以该选项的参数作为返回值
* -F, --no-fork                            不 fork 执行命令

* -c, --command <command>                  运行的命令




