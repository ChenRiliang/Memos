---
title: ftp权限问题
date: 2020-07-23 16:08:59
tags: 
- Linux
- 问题存档
categories: Linux
description: FTP 创建目录提示 permission denied
---

# FTP 创建目录提示 permission denied

原因定位： 权限不足

解决措施： 

```shell
// -R 应用到此文件夹下所有子目录和文件
// -777 所有用户都拥有最高权限
sudo chmod -R 777 目录名/

```

# 总结

直接赋予所有用户最高权限会带来安全问题， 所以如果场景需要，还是可以从 ip 白名单和指定用户为管理员权限等操作；
