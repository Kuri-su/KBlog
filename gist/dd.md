
```shell
# 确认 U 盘 的路径
$ sudo fdisk -l

# umount usb disk
$ sudo umount /dev/sdb*

# format u disk
$ sudo mkfs.vfat /dev/sdb -I

# dd
sudo dd if=your.iso of='u disk path'

# example
sudo dd if=/tmp/manjaro-gnome-18.1.3-191114-linux53.iso of=/dev/sdc
```

ref: 
> https://blog.csdn.net/master5512/article/details/69055662