#import "../../lib.typ": *
#import "../template.typ": testcase
#show: testcase
#let (theme, _) = ctyp()
#show: theme

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