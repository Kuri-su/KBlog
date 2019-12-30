# Go-Micro 源碼閱讀 (一) Api

帶着問題看源碼, 這裏遇到幾個問題

* 想通過在 對 Micro Api 的請求中添加 `TIMEOUT` HTTP Header  來影響 `Micro Api` 使用的 Client 的 Timeout 配置, 目前看代碼是 被 New 的 Client 的 默認Timeout 配置所覆蓋, 所以想看看 handler 爲 rpc 或者 api 的時候, 是否是可以被應用
* Micro Api 的生命週期
* 能否發現一些 Go-Micro 的優化點

那麼我們就開始吧.從 micro/micro:/api/ 開始

