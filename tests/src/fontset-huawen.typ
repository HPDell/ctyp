#import "../../lib.typ": *
#import "../template.typ": testcase
#show: testcase.with(page-args: (
  paper: "a6"
))

#set text(size: 10pt)

#let (theme, cjk) = ctyp(
  fontset-cjk: "huawen"
)
#show: theme

#block(width: 100%)[
  #set align(center)
  #set text(size: 1.5em)
  #(cjk.hei)[华文字体集]\
  #(cjk.song)[——案例]
]

= 小节字体：方正小标宋

正文内容：宋体。*粗体：黑体。*_强调：楷体。_其他所有字体如下表所示。
考虑到华文字体中的黑体为“#(cjk.hei)[细黑]”，并不适合 `strong()` 的语义，特改用“#(cjk.zhongsong)[华文中宋]”。

#table(
  columns: (1fr, 1fr),
  align: (_, y) => if y == 0 { center } else { left },
  table.header[*字体名称*][*字体标识*],
  (cjk.song)[华文宋体], [`STSong`],
  (cjk.hei)[华文细黑], [`STHei`],
  (cjk.kai)[华文楷体], [`STKai`],
  (cjk.fang)[华文仿宋], [`STFang`],
  (cjk.lishu)[华文隶书], [`LiShu`],
  (cjk.zhongsong)[华文中宋], [`STZhongsong`],
  (cjk.caiyun)[华文彩云], [`STCaiyun`],
  (cjk.hupo)[华文琥珀], [`STHupo`],
  (cjk.xingkai)[华文行楷], [`STXingkai`],
  (cjk.xinwei)[华文新魏], [`STXinwei`],
)