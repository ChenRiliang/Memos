#!/usr/bin/env sh
set -e
hexo clean
hexo g
cd public      #hexo编译html静态目录
echo 'crliang.com' > CNAME
cd ..
hexo d
