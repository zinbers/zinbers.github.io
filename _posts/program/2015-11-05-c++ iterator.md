---
layout: post
title: C++迭代器失效
category: 编程
tags: c++ iterator
keywords: c++ iterator
description: 
---
转自：http://blog.csdn.net/vipvipvip/article/details/6295973

众所周知当使用一个容器的insert或者erase函数通过迭代器插入或删除元素"可能"会导致迭代器失效，因此很多建议都是让我们获取insert或者erase返回的迭代器，以便用重新获取新的有效的迭代器进行正确的操作：

```cpp
	iter=vec.insert(iter);   
 	iter=vec.erase(iter); 
```     
  想想究竟为什么迭代器失效，原因也不难理解。以vector为例，当我们插入一个元素时它的预分配空间不够时，它会重新申请一段新空间，将原空间上的元素复制到新的空间上去，然后再把新加入的元素放到新空间的尾部，以满足vector元素要求连续存储的目的。而后原空间会被系统撤销或征做他用，于是指向原空间的迭代器就成了类似于“悬垂指针”一样的东西，指向了一片非法区域。如果使用了这样的迭代器会导致严重的运行时错误就变得很自然了。这也是许多书上叙述vector在insert操作后“可能导致所有迭代器实效”的原因。但是想到这里我不禁想到vector的erase操作的叙述是“会导致指向删除元素和删除元素之后的迭代器失效”。但是明显感觉erase带来失效要比insert来得轻得多。似乎“此失效非彼失效”，想想似乎也是这样的：erase操作是在原空间上进行的，假设有一个存有"12345"序列的vector<int>容器原本指向3的迭代器在我删除2之后无非变成指向4了，我只要注意别用到超过end位置的迭代器不就行了吗?

  说了这么多似乎可以归纳一下迭代器失效的类型了：

  1.由于容器元素整体“迁移”导致存放原容器元素的空间不再有效，从而使得指向原空间的迭代器失效。

  2.由于删除元素使得某些元素次序发生变化使得原本指向某元素的迭代器不再指向希望指向的元素。

  对于第一种类型没什么好就是的了，原因应该确定如此了。可对于第二种，我写了如下的代码

```cpp
vector<int> vec;   
for(int i=0;i<10;i++)   
vec.push_back(i);   
 
vector<int>::iterator iter =vec.begin()+2;   
vec.erase(iter);//注:这里真的不建议这么写   
cout<<*iter<<endl;   
for(vector<int>::iterator it=vec.begin();it!=vec.end();it++)   
cout<<*it<<endl; 

```

   按照我的猜测尽管我在注释的位置的写法很“危险”，但是我并未涉及到上面总结第一种失效类型的范畴。程序应该还是会如预期的一样删除在vec[2]位置上的2然后输出前移到vec[2]位置上的3，并输出0到10不含2的所有数字，于是vs2008的c++环境下运行一下,竟然一个是个无情的“红叉”。按道理说这种写法是绝对不对出现严重的运行时错误的，难道是猜测得不对吗？

   当时被这样的疑问困扰了几天，有一天突然想起一个关于容器迭代器作参数的例子，在vs2008下运行不了，但是在vc6.0下却可以，有人说是因为08采用了更为严格的类型检测机制。于是将上面的代码放到6.0里，果然得到了预期的效果，看来系统果然是这么处理的。至于08为什么不可以，现在我只能认为是采用了更加安全的检查机制。使得第二种类型的失效后果同样“不可饶恕”。

  这样我就又想到假如insert元素时原空间够用的话，是不是也不会产生第一类失效而产生第二类失效呢？

```cpp
vector<int> vec;   
for(int i=0;i<10;i++)   
    vec.push_back(i);   
       cout<<"capacity:"<<vec.capacity()<<endl;//查看预分配空间大小   
vector<int>::iterator iter =vec.begin()+2;   
vec.insert(iter,100);   
cout<<"capacity:"<<vec.capacity()<<endl;     
cout<<*iter<<endl;   
for(vector<int>::iterator it=vec.begin();it!=vec.end();it++)   
cout<<*it<<endl;  

```
   
  同样在vc6.0下，证明了假设是对的。但是上面的种种做法只是为了帮助我理解迭代器实效的原因，建议使用insert和erase操作时还是像许多书中介绍的如第一段代码那样的写法，这是一种好的且安全的习惯。总之一句话去相信“insert和erase操作后所有的迭代器都会失效”。
