---
layout: post
title: python 核心编程第四章
category: 编程
tags: python
keywords: python,编程
description: 
---
![cute](http://funnzoo.com/gallery/acc8fbd57f34a8c6c86e150767d06e3c)
###python 核心编程第四章
#bool 值为false的情况
>1. None
>2. False(布尔类型)
>3. 所有的值为零的数
>4. 0(整形)
>5. 0.0(浮点型)
>6. 0L(长整型)
>7. 0.0+0.0j(复数)
>8. ""(空字符串)
>9. [](空列表)
>10. ()(空元组)
>11. {}(空字典)
*其他的都是True*

#判断对新类型使用 isinstance()
```python
    if isinstance(num, int) ...
```

#python 不支持的类型
>1.char or byte
>2. 指针
>3. *int* vs *short* vs *long*
>4. *float* vs *double*