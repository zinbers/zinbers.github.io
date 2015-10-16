---
layout: post
title: 代码中特殊的注释技术——TODO、FIXME和XXX的用处
category: 编程
tags: c++ comments
keywords: c++ comments 
description: 
---
本博客网址：![]http://www.cnblogs.com/pengyingh/articles/2445826.html，转载本博客原创文章请注明出处。

本文内容概要： 代码中特殊的注释技术——TODO、FIXME和XXX的用处。

 
前言：
今天在阅读Qt  Creator的源代码时，发现一些注释中有FIXME英文单词，用英文词典居然查不到其意义！
实际上，在阅读一些开源代码时，我们常会碰到诸如：TODO、FIXME和XXX的单词，它们是有其特殊含义的。、

TODO: + 说明：
如果代码中有该标识，说明在标识处有功能代码待编写，待实现的功能在说明中会简略说明。

FIXME: + 说明：
如果代码中有该标识，说明标识处代码需要修正，甚至代码是错误的，不能工作，需要修复，如何修正会在说明中简略说明。

XXX: + 说明：
如果代码中有该标识，说明标识处代码虽然实现了功能，但是实现的方法有待商榷，希望将来能改进，要改进的地方会在说明中简略说明。

eclipse中特殊的注释：
在eclipse中，TODO、FIXME和XXX都会被eclipse的task视图所收集。在项目发布前，检查一下task视图是一个很好的习惯。此外，在eclipse中，我们可自定义自己的特殊注释标签。如在C/C++中，进入window—>preferences—>C/C++—>Task Tags窗口即可添加特殊标签，默认只有TODO、FIXME和XXX。

