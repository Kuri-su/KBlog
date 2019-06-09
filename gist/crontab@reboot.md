
在 Ubuntu 上设置开机启动有很多种方式,虽然早年的 rc.local 的方式在 ubuntu 使用 systemd 后已经无法简单的使用,但是还是有一大堆人在回到过去. 我觉得这样没有必要. 然后发现了一种简单的方法.

将开机启动的脚本设置在 crontab 中, 


```bash
@reboot root cd /home/xxx/ && /usr/local/bin/docker-compose up -d
@reboot root echo 1 > /tmp/vvv
```

相比重新弄出来 rc.local 的方式简单得多.但是似乎因为 crontab 的实现并不统一,并不是所有的linux发行版都可以使用.

* ref
  * https://www.kompulsa.com/run-a-program-on-startup-console-on-ubuntu-18-04/
  * https://askubuntu.com/questions/335615/does-ubuntu-support-reboot-in-crontab
  