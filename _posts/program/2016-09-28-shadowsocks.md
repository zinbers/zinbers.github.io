---
layout: post
title: shadowsocks for mac 配置表批量导入
category: shell 
tags: shell
keywords: shell, shadowsocks, mac
description:
comments: true
---
>1 首先需要一个名字为ss_cfg.json的配置文件,和下面的脚本文件放在同一目录

json配置如下，需要配置多个的话，复制profiles里面的就行了，注意json格式，配置好了可以到网上在线解析json网站检查一下格式是否配置正确。

```json
{
  "current": 1,
  "profiles": [
    {
      "password": "xxxx",
      "method": "xxxx", 
      "server_port": xxxx,
      "remarks": "",
      "server": "xxxx"
    }
  ]
}
```
password 就是密码啦，method就是混淆方式,server_port 就是 远程服务器的端口 ,remarks 备注信息，可甜可不填, server 就是远程服务器地址，ip或者域名


>2 上一步配置好json以后就跑一下下面的脚本，重启一个shadowsocks 就好了

```bash
#!/bin/bash
if [ -s "$HOME/Library/Preferences/clowwindy.ShadowsocksX.plist" ]; then
    plutil -convert xml1 $HOME/Library/Preferences/clowwindy.ShadowsocksX.plist -o tmp.xml
    lines=(`grep -n "data" tmp.xml | cut -d ':' -f 1`)
    data_start=${lines[0]}
    data_end=${lines[1]}
    data_start_next=$[$data_start + 1]
    data_end_last=$[$data_end - 1]
    if [ -s ./ss_cfg.json ]; then
        encodeJson=`cat ./ss_cfg.json | base64`
        sed -i.bak "${data_start_next},${data_end_last}d;${data_start}a\\$encodeJson" ./tmp.xml
    else
        echo "can not find file ss_cfg.json or it's empty!"
        exit 1
    fi
    plutil -convert binary1 ./tmp.xml -o ./tmp.plist
    defaults import clowwindy.ShadowsocksX ./tmp.plist
    rm tmp.xml tmp.xml.bak tmp.plist
    echo "done! please restart shadowsocks!"
else
    echo "can not find shadowsocks.plist or it's empty!"
    exit 1
fi

```

#在mac os上测试通过。 [文件链接](https://github.com/zinbers/shadowsocks_profiles)

#ps: 新增ping 速度测试脚本 [文件链接](https://github.com/zinbers/shadowsocks_profiles/blob/master/test_speed.sh)
