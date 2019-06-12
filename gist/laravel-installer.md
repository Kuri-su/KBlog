

```shell
$ composer global require "laravel/installer"
$ vim ~/.zshrc  # ~/.bashrc
```

在 ~/zshrc 中添加环境变量

```shell
export PATH=~/.config/composer/verdor/bin:$PATH 
```

```shell
source ~/.zshrc
```

即可使用 `laravel new xproject` 命令

