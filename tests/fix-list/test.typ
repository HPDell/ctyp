#import "/lib.typ": *

#let testcase(
  page-args: (:), 
  body
) = {
  let page-args = (
    paper: "a7",
    margin: 1pt,
    ..page-args
  )
  set page(..page-args)
  body
}

#testcase[
  #let (theme, _) = ctyp()
  #show: theme

  = 符号列表

  - 符号项目1
  - 符号项目2
    - 符号项目2.1
    - 符号项目2.2
    - 符号项目2.3
      - 符号项目2.3.1
      - 符号项目2.3.2
    - 符号项目2.3.3
      - 符号项目2.3.3.1
      - 符号项目2.3.3.1
      项目内容可以继续
]

#testcase[
  #let (theme, _) = ctyp()
  #show: theme

  = 编号列表

  + 编号项目1
  + 编号项目2
    + 编号项目2.1
    + 编号项目2.2
  + 编号项目3
    + 编号项目3.1
      + 编号项目3.2
      + 编号项目3.3
    + 编号项目3.2
      + 编号项目3.2.1
      + 编号项目3.2.2
]

#testcase[
  #let (theme, _) = ctyp()
  #show: theme

  = 混合列表

  + 编号项目1
  + 编号项目2
    - 编号项目2.1
    - 编号项目2.2
  + 编号项目3
    - 编号项目3.1
      + 编号项目3.2
        - 3.2.1
        - 3.2.2
          - 3.2.2.1
      + 编号项目3.3
    + 编号项目3.2
      + 编号项目3.2.1
      + 编号项目3.2.2
      + 编号项目3.2.2
]

#testcase[
  #let (theme, _) = ctyp()
  #show: theme

  = 复杂混合列表

  - `family`：一个字典，列出了所用的各种字形，如 `song`, `hei`, `kai`, `fang` 等。
    - `[key]`：字形的名称，是一个字典。
      - `name`：所用的字体的名称。
      - `variants`：这个字体包含的所有变体。
  - `map`：一个字典，列出各种元素所使用的 CJK 字体和西文字体对应关系。
    - `[element]`：元素的名称
      - `cjk`：CJK 字体映射，格式为 `"family":"variant"`。
      - `latin`：西文字体映射，可选项是 `"serif"`, `"sans"`, `"mono"` 或者字体名称。
        - `serif`：使用衬线字体。
        - `sans`：使用无衬线字体。
        - `mono`：使用等宽字体。
]

#testcase[
  #let (theme, _) = ctyp(
    fix-list-enum: false,
  )
  #show: theme

  = 不修复列表

  + 项目1
  + 项目2
    - 项目2.1
    - 项目2.2
    - 项目2.3
      - 项目2.3.1
      - 项目2.3.2
      - 项目2.3.3
        + 项目2.3.3.1
        + 项目2.3.3.2
          + 项目2.3.3.2.1
]

#testcase[
  #let (theme, _) = ctyp(
    fix-enum-args: (
      numberer: (
        enum-label("1.", width: 1em, alignment: left),
        "a.",
        enum-label("i)", width: 1em, alignment: right),
      )
    ),
    fix-list-args: (
      marker: (
        item-label(sym.suit, width: 1em),
        sym.dash
      )
    )
  )
  #show: theme

  = 设置编号格式

  + 测试
    + 测试
      + 测试
  
  - 测试
    - 测试
]

#testcase[
  #let (theme, _) = ctyp()
  #show: theme

  = 混合列表
  
  + 使用 GWR 初始化所有参数 $beta_(i j) (i=1,2,dots.c,n;j=1,2,dots.c,k)$
  + 迭代执行以下步骤：
    + 对于每组变量 $beta_j$：
      + 计算 $tilde(y) = y - sum_(l eq.not j) x_(i j) beta_j (u_i)$
      + 估计 $ hat(beta)_j (u_i) = (X_j^T W_(i) X_j)^(-1) $
    + 计算残差平方和 RSS。
  + 如果 RSS 收敛，则停止迭代。
]
