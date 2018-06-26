使用Matlab(R2016b)实现：
1 心理学不同大小的样本模拟数据生成；
2 对数据进行不同程度的截尾，生成截尾数据；

使用 Stata 14.0 进行数据分析，实现：
https://www.newasp.net/soft/236636.html

3 使用多种回归算法（OLS，tobit）对数据进行分析；比较各种方法对完整数据模拟的拟合程度：
3.1 经典线性回归算法：普通最小二乘方法（Ordinary Least Square）
3.2 截尾数据在心理学中的应用：受限因变量模型（tobit regression）

使用matlab自带函数包括：polyfit（最小二乘）；
自编函数包括：tobit（受限因变量）