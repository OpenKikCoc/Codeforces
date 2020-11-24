# STL map and set

[C++ STL: map и set](https://codeforces.com/blog/entry/9702)

By [adamant](https://codeforces.com/profile/adamant), 7 years ago, ![In Russian](https://sta.codeforces.com/s/81190/images/flags/24/ru.png)

## 1. set

### 1.1 声明：

基于红黑树的有序 set 和基于 hash 的无序 set 。

### 1.2 插入：

insert

### 1.3 搜索：

| 函数                                     | 功能     | 复杂度 |
| ---------------------------------------- | -------- | ------ |
| size_type count( const Key& key ) const; | 计数     | n      |
| iterator find( const Key& key );         | 查找     | log    |
| iterator lower_bound( const Key& key );  | 大于等于 | log    |
| iterator upper_bound( const Key& key );  | 严格大于 | log    |

另：两种写法

```c++
set<int> t;
lower_bound(t.begin(),t.end(),number); // 错误写法
t.lower_bound(number); // 正确写法
```

### 1.4 删除

| 函数                                         | 功能 | 复杂度 |
| -------------------------------------------- | ---- | ------ |
| iterator erase( const_iterator position );   |      |        |
| size_type erase( const key_type& key );      |      |        |
| void erase( iterator first, iterator last ); |      |        |
|                                              |      |        |

