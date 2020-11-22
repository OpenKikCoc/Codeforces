# ATTENTION

>   links: https://github.com/wangdh15/Data-Structre-And-Algorithm/blob/master/一些注意事项.md

## 1 哈希卡常

`unordered_map ` 和 `unordered_set` 

-   自带较大常数，可能还没有`map`跑的快
-   hack 数据，导致单次复杂度劣化成 𝑂(𝑛)。

如果要想防止被卡，可以自己写哈希函数，让哈希函数和时间戳有关即可。

```c++
struct custom_hash {
	  static uint64_t splitmix64(uint64_t x) {
		    x ^= x << 13;
		    x ^= x >> 7;
		    x ^= x << 17;
		    return x; 
	  }
	  size_t operator () (uint64_t x) const {
	    	static const uint64_t FIXED_RANDOM = chrono::steady_clock::now().time_since_epoch().count(); // 时间戳
		    return splitmix64(x + FIXED_RANDOM);
  	}
};

unordered_map<uint64_t, int, custom_hash> safe_map; // 按照这个定义即可
```

[参考文献](https://www.cnblogs.com/Lskkkno1/p/12667149.html)

## 2 数组初始化

在多个测试样例需要对静态数组进行初始化的时候，如果开的数据较大，且每次有较多浪费，那么最好**不要用memset**。会比较浪费时间。

最好手动清空，使用`for`循环即可。

## 3 输入输出

用`scanf/printf`，不要使用`cin/cout`。

在使用`cout`输出换行的时候，不要`cout << endl`,要`cout << '\n'`。

>    每次 cout endl 都会刷缓冲区

就算要用，也要加上以下代码

```c++
ios::sync_with_stdio(false);
cin.tie(nullptr);
cout.tie(nullptr);
```


## 