---
layout: post
title:  完美洗牌算法
category: acm
tags: acm  program algorithm
keywords: acm  program algorithm
description:
comments: true
---

将数组[a1,a2...an,b1,b2...bn] 变换为[b1,a1,b2,a2...bn,an]
时间复杂度O(n), 空间复杂度O(1)

```cpp
#include<iostream>
using namespace std;

void printArray(int* pArr,int arrLen){
    cout<<"-------------------"<<endl;
    for(int i = 1; i <= arrLen; i++){
        cout<< pArr[i] << " ";
    }
    cout<<endl;
}

void reverse(int *pArr, int start, int end){
    while(start < end){
        swap(pArr[start],pArr[end]);
        start++;
        end--;
    }
}
//循环左移
void leftRotate(int *head, int step, int moveLength){
    step = step % moveLength;
    reverse(head,1,step);
    reverse(head,step + 1,moveLength);
    reverse(head,1,moveLength);
}
//走圈
void runCircle(int *pArr, int start, int n){
    int pre = pArr[start];
    int mod = 2 * n + 1;
    int next = (2 * start) % mod ;
    while (next != start){
        swap(pre,pArr[next]);
        next = (2 * next) % mod;
    }
    pArr[start] = pre;
}

void run(int *pArr, int n){
    while(n >=1 ){
        int k = 0;
        int r = 3;
        while (r - 1 <= 2 * n){
            r *= 3;
            k++;
        }
        int m = (r / 3 - 1) / 2;
        //cout<<m << " "<< n<<endl;
        leftRotate(pArr + m, n - m, n );
        //printArray(pArr,2*n);
        int start = 1;
        for(int i = 0; i < k; i++){
            runCircle(pArr,start,m);
            start *= 3;
        }
        pArr += 2 * m;
        n -= m;
    }

}

int main(void){
    int arr[13];
    int len=sizeof(arr)/sizeof(int);
    for(int i = 0; i < len; i++){
        arr[i] = i;
    }
    printArray(arr,len - 1);
    run(arr,6);
    printArray(arr,len - 1);
    return 0;
}

```