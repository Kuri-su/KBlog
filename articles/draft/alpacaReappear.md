+++
date = "2023-06-01"
title = "Alpaca replicate"
slug = "alpaca_replicate"
categories = [ "tech","ai" ]
tags = [ "alpaca","fineTuringReplicate", "ai" ]
katex = false
headline = ""
headImgUrl = ""

+++

https://zhuanlan.zhihu.com/p/618321077

尝试直接基于  https://github.com/tatsu-lab/stanford_alpaca 项目来复现, 结果发现这东西 7B 的 微调都要榨干 64G+64GSwap + 4090 24G.... 然后一看作者推荐配置 , 8 * A100 上跑的 [Doge], 告辞

然后接着看 LoRA 方案, 看上去是 单张 4090 能跑的 [Doge]

https://zhuanlan.zhihu.com/p/620539841

