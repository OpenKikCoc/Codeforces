# [C++ Tricks](https://codeforces.com/blog/entry/15643)

By [Swift](https://codeforces.com/profile/Swift), 6 years ago, ![In English](https://sta.codeforces.com/s/94915/images/flags/24/gb.png)



## 1. 使用大括号构造

```c++
pair<int, int> p;
vector<int> v;
// ...
p = make_pair(3, 4);
v.push_back(4); v.push_back(5);
```

better:

```c++
pair<int, int> p;
vector<int> v;
// ...
p = {3, 4};
v = {4, 5};
```

更复杂的示例：

```c++
pair<int, pair<char, long long> > p;
// ...
p = {3, {'a', 8ll}};
```

以及 `vector` , `deque` , `set` 和其他容器：

```c++
vector<int> v;
v = {1, 2, 5, 2};
for (auto i: v)
    cout << i << ' ';
cout << '\n';
// prints "1 2 5 2"


deque<vector<pair<int, int>>> d;
d = {{{3, 4}, {5, 6}}, {{1, 2}, {3, 4}}};
for (auto i: d) {
    for (auto j: i)
        cout << j.first << ' ' << j.second << '\n';
    cout << "-\n";
}
// prints "3 4
//         5 6
//         -
//	   1 2
//	   3 4
//	   -"


set<int> s;
s = {4, 6, 2, 7, 4};
for (auto i: s)
    cout << i << ' ';
cout << '\n';
// prints "2 4 6 7"


list<int> l;
l = {5, 6, 9, 1};
for (auto i: l)
    cout << i << ' ';
cout << '\n';
// prints "5 6 9 1"


array<int, 4> a;
a = {5, 8, 9, 2};
for (auto i: a)
    cout << i << ' ';
cout << '\n';
// prints "5 8 9 2"


tuple<int, int, char> t;
t = {3, 4, 'f'};
cout << get<2>(t) << '\n';
```

注意 对  `stack`, `queue` 不能使用。

## 2. 借助宏打印变量名

```c++
#define what_is(x) cerr << #x << " is " << x << endl;
// ...
int a_variable = 376;
what_is(a_variable);
// prints "a_variable is 376"
what_is(a_variable * 2 + 1)
// prints "a_variable * 2 + 1 is 753"
```

## 3. includes

使用：

```c++
#include <bits/stdc++.h>
```

## 4. 内置函数

### **1) 公约数**

```c++
__gcd(value1, value2)
```

**e.g.** __gcd(18, 27) = 9.



### **2) 最后一个二进制为1的位是哪一位，对于0直接返回0**

```c++
__builtin_ffs(x)
```

Here x is `int`, this function with suffix 'l' gets a `long` argument and with suffix 'll' gets a `long long` argument.

**e.g.** __builtin_ffs(10) = 2 because 10 is '...10 **1** 0' in base 2 and first 1-bit from right is at index 1 (0-based) and function returns 1 + index.



### **3) 前导0的个数，对于0结果未定义**

```c++
__builtin_clz(x)
```

 x is `unsigned int` and like previous function this function with suffix 'l gets a `unsigned long` argument and with suffix 'll' gets a `unsigned long long` argument. If x == 0, returns an undefined value.

**e.g.** __builtin_clz(16) = 27 because 16 is ' **...** 10000'. Number of bits in a `unsigned int` is 32. so function returns 32 — 5 = 27.



### **4) 末尾0的个数，对于0结果未定义**

```c++
__builtin_ctz(x)
```

x is `unsigned int` and like previous function this function with suffix 'l' gets a `unsigned long` argument and with suffix 'll' gets a `unsigned long long` argument. If x == 0, returns an undefined value.

**e.g.** __builtin_ctz(16) = 4 because 16 is '...1 **0000** '. Number of trailing 0-bits is 4.



### **5) 1的个数**

```c++
__builtin_popcount(x)
```

x is `unsigned int` and like previous function this function with suffix 'l' gets a `unsigned long` argument and with suffix 'll' gets a `unsigned long long` argument. If x == 0, returns an undefined value.

**e.g.** __builtin_popcount(14) = 3 because 14 is '... **111** 0' and has three 1-bits.

**Note:** There are other `__builtin` functions too, but they are not as useful as these ones.

**Note:** Other functions are not unknown to bring them here but if you are interested to work with them, I suggest [this website](http://www.cplusplus.com/).

## 5. 可变函数和宏

### 1) 入参增强

对 int 求和：

```c++
int sum() { return 0; }

template<typename... Args>
int sum(int a, Args... args) { return a + sum(args...); }

int main() { cout << sum(5, 7, 2, 2) + sum(3, 4); /* prints "23" */ }
```

对任意类型求和：

```c++
int sum() { return 0; }

template<typename T, typename... Args>
T sum(T a, Args... args) { return a + sum(args...); }

int main() { cout << sum(5, 7, 2, 2) + sum(3.14, 4.89); /* prints "24.03" */ }
```

> In C++14 you can also use `auto sum(T a, Args... args)` in order to get sum of mixed types. (Thanks to [slycelote](https://codeforces.com/profile/slycelote) and [Corei13](https://codeforces.com/profile/Corei13))

借助宏：

```c++
#define a_macro(args...) sum(args)

int sum() { return 0; }

template<typename T, typename... Args>
auto sum(T a, Args... args) { return a + sum(args...); }

int main() { cout << a_macro(5, 7, 2, 2) + a_macro(3.14, 4.89); /* prints "24.03" */ }
```

### 2) debug

```c++
#include <bits/stdc++.h>

using namespace std;

#define error(args...) { string _s = #args; replace(_s.begin(), _s.end(), ',', ' '); stringstream _ss(_s); istream_iterator<string> _it(_ss); err(_it, args); }

void err(istream_iterator<string> it) {}
template<typename T, typename... Args>
void err(istream_iterator<string> it, T a, Args... args) {
	cerr << *it << " = " << a << endl;
	err(++it, args...);
}

int main() {
	int a = 4, b = 8, c = 9;
	error(a, b, c);
}
Output:

a = 4
b = 8
c = 9
```

## 6. C++ 新特性

### 1) 迭代器

```c++
set<int> s = {8, 2, 3, 1};
for (set<int>::iterator it = s.begin(); it != s.end(); ++it)
    cout << *it << ' ';
// prints "1 2 3 8"
```

better:

```c++
set<int> s = {8, 2, 3, 1};
for (auto it: s)
    cout << it << ' ';
// prints "1 2 3 8"
```

以及

```c++
vector<int> v = {8, 2, 3, 1};
for (auto &it: v)
    it *= 2;
for (auto it: v)
    cout << it << ' ';
// prints "16 4 6 2"
```

### 2) auto

auto 类型推导

以及：

>  x.begin() and x.end() now are accessible using begin(x) and end(x).





# 一些代码技巧

## 1. 输出空格和换行

输出

```c++
for(i = 1; i <= n; i++) {
    for(j = 1; j <= m; j++)
        cout << a[i][j] << " ";
    cout << "\n";
}
```

better:

```c++
for(i = 1; i <= n; i++)
    for(j = 1; j <= m; j++)
        cout << a[i][j] << " \n"[j == m];
```

>  `" \n"` is a `char*`, `" \n"[0]` is `' '` and `" \n"[1]` is `'\n'`.

## 2. tie emplace_back

Usage of `tie` and `emplace_back`:

```c++
#define mt make_tuple
#define eb emplace_back
typedef tuple<int,int,int> State; // operator< defined

int main(){
  int a,b,c;
  tie(a,b,c) = mt(1,2,3); // assign
  tie(a,b) = mt(b,a); // swap(a,b)

  vector<pair<int,int>> v;
  v.eb(a,b); // shorter and faster than pb(mp(a,b))

  // Dijkstra
  priority_queue<State> q;
  q.emplace(0,src,-1);
  while(q.size()){
    int dist, node, prev;
    tie(dist, ode, prev) = q.top(); q.pop();
    dist = -dist;
    // ~~ find next state ~~
    q.emplace(-new_dist, new_node, node);
  }
}
```

> And that's why `emplace_back` faster: `emplace_back` is faster than `push_back` 'cause it just construct value at the end of vector but `push_back` construct it somewhere else and then move it to the vector.

Also in the code above you can see how `tie(args...)` works. You can also use `ignore` keyword in `tie` to ignore a value:

```
tuple<int, int, int, char> t (3, 4, 5, 'g');
int a, b;
tie(b, ignore, a, ignore) = t;
cout << a << ' ' << b << '\n';
```

Output: `5 3`

## 3. 宏定义迭代器

```c++
#define rep(i, begin, end) for (__typeof(end) i = (begin) - ((begin) > (end)); i != (end) - ((begin) > (end)); i += 1 - 2 * ((begin) > (end)))
```

1. 无需关注类型
2. 可自动向前 or 向后遍历

```c++
vector<int> v = {4, 5, 6, 4, 8};
rep(it, end(v), begin(v))
    cout << *it << ' ';
// prints "8 4 6 5 4"
```

## 4. lambda

```c++
[capture list](parameters) -> return value { body }
```

e.g.

```
auto f = [] (int a, int b) -> int { return a + b; };
cout << f(1, 2); // prints "3"
```

You can use lambdas in `for_each`, `sort` and many more STL functions:

```
vector<int> v = {3, 1, 2, 1, 8};
sort(begin(v), end(v), [] (int a, int b) { return a > b; });
for (auto i: v) cout << i << ' ';
```

Output:

```
8 3 2 1 1
```

## 5. move

移动而非拷贝

```c++
vector<int> v = {1, 2, 3, 4};
vector<int> w = move(v);

cout << "v: ";
for (auto i: v)
    cout << i << ' ';

cout << "\nw: ";
for (auto i: w)
    cout << i << ' ';
Output:

v: 
w: 1 2 3 4 
```

## 6. Strings

**1) Raw Strings**

```c++
string s = R"(Hello, World!)"; // Stored: "Hello, World!"
```

A raw string skips all escape characters like `\n` or `\"`. e.g.

```c++
string str = "Hello\tWorld\n";
string r_str = R"(Hello\tWorld\n)";
cout << str << r_str;
```

Output:

```c++
Hello	World
Hello\tWorld\n
```

You can also have multiple line raw string:

```c++
string r_str =
R"(Dear Programmers,
I'm using C++11
Regards, Swift!)";
cout << r_str;
```

Output:

```c++
Dear Programmer,
I'm using C++11
Regards, Swift!
```

**2) 正则**

> We will use raw string for them because sometimes they have `\` and other characters.

```
regex email_pattern(R"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)"); 
// This email pattern is not totally correct! It's correct for most emails.
```

```
string
valid_email("swift@codeforces.com"),
invalid_email("hello world");

if (regex_match(valid_email, email_pattern))
    cout << valid_email << " is valid\n";
else
    cout << valid_email << " is invalid\n";

if (regex_match(invalid_email, email_pattern))
    cout << invalid_email << " is valid\n";
else
    cout << invalid_email << " is invalid\n";
```

Output:

```
swift@codeforces.com is valid
hello world is invalid
```

**Note:** You can learn Regex in [this website](http://regexone.com/).

**3) 常量**

> You already know literals from C++ like: `0xA`, `1000ll`, `3.14f` and so on...

```c++
long long operator "" _m(unsigned long long literal) {
	return literal;
}

long double operator "" _cm(unsigned long long literal) {
	return literal / 100.0;
}

long long operator "" _km(unsigned long long literal) {
	return literal * 1000;
}

int main() {
	// See results in meter:
	cout << 250_m << " meters \n"; // Prints 250 meters
	cout << 12_km << " meters \n"; // Prints 12000 meters
	cout << 421_cm << " meters \n"; // Prints 4.21 meters
}
```

Note that a literal should start with an underscore (`_`). We declare a new literal by this pattern:

```c++
[returnType] operator "" _[name]([parameters]) { [body] }
```

note that parameters only can be one of these:

```c++
(const char *)
(unsigned long long int)
(long double)
(char)
(wchar_t)
(char16_t)
(char32_t)
(const char *, size_t)
(const wchar_t *, size_t)
(const char16_t *, size_t)
(const char32_t *, size_t)
```

Literals also can used with templates.