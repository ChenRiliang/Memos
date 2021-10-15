---
title: 解决 node 服务端口占用问题
date: 2020/05/22
categories:
- Node
tags:
- Node
- 问题存档
description: 记录解决启动多个 node 服务带来的端口占用问题：
---

npm run dev 终端提示：

```shell
Error: listen EADDRINUSE :::8000
....
```
解决方案：

```shell
// 查看端口占用情况
sudo lsof -i:8080
```

获取到 node 端口运行情况，查看对应 id 如：28614

```shell
// 结束该服务
kill 28614
```

终止完服务后， 重新 npm run dev 即可~
