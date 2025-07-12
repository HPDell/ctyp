#import "../lib.typ": *
#import "../fonts/fangzheng.typ": fangzheng-fontset
#set page("a6")

#set text(size: 10pt)

#let (theme, cjk) = ctyp(
  fontset-cjk: fangzheng-fontset
)
#show: theme

#block(width: 100%)[
  #set align(center)
  #set text(size: 1.5em)
  #(cjk.dahei)[方正]#(cjk.hei)[字体集]\
  #(cjk.dabiaosong)[——案例]
]

= 小节字体：方正小标宋

正文内容：方正新书宋。
*粗体：方正黑体。*
_强调：方正楷体。_
其他所有字体如下表所示。

#table(
  columns: (1fr, 1fr),
  align: (_, y) => if y == 0 { center } else { left },
  table.header[*字体名称*][*字体标识*],
  (cjk.song)[方正新书宋简体], [`FZNewShuSong-Z10S`],
  (cjk.hei)[方正黑体简体], [`FZHei-B01S`],
  (cjk.kai)[方正楷体简体], [`FZKai-Z03S`],
  (cjk.fang)[方正仿宋简体], [`FZFangSong-Z02S`],
  (cjk.songhei)[方正宋黑简体], [`FZSongHei-B07S`],
  (cjk.cusong)[方正粗宋简体], [`FZCuSong-B09S`],
  (cjk.xiaobiaosong)[方正小标宋简体], [`FZXiaoBiaoSong-B05S`],
  (cjk.dabiaosong)[方正大标宋简体], [`FZDaBiaoSong-B06S`],
  (cjk.dahei)[方正大黑简体], [`FZDaHei-B02S`],
)