---
layout:     post
title:      Denoising Distantly Supervised Open-Domain Question Answering
subtitle:   
date:       2019-08-10
author:     猫不见了
comments:	true
header-img: img/post-bg-os-metro.jpg
catalog: true
tags:
    - Paper
---



[Denoising Distantly Supervised Open-Domain Question Answering](https://pdfs.semanticscholar.org/f4e7/03d2845c540ef0ff6c99cdd53017dfbfe595.pdf)

Yankai Lin, Haozhe Ji, Zhiyuan Liu, Maosong Sun



### 研究动机



已存在的远程监督模型使用阅读理解技术从相关段落中提取答案，但忽视其它段落中包含有价值的信息；

远程监督数据不可避免含有错误信息，这些数据噪点严重影响远程监督模型的性能。





### 研究方法



**问题定义**



给定一个问题 $$q=(q^1,q^2,...,q^{  \vert   q  \vert  })$$，提取$m$个段落$$P=\{p_1,p_2,…,p_m\}$$，其中第$$i$$个段落$$p_i=(p_i^1,p_i^2,…,p_i^{  \vert  p_i \vert })$$。



模型由段落选择器和段落阅读器组成。

段落选择器，用来过滤noisy paragraphs，计算概率分布$$Pr(p_i \vert q,P)$$。

段落阅读器，用来从denoised paragraphs中提取答案，使用多层long short-term memory network计算$$Pr(a \vert q,p_i)$$。



最后问题$$q$$的答案是$$a$$的概率：


$$
Pr(a|q,P)=\sum Pr(p_i|q,P) Pr(a|q,p_i)
$$



**段落选择器**

1. 段落编码。首先获得段落每个词$$p_i^j$$的语义编码$$\hat p_i^j$$，然后对词的语义编码进行连接得到段落的语义编码$$\{\hat p_i^1,\hat p_i^2,…,\hat p_i^{ \vert p_i \vert } \}$$。文中提到获得词语义编码的两种方式，分别是MLP和RNN；

2. 问题编码。计算问题的语义编码$$\{\hat q^1,\hat q^2,…,\hat q^{ \vert  q  \vert  } \}$$，使用self attention operation on the hidden representations获得问题$$q$$的表示$$\hat q = \sum \limits_j \alpha^j \hat q^j$$。

3. 计算$$Pr(p_i  \vert  q,P)$$。$$Pr(p_i  \vert  q,P)=softmax(\max \limits_j(\hat p_i^jWq))$$。

问题：$$W$$的维度？



**段落阅读器**

$$Pr(a  \vert  q,p_i)=Pr_s(a_s)Pr_e(a_e)$$，$$a_s,a_e$$分别是答案$$a$$的开始位置和结束位置。

$$Pr_s(j)=softmax(\bar p_i^j W_s \bar q)$$

$$Pr_e(j)=softmax(\bar p_i^j W_e \bar q)$$



最后$$Pr(a \vert q,p_i)$$的计算有两种方式

第一种：取最大值
$$
Pr(a|q,p_i) = \max_jPr_s(a_s^j)Pr_e(e_e^j)
$$

第二种：求和
$$
Pr(a|q,p_i)=\sum_jPr_s(a_s^j)Pr_e(e_e^j)
$$
问题：为啥是求和，有何含义？



**损失函数**

使用的是$$\log$$损失函数

$$
L(\theta)=-\sum_{(\bar a,q,P)\in T}logPr(a|q,P)-\alpha R(P)
$$

$$R(P)$$是惩罚项。





#### 实验结果 

段落选择器和段落阅读器分开比较：

<img src="http://ww4.sinaimg.cn/large/006tNc79ly1g5yaytaw5aj30hl0g7juc.jpg" width = "60%"/>

Our+AVG是Our+FULL的naive版本的模型。使用RNN作为选择器效果更好，使用Max模型作为阅读器效果更好。



在5个数据集上的表现效果：
![image-20190813194404120](http://ww3.sinaimg.cn/large/006tNc79ly1g5yaz04x7ij30zn0d3785.jpg)





### 个人点评

文章写作有些小错误，公式略有不规范。

文章提到答案重排，引入知识库作为背景知识来提高模型性能，关注一下。