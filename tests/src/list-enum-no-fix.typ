#import "../../lib.typ": *
#import "../template.typ": testcase
#show: testcase
#let (theme, _) = ctyp(
  fix-list-enum: false,
)
#show: theme

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