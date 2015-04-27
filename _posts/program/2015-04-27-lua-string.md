---
layout: post
title: lua 字符串匹配
category: 编程
tags: lua 
keywords: lua string gsub
description: 
---
![春，来了](http://image.nationalgeographic.com.cn/2015/0417/20150417032313964.jpg)

###转自 (http://www.cnitblog.com/kenlistian/archive/2008/10/15/50292.html)
string.gsub 函数有三个参数：目标串，模式串，替换串。
基本作用是用来查找匹配模式的串，并将使用替换串其替换掉： 

```lua
s = string.gsub("Lua is good", "good", "bad?") 
print(s)   --> Lua is bad
```

string.gsub 的第二个返回值表示进行替换操作的次数。例如，
下面代码计字符串中空格出现的次数： 

_, count = string.gsub("test test", " ", " ") 
_ 表示哑元变量

模式串
.   任意字符 
%a   字母 
%c   控制字符 
%d   数字 
%l   小写字母 
%p   标点字符 
%s   空白符 
%u   大写字母 
%w   字母和数字 
%x   十六进制数字 
%z   代表 0的字符 


特殊字符如下：
(). % + - * ? [ ^ $ 
% 也作为以上特殊字符的转义字符。

[] 该方框作为匹配该范围的集合，。
  如[0-9] 则匹配0到9的数字范围

Lua 中的模式修饰符有四个： 
+   匹配前一字符 1 次或多次，最长匹配
*   匹配前一字符 0 次或多次，最长匹配
-   匹配前一字符 0 次或多次，最短匹配
?   匹配前一字符 0 次或 1次 
'+'，匹配一个或多个字符，总是进行最长的匹配。
如，模式  '%a+'  匹配一个或多个字母或者一个单词： 

注意以上的区别：

如：匹配c中的注释串
用 '/%*.*%*/'  和'/%*.-%*/'

str = "int x; /* x */  int y; /* y */" 
print(string.gsub(str, "/%*.*%*/", "<注释串>")) 
  --> int x; <注释串> 
采用 '.-' 则为最短匹配，即匹配 "/*" 开始到第一个 "*/"  之前的部分： 
str = "int x; /* x */  int y; /* y */" 
print(string.gsub(str, "/%*.-%*/", "<注释部分>")) 
  --> int x; <注释串>  int y; <注释串> 

以 '^'  开头表示只匹配目标串的开始部分，
以 '$'  结尾表示只匹配目标串的结尾部分。

%b 表示匹配对称字符，注意其只能针对的ansi码单字符。
```lua
x = string.gsub("xdddddyxxx", "%bxy", "取代")
print(x)   -->取代xxx
```

如去除字符串首尾的空格： 
```lua
function trim (s) 
  return (string.gsub(s, "^%s*(.-)%s*$", "%1")) 
end 
```


---------------------------------

看原文中的gsub注释：相当详细，不过对于模式解释补充在上。

string.gsub (s, pattern, repl [, n])

Returns a copy of s in which all occurrences of the pattern 
have been replaced by a replacement string specified by repl,
which may be a string, a table, or a function. 
gsub also returns, as its second value, the total number of substitutions made.

repl是字符串，则为替换。 如果在参数前有%则表示符合匹配的字符串
If repl is a string, then its value is used for replacement. 
The character % works as an escape character:
any sequence in repl of the form %n, with n between 1 and 9, stands for the 
value of the n-th captured substring (see below). 
The sequence %0 stands for the whole match. The sequence %% stands for a single %.


repl作为表参数
If repl is a table, then the table is queried for every match, 
using the first capture as the key; if the pattern specifies 
no captures, then the whole match is used as the key.

如果参数为函数，则每次匹配成功则调用该函数
If repl is a function, then this function is called every 
time a match occurs, with all captured substrings passed 
as arguments, in order; 

if the pattern specifies no captures,
then the whole match is passed as a sole argument.

If the value returned by the table query or by the function call is a string or a number, 
then it is used as the replacement string; otherwise, if it is false or nil, 
then there is no replacement (that is, the original match is kept in the string).

参数n则限制最大
The optional last parameter n limits the maximum number of substitutions to occur.


举例：
   %1 表示符合模式的第一个匹配
   x = string.gsub("hello world", "(%w+)", "%1 %1")
   --> x="hello hello world world"
     
   第4项
   x = string.gsub("hello world", "%w+", "%0 %0", 1)
   --> x="hello hello world"
   
   hello 和from作为模式中左匹配为%1，world 和lua为右匹配，为%2
   x = string.gsub("hello world from Lua", "(%w+)%s*(%w+)", "%2 %1")
   --> x="world hello Lua from"

   替换 以$打头的字符串
   x = string.gsub("home = $HOME, user = $USER", "%$(%w+)", os.getenv)
   --> x="home = /home/roberto, user = roberto"
   
   参数为函数类型
   x = string.gsub("4+5 = $return 4+5$", "%$(.-)%$", function (s)
           return loadstring(s)()
         end)
     --> x="4+5 = 9"
     
    参数为表类型
   local t = {name="lua", version="5.1"}
   x = string.gsub("$name-$version.tar.gz", "%$(%w+)", t)
   --> x="lua-5.1.tar.gz"

==============================
gmatch 的用法：
在模式符合匹配多次时
Returns an iterator function that, each time it is called,
returns the next captures from pattern over string s. 
If pattern specifies no captures, then the whole match 
is produced in each call.

看例子：
```lua
   s = "hello world from Lua"
   for w in string.gmatch(s, "%a+") do
      print(w)
   end
 ```
  
采用gmatch来解析到表类型
```lua
     t = {}
     s = "from=world, to=Lua"
     for k, v in string.gmatch(s, "(%w+)=(%w+)") do
       t[k] = v
     end
```

一个http传送参数的应用
URL 编码,
这种编码将一些特殊字符（比  '=' '&' '+'）转换为"%XX"形式的编码，
XX是字符的16进制表示，空白为'+'。
如，将"a+b = c"  编码为 "a%2Bb+%3D+c" 
一个典型的参数串：
name=al&query=a%2Bb+%3D+c&q=yes+or+no 

1先把空格和16进制编码转换为ansi码
```lua
function convet1(s) 
  s = string.gsub(s, "+", " ") 
  s = string.gsub(s, "%%(%x%x)", function (h) 
   return string.char(tonumber(h, 16)) 
  end) 
  return s 
end 
```

2.解析参数串
```lua
p = {} 
function decode (s) 
  for name, value in string.gmatch(s, "([^&=]+)=([^&=]+)") do 
  name = unescape(name) 
  value = unescape(value) 
  p[name] = value 
  end 
end 
```





