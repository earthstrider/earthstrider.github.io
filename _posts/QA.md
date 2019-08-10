Denoising Distantly Supervised Open-Domain Question Answering



### 研究动机



已存在的远程监督模型使用阅读理解技术从相关段落中提取答案，但忽视其它段落中包含有价值的信息；

远程监督数据不可避免含有错误信息，这些数据噪点严重影响远程监督模型的性能。





### 研究方法



**问题定义**



给定一个问题 $$q=(q^1,q^2,...,q^{|q|})$$，提取$m$个段落$$P=\{p_1,p_2,…,p_m\}$$，其中第$$i$$个段落$$p_i=(p_i^1,p_i^2,…,p_i^{|p_i|})$$。



段落选择器，用来过滤noisy paragraphs，计算概率分布$$Pr(p_i|q,P)$$。

段落阅读器，用来从denoised paragraphs中提取答案，使用多层long short-term memory network计算$$Pr(a|q,p_i)$$。



最后问题$$q$$的答案是$$a$$的概率$$Pr(a|q,P)$$如下计算：


$$
Pr(a|q,P)=\sum Pr(a|q,p_i) Pr(p_i|q,P)
$$



**段落选择器**

段落编码。首先获得段落每个词$$p_i^j$$的语义编码$$\hat p_i^j$$，然后对词的语义编码进行连接得到段落的语义编码$$\{\hat p_i^1,\hat p_i^2,…,\hat p_i^{|p_i|} \}$$。文中提到获得词语义编码的两种方式，分别是MLP和RNN；

问题编码。计算问题的语义编码$$\{\hat q^1,\hat q^2,…,\hat q^{|q|} \}$$，使用self attention operation on the hidden representations获得问题$$q$$的表示$$\hat q = \sum \limits_j \alpha^j \hat q^j$$。

计算$$Pr(p_i|q,P)$$。$$Pr(p_i|q,P)=softmax(\max \limits_j(\hat p_i^jWq))$$。

问题：$$W$$的维度？



**段落阅读器**

$$Pr(a|q,p_i)=Pr_s(a_s)Pr_e(a_e)$$，$$a_s,a_e$$分别是答案$$a$$的开始位置和结束位置。

$$Pr_s(j)=softmax(\bar p_i^j W_s \bar q)$$

$$Pr_e(j)=softmax(\bar p_i^j W_e \bar q)$$



**损失函数**
$$
L(\theta)=-\sum_{(\bar a,q,P)\in T}logPr(a|q,P)-\alpha R(P)
$$






#### 实验结果 





创新点 个人点评