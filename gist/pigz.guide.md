
![ex](https://zlib.net/pigz/pigz-logo.png)

## Install 

使用包管理工具安装即可

```shell
# Ubuntu / Debian /...
$ sudo apt install pigz
# CentOS / ...
$ sudo yum install pigz
```

## What (解决了什么问题)

在 `Linux` 中使用 `Tar + Gzip` 打包文件时, 如果 文件较多且大, 那么可能你泡完了一杯咖啡回来之后, 打包仍未还没就绪. 而如果此时打开 `CPU 状态`, 你会郁闷的看到始终只有一个核在运转, 其他的核都在摸鱼, 而在 9012 年的今天, 有没有办法在使用 Tar 打包的时候, 释放多核的魔力来急速缩短花费的时间呢, 答案是有的. 那么就是 `Pigz`.

## How

`Pigz` 是 `Gzip` 的并行实现, 源码地址 => https://github.com/madler/pigz,  Pigz 和 Gizp 在压缩和解压缩中使用的参数基本一样.

```shell
# 压缩
# Gzip  
$ tar -cvf a.tar dir1 dir2 dir3 && gzip -v a.tar
# Pigz 
$ tar -cvf a.tar dir1 dir2 dir3 && pigz -p 8 -v a.tar   
# 在不指定参数时默认使用全部的核
$ tar -cvf a.tar dir1 dir2 dir3 && pigz -v a.tar   

# 解压
# Gzip  
$ gzip -dv a.tar.gz && tar -xvf a.tar  
# Pigz 
$ pigz -p 8 -dv a.tar.gz && tar -xvf a.tar     
# 在不指定参数时默认使用全部的核
$ pigz -dv a.tar.gz && tar -xvf a.tar     

```


## 附录 -- pigz 参数一览

> Gzip

```shell
  -c, --stdout      write on standard output, keep original files unchanged
  -d, --decompress  decompress
  -f, --force       force overwrite of output file and compress links
  -h, --help        give this help
  -k, --keep        keep (don't delete) input files
  -l, --list        list compressed file contents
  -L, --license     display software license
  -n, --no-name     do not save or restore the original name and timestamp
  -N, --name        save or restore the original name and timestamp
  -q, --quiet       suppress all warnings
  -r, --recursive   operate recursively on directories
      --rsyncable   make rsync-friendly archive
  -S, --suffix=SUF  use suffix SUF on compressed files
      --synchronous synchronous output (safer if system crashes, but slower)
  -t, --test        test compressed file integrity
  -v, --verbose     verbose mode
  -V, --version     display version number
  -1, --fast        compress faster
  -9, --best        compress better
```


> Pigz

```shell
  -0 to -9, -11        Compression level (level 11, zopfli, is much slower)
  --fast, --best       Compression levels 1 and 9 respectively
  -b, --blocksize mmm  Set compression block size to mmmK (default 128K)
  -c, --stdout         Write all processed output to stdout (won't delete)
  -d, --decompress     Decompress the compressed input
  -f, --force          Force overwrite, compress .gz, links, and to terminal
  -F  --first          Do iterations first, before block split for -11
  -h, --help           Display a help screen and quit
  -i, --independent    Compress blocks independently for damage recovery
  -I, --iterations n   Number of iterations for -11 optimization
  -J, --maxsplits n    Maximum number of split blocks for -11
  -k, --keep           Do not delete original file after processing
  -K, --zip            Compress to PKWare zip (.zip) single entry format
  -l, --list           List the contents of the compressed input
  -L, --license        Display the pigz license and quit
  -m, --no-time        Do not store or restore mod time
  -M, --time           Store or restore mod time
  -n, --no-name        Do not store or restore file name or mod time
  -N, --name           Store or restore file name and mod time
  -O  --oneblock       Do not split into smaller blocks for -11
  -p, --processes n    Allow up to n compression threads (default is the
                       number of online processors, or 8 if unknown)
  -q, --quiet          Print no messages, even on error
  -r, --recursive      Process the contents of all subdirectories
  -R, --rsyncable      Input-determined block locations for rsync
  -S, --suffix .sss    Use suffix .sss instead of .gz (for compression)
  -t, --test           Test the integrity of the compressed input
  -v, --verbose        Provide more verbose output
  -V  --version        Show the version of pigz
  -Y  --synchronous    Force output file write to permanent storage
  -z, --zlib           Compress to zlib (.zz) instead of gzip format
  --                   All arguments after "--" are treated as files
```

