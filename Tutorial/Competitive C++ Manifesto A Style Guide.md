# Competitive C++ Manifesto: A Style Guide

[Competitive C++ Manifesto: A Style Guide](https://codeforces.com/blog/entry/64218)

By [Swift](https://codeforces.com/profile/Swift), [history](https://codeforces.com/topic/64623/en3), 23 months ago, ![In English](https://sta.codeforces.com/s/81190/images/flags/24/gb.png)

## 1. 编译器

使用 C++ 17 以及 `-Wall -Wextra -Wshadow` 编译选项消除警告消息。

使用 `-fsanitize=undefined` 消除例如数组超范围访问和运行时整数溢出的错误。

## 2. 命名

C ++库对函数和类使用snake_case，为了将用户定义的代码与标准库区分开，我们将使用CamelCase【驼峰命名】。

-   类型使用 UpperCamelCase： `Point`，`SegTree`
-   函数和变量使用 lowerCamelCase： `someMethod`，`someVariable`
-   宏和常量使用由分隔全部使用大写字母`_`：`SOME_MACRO`，`MAX_N`，`MOD`
-   使用有意义的名称或至少对您而言足够有意义。

```c++
#define LOCAL
const double PI = 3.14;

struct MyPoint {
    int x, y;
    bool someProperty;
    
    int someMethod() {
        return someProperty ? x : y;
    }
};
```

## 3. 评论和注释

`//` `/*xxx*/`

## 4. 间距

-   缩进：2 / 4 个空格而非 tab
-   打括号不换行
-   控制流语句尽量使用大括号
-   else if 同行
-   宽度合理（80列）
-   方法之间保留空白行
-   二进制运算两侧隔开
-   一元运算与左侧隔开
-   括号`<> [] {}`是其标识符等的一部分`a[5]`，`vector<int>`或`pair{1, 2}`
-   括号**只能**像那样与外部隔开`(-a[3] + b) * (c + d)`
-   分号和逗号只能从右侧隔开
-   问号和冒号应在两侧隔开
-   每行末尾不应有多余空格
-   文件末尾添加换行符
-   控制流语句后应恰好有一个空格 如 `if (flag)`
-   函数调用无空格 如 `func(arg)`
-   宏和头文件
-   模版 `template <typename T>` 应单独一行 后跟换行
-   范围解析运算符 `::` 是标识符的一部分 不能隔开
-   指针和引用 应保有空格
-   `.`  `->`    不应隔开 当 `->` 用于 Lambda 表达式的返回值时应两侧隔开
-   Lambda 表达式应写成`[](int x) -> int { return x + 1; }` 大多数时候可以省略返回类型。如果它具有多于一行的代码 则可以像函数一样随意扩展主体 
-   重载运算符时，将其视为函数，名称中不得包含空格 `bool operator!();`
-   省略号`...`应该**只**从左侧隔开。

例

```c++
#include <bits/stdc++.h>

using namespace std;

const int DIFF = 10;

template <typename T>
struct Point {
    T x, y;
    
    Point(T _x, T _y) : x(_x), y(_y) {}
    
    friend ostream& operator<<(ostream& os, const Point& p) {
        return os << "(" << p.x << ", " << p.y << ")";
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    vector<Point<int>> v;
    for (int i = 0; i < 5; ++i) {
        v.push_back({i, i + DIFF});
    }
    for (auto p : v) {
        if (p.x + DIFF == p.y) {
            cout << p << '\n';
        } else {
            cout << "huh!?\n"; // will never get printed!
        }
    }
}
```

输出

```
(0, 10)
(1, 11)
(2, 12)
(3, 13)
(4, 14)
```

## 5. 竞赛编程建议

-   使用 `#include <bits/stdc++.h>` 而不是许多 include
-   使用 `using namespace std;` 而不是每次键入 `std::`
-   使用 `using` 代替 `typedef`  *原因：它与现代C ++的风格更加一致* `using ll = long long;`
-   使用 `struct` 代替 `class`  *原因：它默认公开，我们不需要在竞赛编程中封装！*
-   不要使用太多宏 但不要害怕使用宏 *原因：调试和读取充满丑陋宏的代码并不容易。但是我们毕竟是黑客！*
-   使用 `const` 定义的常数代替 `#define`  *基本原理：const有一个类型 它们在编译时进行评估*
-   为避免错误 可以在 `switch` 的每种 `case` 下使用大括号
-   使用 `auto` 以增加可读性，减少代码大小
-   使用大括号的初始化程序列表
-   处理 pair 和 tuple 的容器时 使用 `emplace` 和 `emplace_back`  *理由：`(elem1, elem2, ...)`代替`({elem1, elem2, ...})`*
-   使用 Lambda 函数 尤其是使用 `sort` 时
-   使用 `nullptr` 代替 `NULL` 或 `0` 
-   布尔值是 `true` 和 `false`
-   用途 `ios::sync_with_stdio(false);` 和 `cin.tie(nullptr);` 使用更快的 I / O `cin/cout`
-   使用以开头的内置函数 `__builtin` 
-   GCD和LCM在C ++ 17 下可用
-   对循环使用C ++ 11 for-each样式`for (auto& elem : vec)`
-   使用C ++ 17 绑定样式，例如`for (auto& [key, val] : dic)`和`auto [x, y] = myPoint;`
-   使用C ++ 17 模板参数推导`pair p{1, 2.5};`代替`pair<int, double> p{1, 2.5};`
-   尽量不使用`goto`！但当需要摆脱几个嵌套循环时可以
-   有些网站（例如codeforce）使用该标志 `-DONLINE_JUDGE` 来编译代码，这意味着您可以自动删除 `cerr` s 或调试功能，或者将输入/输出重定向到文件而不是stdin / stdout等

```c++
#ifdef ONLINE_JUDGE
#define cerr if (false) cerr
#endif 
// Alternatively this can be done using a local -DLOCAL flag
// when compiling on your machine, and using #ifndef LOCAL instead.
```

-   首选使用常规运算符形如 `!, &&, ||, ^, ...` 而不是其替代表示形式 `not, and, or, xor, ...`  *原理：不是在写 Python*