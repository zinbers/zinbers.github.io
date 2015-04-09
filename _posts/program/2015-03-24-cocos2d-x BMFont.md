---
layout: post
title: BMFont
category: 编程
tags: cocos2dx bmfont
keywords: cocos2dx bmfont program texturepacker
description: 
---
![银河穹顶](http://image.nationalgeographic.com.cn/2015/0404/20150404025918260.jpg)
##闲话：最近准备看BBC纪录片 Human.Planet （人类星球）

制作字体的软件还是蛮多的。(cocos2dx 官网教程里面有推荐)
再mac 上我用的GlyphDesigner,操作都比较简单（对于我这种小白来说，也不会其他高级的功能）

问题：字体图片宽高不统一的情况下使用怎么使用bmfont (只是一个方法，仅供参考)

##1.生成fnt文件
    根据图片信息生成对应字符的FNT文件
##2.打包碎图
	我们的字符图片都是分开的小图片，图片也不是等宽高，所以就直接用texturepacker 打包一下，
	然后将png放在fnt目录里面。
##3.修改fnt文件
    根据打包的plist文件信息 更改Font 文件，将这两个文件都用sublime 打开，
    主要就是修改fnt文件里面x,y,width,height,xoffset,yoffset,xadvance
    这些基本都可以在plist里面找得到，其中xadvance = width,这个不太清楚是干嘛的
    刚开始没设置，显示的总是不对，看了源码才知道，计算字符位置的时候用到他了，
    把xadvance改成字符宽度后就显示正常了。回头再看看文档关于fnt的说明。

其他的就没有什么问题了，然后写代码构造bmfont就可以了。


