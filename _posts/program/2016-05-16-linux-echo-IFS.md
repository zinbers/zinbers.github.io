---
layout: post
title: echo 中IFS展开
category: shell
tags: 编程 linux shell 
keywords: linux shell echo 
description: 
---
前几天在些shell的时候遇到一个有趣的问题

```bash
#!/usr/bin/env bash
va="a b c"
vb=`echo $va | tr ' ' '\n'`
echo $vb
echo '~~~~~~~~~~'
echo "$vb"
```

输出:

a b c</br>
~~~~~~~~~~</br>
a</br>
b</br>
c</br>

我的换行符呢？ 
google 了一下原来是IFS(Internal Field Separator) 在作怪啊。 

＃变量vb里实际是有换行符的，只是传给echo的时候做了些变换。 

＃bash把变量展开之后，会根据IFS（Internal Field Separator）把输入划分成多个单独的单词（Word splitting），除了在双引号里，原输入里的IFS都换成空格，连续空格再缩成1个空格。默认的IFS里有空格、换行和Tab。 

所以输入echo $vb，bash处理是这样的</br>
>echo<空格>$vb</br>
>--展开vb--></br>
>echo<空格>a<换行>b<换行>c</br>
>--根据IFS分词--></br>
>echo<空格>a<空格>b<空格>c</br>
所以用a、b、c作为参数调用echo。</br>

这时候只要加上双引号阻止分词就可以了：</br>
>echo<空格>"$vb"</br>
>--展开vb--></br>
>echo<空格>"a<换行>b<换行>c"</br>
>--根据IFS分词,双引号里不分词--></br>
>echo<空格>"a<换行>b<换行>c"</br>
1<换行>2<换行>3 被当作参数传给echo，然后就是你想要的结果了。</br>
也可以把IFS设成其他字符，例如IFS=,,然后echo $vb和echo "$vb"的结果是一样的，因为输入里没有IFS，不会被分词。
##参考链接: 
<http://www.dewen.net.cn/q/15301/Linux%EF%BC%9A%E9%80%9A%E8%BF%87%E5%AD%90shell%E7%9A%84%E6%96%B9%E5%BC%8F%E4%BF%9D%E7%95%99%E7%A9%BA%E6%A0%BC%E5%92%8C%E6%8D%A2%E8%A1%8C%E7%AC%A6?sort=votes>