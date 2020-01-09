# Helm3 Guide

## 要點

* `Helm(指揮/舵手)` 是一個 `Chart(圖紙) Manager `, 
* 而 `Charts` 是 一組 配置好的  Kubernetes 資源 的定義組合,
* Release 是一組已經部署到 Kubernetes 的資源集合

從個人當前的瞭解, helm 於 kuberntes 的  `Api Object` , 更像 `docker container` 於 `docker-compose` , 而 Release 則類似 Docker Stack 的概念.



## 組成

1. `helm` 客戶端
   * 類似於 kubectl 於 kubernetes 的概念
   * arch/manjaro 可以使用 `sudo pacman -S kubernetes-helm` 來安裝

## 基本操作

* helm create 
  * 創建自己的 chart
* helm install
  * 更具指定的 chart 部署一個 Release 到 k8s
* helm package 
  * 打包 chart , 
* helm inspect
  * 查看指定 chart 的信息
* helm search
  * 搜索可用的 helm  (類似 `apt search`)

## Chart 文件結構

Chart 是描述 相關的一組 Kubernetes 資源的 文件集合. 

chart 通過創建 爲 `特定目錄樹` 的文件, 將他們打包到 **版本化** 的壓縮包, 然後進行部署





ref:

> [https://ezmo.me/2017/09/24/helm-quick-toturial/](https://ezmo.me/2017/09/24/helm-quick-toturial/)