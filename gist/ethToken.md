
### 前置准备

1. 浏览器安装 [MetaMask](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn) ，获得一个 ETH 地址，假设地址 `A`
    > 用作支付 ges (油费)和接收币的钱包

1. 向 ETH地址 `A` 中充值 0.01 左右的ETH (大概 8.5 RMB(20190112))
    > 用作油费

### 步骤

1. 打开 [Solidity](https://remix.ethereum.org) 的在线 IDE
    > 用于执行代码
1. 将 [发token的代码](https://www.ethereum.org/token#the-code) 复制到IDE中
1. 右侧切换到 `Run` tab下，如果使用 MetaMack 登录完成，则此处第一部分将自动填充完成。选择 token 类型为 `TokenERC20` 
1. 这个智能合约接受三个参数，第一个参数是代币总量，第二个是代币名称，第三个是代币简称，例示如 10000,"hahaha12","HAHA"，填入 `Deploy` 左侧的输入框中，此处填写完毕后，将类似于下图
    ![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/messy/ethtoken1.png)
1. 点击 `Deploy`，输入 `Gas Price` ( 2~4 gas 左右即可，gas给的越多，越快被处理),拉到最下,点击 `Confirm`，进行部署
1. 点击下方灰色部分的跳出的连接，来到详情页面（如果此处错过了调试框里的链接也不要紧，打开 [MetaMask](https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn),到 `ETH` tab查看转账详情）
1. 等待处理完成后，在详情页面，复制合约的哈希`B`，到 `METAMASK` 中，点击 ADD TOKEN，填入 `B`,然后一步步点击确认即可在钱包里看到创建的Token

    ![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/messy/选区_001.png)
    ![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/messy/选区_002.png)
    ![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/messy/选区_003.png)
    ![](https://raw.githubusercontent.com/Kuri-su/KBlog/master/assets/gists/messy/选区_004.png)

1. 之后便可将 token 转到任意钱包