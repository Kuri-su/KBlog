
# ExinCore 使用简明教程 (php)

1. 首先需要 `PHP` 的环境 以及安装 `Composer`  
如果 未安装以上二者，可以参考该 [链接](#install-php--composer)


1. 在项目中引入包 [kurisu/exincore-php-sdk](https://github.com/Kurisu-package/exincore-php-sdk)
    1. 如果是一个全新的项目，则需要先在目录下初始化 Composer ，否则可以跳过这一步
        ```bash
        ✘ : /tmp/aBigProject : composer init

            Package name (<vendor>/<name>) [kurisu/a-big-project]: 

            Description []: a big project !

            Author [A B <yourName@gmail.com>, n to skip]: your name <yourName@gmail.com>

            Minimum Stability []: 

            Package Type (e.g. library, project, metapackage, composer-plugin) []: project

            License []: 

            Define your dependencies.

            Would you like to define your dependencies (require) interactively [yes]? no
            Would you like to define your dev dependencies (require-dev) interactively [yes]? no

            {
                "name": "kurisu/a-big-project",
                "description": "a big project !",
                "type": "project",
                "authors": [
                    {
                        "name": "your name",
                        "email": "yourName@gmail.com"
                    }
                ],
                "require": {}
            }

            Do you confirm generation [yes]? yes

        ```
    2. 初始化后 在目录下执行 
        ```php
        composer require kurisu/exincore-php-sdk -vvv
        ```
        即可引入包 [kurisu/exincore-php-sdk]
    
1. 准备 mixin.one 机器人的各类凭证
    如果还没有在 mixin.one 申请机器人，可以参考该 [链接](#在-developersmixinone-创建机器人)

1. Hello World
    在目录下创建 `main.php` 文件，拷贝以下代码
    ```php
    <?php
        require __DIR__ . '/vendor/autoload.php';

        // 将以下配置更换为自己的配置
        $config = [
            'mixin_id'      => '7000101633',
            'client_id'     => '982afd4e-92dd-4430-98cf-d308442ea04d',
            'client_secret' => 'b0a9adf1b358501b1fb6065c6292b09dbc675d5734225f86e0ec14a71d0fd38a',
            'pin'           => '125334',
            'pin_token'     => 'RzgyepFhLbMx+zLw6ogYzZ5k+kmlo8gQ2f4+1uwGMi1HgvMexGdFdeny0ffuBl7gXgPqi1GpUDPWPNrgAIjwGIFu+rHSre1G7JA5ET6tgIYoC+OI2dF0PmNK0qtkjK+qpGpSCt8nFbTfgyHjFENAp4hLZEIhuhzSPPmkkhXGlAU=',
            'session_id'    => '8a70b414-bdef-46f3-9738-186c1095da61',
            'private_key'   => <<<EOF
        -----BEGIN RSA PRIVATE KEY-----
        MIICXQIBAAKBgQCZAkpYA7eH38GbzIX653dxBAEanrSSdYbzQYIV/kKbULYSB43X
        5hWfCFpNJ6FoIUjHAzrNyqJMvSS6LwAA+R4w5GYv8en1Ga1blKbziCMvZsRJ65bP
        ...
        Lz9TaX18rB+sp2u5SkcBAkBIsC/AJNhf1xILLAkkpycJ7rc864Y1JbmKk+I5fXid
        vA4vKPqu2ZnD0O4YbGmciuTRPgeJqAt8bbHq/xOfL0lE
        -----END RSA PRIVATE KEY-----
        EOF
            ,  //import your private_key
        ];

        //-------------------------------------------------------
        //-------------------------------------------------------

        $exincoreSdk = new \Kurisu\ExinCore\ExinCore($config);

        // 1. 查询指定交易对的行情
        $baseAsset     = 'c94ac88f-4671-3976-b60a-09064f1811e8';     // XIN asset UUID
        $exchangeAsset = '815b0b1a-2764-3736-8faa-42d694fa620a';     // USDT asset UUID

        $res = $exincoreSdk->readExchangeList($baseAsset, $exchangeAsset);
        var_dump($res);
    ```
    这样我们就通过 **ExinCore** 查询到了 **XIN => USDT** 交易对的当前行情

1. 创建订单
    > 在此之前需要向机器人中转一个 USDT

    拷贝以下代码到 `main2.php` 文件中
    ```php
        <?php
            require __DIR__ . '/vendor/autoload.php';

            // 将以下配置更换为自己的配置
            $config = [
                'mixin_id'      => '7000101633',
                'client_id'     => '982afd4e-92dd-4430-98cf-d308442ea04d',
                'client_secret' => 'b0a9adf1b358501b1fb6065c6292b09dbc675d5734225f86e0ec14a71d0fd38a',
                'pin'           => '125334',
                'pin_token'     => 'RzgyepFhLbMx+zLw6ogYzZ5k+kmlo8gQ2f4+1uwGMi1HgvMexGdFdeny0ffuBl7gXgPqi1GpUDPWPNrgAIjwGIFu+rHSre1G7JA5ET6tgIYoC+OI2dF0PmNK0qtkjK+qpGpSCt8nFbTfgyHjFENAp4hLZEIhuhzSPPmkkhXGlAU=',
                'session_id'    => '8a70b414-bdef-46f3-9738-186c1095da61',
                'private_key'   => <<<EOF
            -----BEGIN RSA PRIVATE KEY-----
            MIICXQIBAAKBgQCZAkpYA7eH38GbzIX653dxBAEanrSSdYbzQYIV/kKbULYSB43X
            5hWfCFpNJ6FoIUjHAzrNyqJMvSS6LwAA+R4w5GYv8en1Ga1blKbziCMvZsRJ65bP
            ...
            Lz9TaX18rB+sp2u5SkcBAkBIsC/AJNhf1xILLAkkpycJ7rc864Y1JbmKk+I5fXid
            vA4vKPqu2ZnD0O4YbGmciuTRPgeJqAt8bbHq/xOfL0lE
            -----END RSA PRIVATE KEY-----
            EOF
                ,  //import your private_key
            ];

            //-------------------------------------------------------
            //-------------------------------------------------------

            $exincoreSdk = new \Kurisu\ExinCore\ExinCore($config);

            // 2. 创建订单
            $baseAsset     = '815b0b1a-2764-3736-8faa-42d694fa620a';     // USDT asset UUID
            $exchangeAsset = 'c6d0c728-2624-429b-8e0d-d9d19b6592fa';     // BTC asset UUID
            $res           = $exincoreSdk->createOrder($baseAsset, $exchangeAsset, 1);
            dump($res,'----------','-------');
    ```
    这样我们就发起了一笔转账给 **ExinCore** ，并告知我们需要转成的目标币种是什么

    接着我们拷贝以下代码到 `main3.php`，来查询是否兑换完成
    ```php
        <?php
            require __DIR__ . '/vendor/autoload.php';

            // 将以下配置更换为自己的配置
            $config = [
                'mixin_id'      => '7000101633',
                'client_id'     => '982afd4e-92dd-4430-98cf-d308442ea04d',
                'client_secret' => 'b0a9adf1b358501b1fb6065c6292b09dbc675d5734225f86e0ec14a71d0fd38a',
                'pin'           => '125334',
                'pin_token'     => 'RzgyepFhLbMx+zLw6ogYzZ5k+kmlo8gQ2f4+1uwGMi1HgvMexGdFdeny0ffuBl7gXgPqi1GpUDPWPNrgAIjwGIFu+rHSre1G7JA5ET6tgIYoC+OI2dF0PmNK0qtkjK+qpGpSCt8nFbTfgyHjFENAp4hLZEIhuhzSPPmkkhXGlAU=',
                'session_id'    => '8a70b414-bdef-46f3-9738-186c1095da61',
                'private_key'   => <<<EOF
            -----BEGIN RSA PRIVATE KEY-----
            MIICXQIBAAKBgQCZAkpYA7eH38GbzIX653dxBAEanrSSdYbzQYIV/kKbULYSB43X
            5hWfCFpNJ6FoIUjHAzrNyqJMvSS6LwAA+R4w5GYv8en1Ga1blKbziCMvZsRJ65bP
            ...
            Lz9TaX18rB+sp2u5SkcBAkBIsC/AJNhf1xILLAkkpycJ7rc864Y1JbmKk+I5fXid
            vA4vKPqu2ZnD0O4YbGmciuTRPgeJqAt8bbHq/xOfL0lE
            -----END RSA PRIVATE KEY-----
            EOF
                ,  //import your private_key
            ];

            //-------------------------------------------------------
            //-------------------------------------------------------

            $exincoreSdk = new \Kurisu\ExinCore\ExinCore($config);

            // 查询订单
            $baseAsset     = '815b0b1a-2764-3736-8faa-42d694fa620a';     // USDT asset UUID
            $exchangeAsset = 'c6d0c728-2624-429b-8e0d-d9d19b6592fa';     // BTC asset UUID
            $snapshotsList = $exincoreSdk->getMixinSDK()->wallet()->readUserSnapshots(null, null, $exchangeAsset);
            dump($snapshotsList);
    ```
    我们可以看到多了一个新的转账记录，我们将以下代码复制到 `main3.php` 尾部
    ```php
    dump($exincoreSdk->decodeExinCoreMemo($snapshotsList[0]['memo']));
    ```

    然后我们可以获得交易详情
    ```php
    array:6 [
    "C" => 1000                             // 状态码，代表交易成功
    "P" => "3819"                           // 成交均价
    "F" => "0.000000524"                    // 手续费
    "FA" => b"ÆÐÇ(&$B›Ž\rÙÑ›e’ú"
    "T" => "F"
    "O" => b"\x1ASºê\fíLT‡Éø6¥H\x00\x1D"
    ]
    ```

## Install PHP && Composer
`on Ubuntu` 其他平台大致如此
```bash
$ sudo apt update && sudo apt install php7.2-bcmath php7.2-cli php7.2-common php7.2-curl php7.2-dev php7.2-gd php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-xml php7.2-zip -y

$ sudo wget https://dl.laravel-china.org/composer.phar -O /usr/local/bin/composer
$ sudo chmod a+x /usr/local/bin/composer
# 配置中国镜像
$ sudo composer config -g repo.packagist composer https://packagist.laravel-china.org
```
## 在 developers.mixin.one 创建机器人
1. 访问 <https://developers.mixin.one/dashboard> 并 使用 `Mixin Messenger` 扫码登录
1. 进入后点击` Create New App` 按钮
1. 填写信息并 submit
1. 如图填入相应的信息到 配置中
    ![](https://raw.githubusercontent.com/Kurisu-public/someBackup/master/%E9%80%89%E5%8C%BA_209.png)