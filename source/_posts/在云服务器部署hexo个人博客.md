---
title: 在云服务器部署hexo个人博客
date: 2019/6/10 
updated: 2019/6/10
categories:
- Linux
tags:
- Linux
- ECS
description: 关于云服务器配置及部署 hexo 的相关记录
---

{% note %}
    想起年初活动入手的云服务器还闲置着，就把一直要把玩的个人网站给搭起来，将过程整理以查阅，起势~
{% endnote %}

## 环境说明
博客框架：[hexo](https://hexo.io/zh-cn/)
云服务器：[腾讯云 CentOS 7.4 64位](https://cloud.tencent.com/)
系统：Mac OS  

## 登录服务器

```shell
ssh name@ECS ip
```

## 依赖准备

### 安装 Git

```shell
sudo yum install git-core

```

查看 Git 版本，若有输出版本， 则已安装成功
```shell
git --version
```

### 安装 Node.js
>安装 nvm
```shell
wget -qO- https://raw.github.com/creationix/nvm/master/install.sh | sh
```

更新

```shell
source ~/.bash_profile
```

安装 Node.js

```shell
nvm install stable
```

### 创建 git 仓库
创建 git 仓库，用于存放博客网站资源。
在 home/git 的目录下，创建一个名为hexoBlog的裸仓库（bare repo）。
如果没有 home/git 目录，需要先创建；然后修改目录的所有权和用户权限。

```shell
mkdir /home/git/
chown -R $USER:$USER /home/git/
chmod -R 755 /home/git/
```

打开至该目录
```shell
cd /home/git/
git init --bare hexoBlog.git
```
至此， 本地仓库已经创建成功


### 创建一个新的 git 钩子，用于自动部署

```bazaar
vim /home/git/hexoBlog.git/hooks/post-receive
```

按 i 键进入文件的编辑模式，在该文件中添加两行代码（将下边的代码粘贴进去)，指定 Git 的工作树（源代码）和 Git 目录（配置文件等）

```shell
#!/bin/bash
git --work-tree=/home/hexoBlog --git-dir=/home/git/hexoBlog.git checkout -f
```

然后，按 Esc 键退出编辑模式，输入":wq" 保存退出。

修改文件权限，使得其可执行
```shell
chmod +x /home/git/hexoBlog.git/hooks/post-receive
```
到这里，我们的 git 仓库算是完全搭建好了。下面进行 Nginx 的配置。

## Nginx

### 安装 Nginx
```shell
yum install -y nginx
```

### 启动 Nginx
```shell
service nginx start
```

### 测试服务器
```shell
wget http://127.0.0.1
```

### 如果出现如下输出， 则已成功
```shell
Connecting to 127.0.0.1:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 43704 (43K) [text/html]
Saving to: ‘index.html’

100%[=======================================>] 43,704      --.-K/s   in 0s

2018-03-09 23:04:09 (487 MB/s) - ‘index.html’ saved [43704/43704]
```

目前利用 ECS 公网 ip 已经可以打开

### 配置 Nginx 托管文件目录

#### 创建 /home/hexoBlog目录，用于 Nginx 托管
```shell
mkdir /home/hexoBlog/
chown -R $USER:$USER /home/hexoBlog/
chmod -R 755 /home/hexoBlog/
```

#### 查看 Nginx 的默认配置的安装位置

```shell
nginx -t
```

修改Nginx的默认配置，其中 cd 后边就是刚才查到的安装位置（每个人可能都不一样）

```shell
vim /etc/nginx/nginx.conf
```

按方向键，找到如下位置
```shell
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /home/hexoBlog;    #需要修改

    server_name www.celiang.com; #需要修改为你的域名

    # Load configuration files for the default server block.
    include /etc/nginx/default.d/*.conf;
    location / {
    }
    error_page 404 /404.html;
        location = /40x.html {
    }
```

按i键进入插入模式，将其中的 root 值改为 /home/hexoBlog （刚才创建的托管仓库目录）。
将 server_name 值改成你的域名。


重启 Nginx 服务
```shell
service nginx restart
```

至此， Nginx 配置已完成。

## 配置 hexo

### 修改 hexo 站点配置文件 git 相关设置

修改站点配置文件 _config.yml
```shell
deploy:
    type: git
    repo: root@ECS IP地址:/home/git/hexoBlog
    branch: master
```

在 hexo 目录下执行部署，试试看。

```shell
cd 你的 hexo 目录
hexo clean
hexo generate
hexo deploy
```

期间会让你输入服务器密码，输入回车之后， 看到  
```shell
...
INFO  Deploy done: git
```

即， 已经部署成功， 打开你配置好的域名~


参考链接：
[基于 CentOS 搭建 Hexo 个人博客](https://cloud.tencent.com/developer/labs/lab/10379)
[Hexo 博客部署到腾讯云教程](https://zhuanlan.zhihu.com/p/34400760)
