---
layout: post
title: sed -i 参数调试
category: shell
tags: shell 
keywords: shell sed  
description:
---
这里主要说bsd sed和gnu sed 对于-i的兼容处理

先给[参考链接](http://stackoverflow.com/questions/5694228/sed-in-place-flag-that-works-both-on-mac-bsd-and-linux)

##`解决方案:`

>sed -i.bak "commond sequence" file

>rm file.bak

##对比bsd sed 和gnu sed

1.bsd sed

>sed -i "" "common sequence" file (support)

>sed -i"" "common sequence" file (not support)

>sed -i"suffix" "common sequence" file (support)

2.gnu sed

>sed -i "" "common sequence" file (not support)

>sed -i"" "common sequence" file (support)

>sed -i"suffix" "common sequence" file (support)

##副作用：会产生一个备份文件,当然我的目的是直接修改文件,所以把这个备份文件视作满足兼容性的副作用产物


