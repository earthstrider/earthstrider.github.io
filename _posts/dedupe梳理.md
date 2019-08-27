dedupe是使用机器学习方法在结构化数据上进行**实体去重**和**实体解析**的库。



**属性类型**

实体的属性类型多种多样，对于不同属性类型，相似度计算方式不同，例如使用编辑距离计算两个字符串之间的相似度，使用半正矢公式计算球面上的两个坐标间的距离。dedupe将属性分为ShortString、String、Text、LatLong、Set、Price、Iteraction、Exists、Exact、Categorical 10种类型，另外定义三种扩展的属性类型：Address、Name、FuzzyCategorical。当然也可以自定义属性类型，下面对属性类型和扩展属性类型，以及如何自定义属性类型进行一一解释。



我们也可以从属性类型的角度对数据进行分类，dedupe将数据分为ShortString、String、Text、LatLong、Set、Price、Iteraction、Exists、Exact、Categorical 10种类型，另外定义三种扩展属性类型：Address、Name、FuzzyCategorical。当然也可以自定义属性类型，下面对属性类型以及扩展属性类型进行一一解释：

ShortString、String、Text、LatLong、Set、Price、Iteraction、Exists、Exact、Categorical 





**API**

Dedupe



StaticDedupe



RecordLink



StaticRecordLink




Gazetteer



StaticGazetteer



GazetteerMatching



![image-20190826214609036](/Users/yanyong/Library/Application Support/typora-user-images/image-20190826214609036.png)





如何分块？



S排列，minHash算法计算的$$h_{min}(S)$$不一样吗？



TF-IDF

TF（词频）：词A在某文档中出现的次数，再归一化；

IDF（反文档词频）：总文档个数/包含词A的文档个数，包含词A的文档个数越多，IDF越大，说明词A具有很好的分类能力。



