### 215. Kth Largest Element in an Array

方法一：擂台法

思路：使用擂台法找最大值，循环k次，此方法最坏时间复杂是o(n^2)。

```c
int findKthLargest(vector<int>& nums, int k) {

    int n = nums.size();
    
    for(int i = 0; i < k; i++){
        int cur_max = i;
        int j;
        for(j = i+1; j < n; j++){
            if(nums[j] > nums[cur_max])
                cur_max = j;
        }
        swap(nums[i], nums[cur_max]);
    }
    
    return nums[k-1];
}
```


方法二：使用最小堆的数据结构

思路：最小堆其实是一个二叉树，树中每个节点的值都小于左子树以及右子树中所有节点的值。关键是将该二叉树的节点数n维持在k个，一旦n>k，立刻进行pop操作，删除该树值最小的节点，也就是根节点，pop操作会维持最小堆的性质。这样含有k个节点的最小堆，根节点就是第k大的数所在的节点。

```c
int findKthLargest_prio_queue(vector<int>& nums, int k) {
    priority_queue<int, vector<int>, greater<int>> pq;
    
    for(int num: nums){
        pq.push(num);
        
        if(pq.size() > k)
            pq.pop();
    }
    
    return pq.top();
}
```


方法三：借鉴快速排序的思想

思路：每一轮快速排序，都会确定一个数的位置，利用这个性质，通过二分的方式，可以确定第k大的数的位置。

```c
int findKthLargest_quik_sort(vector<int>& nums, int k) {

    int n = nums.size();
    int start = 0, end = n-1;
    
    while(true){
        int rs = compare(nums, start, end);
        
        cout<<rs<<" "<<nums[rs]<<" "<< endl;
        
        if(rs==n-k)
            return nums[rs];
        else if(rs>n-k)
            end = rs-1;
        else
            start = rs+1;
    }
}

int compare(vector<int>& nums, int start, int end){
    int i = start, j = end, k = start;
    
    while(i<j){
        while(k<j && nums[k] <= nums[j]) j--;

        swap(nums[i], nums[j]);
        k = j;
        
      	while(k>i && nums[k] >= nums[i]) i++;
        swap(nums[i], nums[j]);
        k = i;
    }
    return k;
}
```





### 20. Valid Parentheses

思路：用栈来处理这类括号匹配问题。若遇到左括号直接进栈；遇到右括号，如果其与栈顶元素匹配，则栈顶元素出栈，若不匹配，则右括号入栈。最后栈为空则返回true，否则返回false。



这里可以有个小的优化，就是如果遇到右括号，且不能和栈顶元素匹配，则可以直接返回false，程序结束。代码入下：

```c
class Solution {
public:
    bool isValid(string s) {
        stack<char> pipe;
        
        for(char c : s){

            if(pipe.empty()){
                pipe.push(c);
                continue;
            }
            
            char x = pipe.top();
            if(x=='(' && c==')' || x=='{' && c=='}' || x=='[' && c==']')  // 右括号和栈顶元素匹配
                pipe.pop();
            else if(c==')' || c=='}' || c==']'){  // 右括号和栈顶元素匹配不匹配
                return false;
            }
            else  // 遇到左括号
                pipe.push(c);
        }
        
        return pipe.empty();
    }
};
```



问题：给出的匹配符号只有三对，如果有很多对如何处理？



### 155. Min Stack

拿到题目其实有点懵逼，参考别人的代码才有点思路。

此题关键点就是如果用 o(1) 的时间求最小值，思路是使用两个栈，第二个栈保证非严格递减，这样第二个栈的top元素就是当前栈的最小值，这里需要稍微思考一下原因。



第一次提交的代码如下，不出所料，没通过enen..em。


```c
class MinStack {
public:
    /** initialize your data structure here. */
    MinStack() {
        
    }
    
    void push(int x) {
        origin_stack.push(x);
        
        if(helper_stack.empty())
            helper_stack.push(x);
        
        else if(!helper_stack.empty() && x < helper_stack.top())
            helper_stack.push(x);
    }
    
    void pop() {
        int x = origin_stack.top(); 
        origin_stack.pop();
        
        if(helper_stack.top() == x)
            helper_stack.pop();
    }
    
    int top() {
        return origin_stack.top();
    }
    
    int getMin() {
        return helper_stack.top();
    }

private:
    stack<int> origin_stack;
    stack<int> helper_stack;
};

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack* obj = new MinStack();
 * obj->push(x);
 * obj->pop();
 * int param_3 = obj->top();
 * int param_4 = obj->getMin();
 */
```

原因就是第14行代码，在x = helper_stack.top()时，第二个辅助栈也是要push元素x的。

比如push的顺序是 9 4 4，那么此时辅助栈应该是 9 4 4。如果第二个4不push，辅助栈是9 4，此时删除栈顶元素，就不能保证辅助栈的栈顶最小。



当然上面的代码pop和push的细节写的不好，修改后如下：

```c
class MinStack {
public:
    /** initialize your data structure here. */
    MinStack() {
        
    }
    
    void push(int x) {
        origin_stack.push(x);

        
        if(helper_stack.empty() || x <= helper_stack.top())
            helper_stack.push(x);
    }
    
    void pop() {
        if(helper_stack.top() == top())
            helper_stack.pop();
        origin_stack.pop();
    }
                    
    int top() {
        return origin_stack.top();
    }
    
    int getMin() {
        return helper_stack.top();
    }

private:
    stack<int> origin_stack;
    stack<int> helper_stack;
};

```