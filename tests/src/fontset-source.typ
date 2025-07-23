#import "../../lib.typ": *
#import "../template.typ": testcase
#show: testcase.with(page-args: (
  paper: "a6"
))

#set text(size: 10pt)

#let (theme, cjk) = ctyp(
  fontset-cjk: "source"
)
#show: theme

#block(width: 100%)[
  #set align(center)
  #set text(size: 1.5em)
  #(cjk.hei)[思源字体集]\
  #(cjk.song)[——案例]
]

= 小节字体：思源宋体

正文内容：思源宋体。
*粗体：思源黑体。*
_强调：思源楷体。_
由于没有“思源楷体”，因此默认将 emph 显示为下划线样式（标记模式中使用下划线“`_`”表示 `emph()`，因此使用下划线）。
其他所有字体如下表所示。

#table(
  columns: (1fr, 1fr),
  align: (_, y) => if y == 0 { center } else { left },
  table.header[*字体名称*][*字体标识*],
  (cjk.song)[思源宋体], [`Source Han Serif SC`],
  (cjk.hei)[思源黑体], [`Source Han Sans SC`],
)