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