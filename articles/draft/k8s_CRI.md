# Kubernetes CRI  

> 简介
> 
> 
> 主干源码阅读

## 简介

说道 CRI 就不得不提到 `容器运行时`(container Runtime), 


## 



<!--OCI（开放容器标准），规定了2点：-->
<!---->
<!--容器镜像要长啥样，即 ImageSpec。里面的大致规定就是你这个东西需要是一个压缩了的文件夹，文件夹里以 xxx 结构放 xxx 文件；-->
<!--容器要需要能接收哪些指令，这些指令的行为是什么，即 RuntimeSpec。这里面的大致内容就是“容器”要能够执行 “create”，“start”，“stop”，“delete” 这些命令，并且行为要规范。-->


<!--OCI, CRI 确实不是一个好名字，在这篇文章的语境中更准确的说法：cri-runtime 和 oci-runtime。通过这个粗略的分类，我们其实可以总结出整个 Runtime 架构万变不离其宗的三层抽象：-->
<!---->
<!--Orchestration API -> Container API（cri-runtime） -> Kernel API(oci-runtime)-->