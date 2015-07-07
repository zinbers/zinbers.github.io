---
layout: post
title: 字符串匹配算法
category: 编程
tags: string match
keywords: string match program
description: 
---
```cpp
#include <iostream>
#include <string.h>
using namespace std;

const int WORD = 26;
int sunday(const char* src, const char *patt)
{
	int len_src = strlen(src);	
	int len_patt = strlen(patt);
	int next[WORD] = {0};
	for( int i = 0 ; i < WORD; i++)
		next[i] = len_patt;
	for(int i = 0; i < len_patt; i++)
		next[patt[i] - 'a'] = len_patt - i;
	int pos = 0;
	int i,j;
	int jumpTime = 0;
	while( pos < (len_src - len_patt - 1))
	{
		i = pos;
		for(j = 0; j < len_patt ; i++,j++)
		{
			if (src[i] != patt[j])
			{
				jumpTime ++;
				cout<<"pos:"<<pos<<endl;
				cout<<"jumpTime:"<<jumpTime<<" jumpDis:"<<next[src[pos + len_patt] - 'a']<<endl;
				pos += next[src[pos + len_patt] - 'a'];
				break;
			}
		}
		if ( j == len_patt)
			return pos;
	}
	return -1;
}

int main(void)
{
	char *src = "abcdabccdabasdfacxdfcv";
	char *patt="aba";
	int pos = sunday(src,patt);
	cout<<"pos:"<<pos<<endl;
	return 0;
}
```