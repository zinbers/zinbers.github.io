---
layout: post
title: python 学习
category: 编程
tags: python
keywords: python,编程
description: 
---
![]http://www.nationalgeographic.com.cn/news/1772.html
>##3.4.1模块结构与布局

>#1.起始行(Unix)#
>#2.模块文档
>#3.模块导入
>#4.变量定义
>#5.类定义
>#6.函数定义
>#7.主程序

```
#/usr/bin/evn python  #起始行

"this is a test module" #模块文档

import sys
import os    #模块导入

debug = True #(全局)变量定义

class Foo(object):
    "Foo class"
    #...        #类定义

def test()
    "test function"
    foo = Foo()
    if debug:
        print 'ran test()'  #函数定义

if __name__ == '__main__':
    test()                  #主程序
```