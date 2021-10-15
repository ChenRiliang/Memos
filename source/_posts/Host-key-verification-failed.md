---
title: Host key verification failed
date: 2019/7/13 20:46:25
updated: 2019/7/13 20:46:30
categories:
- Linux
tags:
- Linux
- ECS
- 问题存档
description: 对云服务器重装系统完， 发现输出如下错误：
---

> 对云服务器重装系统完， 发现输出如下错误：
<!-- more -->

```linux
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:R3gcpEXkk7p4DSH5Po2OP9HxvCZfat/tMEl/6g/cil8.
Please contact your system administrator.
Add correct host key in /Users/meitu/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /Users/meitu/.ssh/known_hosts:12
ECDSA host key for 129.211.30.178 has changed and you have requested strict checking.
Host key verification failed.
```

根据输出提示，一般这个问题，是你重置服务器后。ECDSA主机密钥已经被改变，需要重新验证。

解决措施：

```linux
ssh-keygen -R 你要访问的IP地址
```
