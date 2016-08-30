---
layout: post
title: 极路由1s(h5661) 刷uboot breed
category: 玩机
tags: 极路由 
keywords: 极路由1s h5661 breed 
description:
---

###刷机前请先确认自己路由器的型号
登录极路由默认后台:192.168.199.1, 登录以后在主页面最下面就可以看到路由器的型号和当前路由器当前固件的版本

刷uboot breed 共分2步
###1.root
###2.刷breed

>1.root极路由
#高能预警 root路由器将失去保修
ok，[我发现这个链接写的很清楚了,点我](http://www.jb51.net/network/358520.html)


>2.刷breed
现在应该已经开通root权限了.
>>下载 breed
根据breed作者的介绍链接[点我](http://www.right.com.cn/forum/thread-161906-1-1.html)
去下载极路由1s(h5661) 对应的版本[breed-mt7620-hiwifi-hc5761.bin](http://breed.hackpascal.net/breed-mt7620-hiwifi-hc5761.bin)

>>上传breed到路由器
有一定linux基础可以一条命令搞定
scp -P 1022 /path/to/breed-xxx.bin root@192.168.199.1:/tmp
接着输入路由器密码,这样就上传breed到路由器的/tmp目录下了.



