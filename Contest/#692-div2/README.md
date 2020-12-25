# [Contest 1465](https://codeforces.com/contest/1465)

### [A](https://codeforces.com/contest/1465/problem/A)

```c++
#include <bits/stdc++.h>
using namespace std;
 
int main() {
    int T;
    cin >> T;
    while (T--) {
        int n;
        string s;
        cin >> n >> s;
        int p = n - 1;
        while (p >= 0 && s[p] == ')') --p;
        if (p + 1 >= n - p - 1)
            cout << "No" << endl;
        else
            cout << "Yes" << endl;
    }
    return 0;
}
```

### [B](https://codeforces.com/contest/1465/problem/B)

```c++
#include <bits/stdc++.h>
using namespace std;
 
using LL = long long;
 
bool check(LL x) {
    string s = to_string(x);
    for (auto c : s) {
        int t = c - '0';
        if (t && x % t) return false;
    }
    return true;
}
 
int main() {
    int T;
    cin >> T;
    while (T--) {
        LL n;
        cin >> n;
        while (!check(n)) ++n;
        cout << n << endl;
    }
    return 0;
}
```

### [C](https://codeforces.com/contest/1465/problem/C)

```c++
#include <bits/stdc++.h>
using namespace std;
 
const int N = 100010;
 
int p[N];
 
int find(int x) {
    if (p[x] != x) return p[x] = find(p[x]);
    return p[x];
}
 
int main() {
    int T;
    cin >> T;
    while (T--) {
        int n, m;
        cin >> n >> m;
        for (int i = 1; i <= n; ++i) p[i] = i;
 
        int res = m;
        for (int i = 0; i < m; ++i) {
            int x, y;
            cin >> x >> y;
            if (x == y) {
                --res;
                continue;
            }
            if (find(x) != find(y)) {
                p[find(x)] = find(y);
            } else {
                ++res;
            }
        }
        cout << res << endl;
    }
    return 0;
}
```

### [D](https://codeforces.com/contest/1465/problem/D)

```c++
#include <bits/stdc++.h>
using namespace std;
 
using LL = long long;
 
const int INF = 0x3f3f3f3f;
const int N = 100010;
 
LL pre[N][3], suf[N][3];  // 0, 1, ?
 
int main() {
    string s;
    LL a1, a2;
    cin >> s >> a1 >> a2;
 
    int n = s.size();
    vector<int> ve;
    for (int i = 1; i <= n; ++i) {
        pre[i][0] = pre[i - 1][0] + (s[i - 1] == '0');
        pre[i][1] = pre[i - 1][1] + (s[i - 1] == '1');
        pre[i][2] = pre[i - 1][2] + (s[i - 1] == '?');
        if (s[i - 1] == '?') ve.push_back(i);
    }
    for (int i = n; i >= 1; --i) {
        suf[i][0] = suf[i + 1][0] + (s[i - 1] == '0');
        suf[i][1] = suf[i + 1][1] + (s[i - 1] == '1');
        suf[i][2] = suf[i + 1][2] + (s[i - 1] == '?');
    }
 
    LL cnt0 = 0, cnt1 = 0, ans = 0;
    for (int i = 1; i <= n; ++i) {
        if (s[i - 1] == '0')
            ans = ans + cnt1 * a2, ++cnt0;
        else
            ans = ans + cnt0 * a1, ++cnt1;
    }
    LL res = ans;
    if (a1 < a2) {
        for (auto i : ve) {
            res =
                res - (pre[i - 1][0] + pre[i - 1][2]) * a1 - suf[i + 1][0] * a2;
            res =
                res + pre[i - 1][1] * a2 + (suf[i + 1][1] + suf[i + 1][2]) * a1;
            ans = min(ans, res);
        }
    } else {
        for (int x = ve.size() - 1; x >= 0; --x) {
            LL i = ve[x];
            res =
                res - pre[i - 1][0] * a1 - (suf[i + 1][0] + suf[i + 1][2]) * a2;
            res =
                res + (pre[i - 1][1] + pre[i - 1][2]) * a2 + suf[i + 1][1] * a1;
            ans = min(ans, res);
        }
    }
    cout << ans << endl;
    return 0;
}
```

### [E](https://codeforces.com/contest/1465/problem/E)


### [F](https://codeforces.com/contest/1465/problem/F)
