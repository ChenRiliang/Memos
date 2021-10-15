---
title: Nginx常用命令
date: 2020-07-24 10:20:42
tags: 
- Linux
- Nginx
categories: Linux
description: 记录 Nginx 常用命令以备忘；
---

{% note info %}
    记录 Nginx 常用命令以备忘；
{% endnote %}

## 安装 Nginx 服务
>根据你的系统，选择对应的命令来安装：
```shell
$ sudo yum install epel-release && yum install nginx   [On CentOS/RHEL]
$ sudo dnf install nginx                               [On Debian/Ubuntu]
$ sudo apt install nginx                               [On Fedora]
```


## 查看 Nginx 版本
```shell
$ nginx -v
nginx version: nginx/1.12.2

# 如果你想同时看到更详细的配置项，使用 -V
$ nginx -V

输出以下详细信息
nginx version: nginx/1.12.2
built by gcc 4.8.5 20150623 (Red Hat 4.8.5-16) (GCC) 
built with OpenSSL 1.0.2k-fips  26 Jan 2017
TLS SNI support enabled
configure arguments: --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx......
```


## 查看 Nginx 配置语法

**在启动 Nginx 服务之前，可以检查它的配置语法是否正确。尤其是当你修改或添加配置时很有用。 命令如下：**

```shell 
$ sudo nginx -t

nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful

这里如果用大写 T，效果就是 测试、丢弃并退出
$ sudo nginx -T
```

## 启动 Nginx 服务
**如果有 配置语法 错误，该命令可能失效。命令如下：**
```shell 
$ sudo systemctl start nginx #systemd
OR
$ sudo service nginx start   #sysvinit
```

## 开机自启动
**前面的命令只是暂时启动，这条就厉害了：**

```shell
$ sudo systemctl enable nginx #systemd
或
$ sudo service nginx enable   #sysv init
```

## 重启 Nginx 服务
**重启的意思是，停止 然后 启动**
```shell
$ sudo systemctl restart nginx #systemd
或
$ sudo service nginx restart   #sysv init
```

## 查看 Nginx 服务状态
**这条是看运行时的服务状态信息的。**
```shell
$ sudo systemctl status nginx #systemd
或
$ sudo service nginx status   #sysvinit
```

## 重载 Nginx 服务
**重载是重新加载 配置文件，看命令：**
```shell
$ sudo systemctl reload nginx #systemd
或
$ sudo service nginx reload   #sysvinit
```

## 停止 Nginx 服务
**不管你是什么原因想停了它，都可以用：**
```shell
$ sudo systemctl stop nginx #systemd
OR
$ sudo service nginx stop   #sysvinit
```


## 查看命令帮助
**如果还有什么不懂，或者想知道其他命令，就用这个**
```shell
$ systemctl -h nginx
```

## 总结
以上为常用命令， 对于常规操作来说基本够用了， 总结以备用；
