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
  #let (theme, cjk) = ctyp(
    fontset-cjk: "windows"
  )
  #show: theme

  #block(width: 100%)[
    #set align(center)
    #set text(size: 1.5em)
    #(cjk.hei)[Windows字体集]\
    #(cjk.song)[——案例]
  ]

  = 小节字体：方正小标宋

  正文内容：宋体。*粗体：黑体。*_强调：楷体。_其他所有字体如下表所示。

  #table(
    columns: (1fr, 1fr),
    align: (_, y) => if y == 0 { center } else { left },
    table.header[*字体名称*][*字体标识*],
    (cjk.song)[宋体], [`SimSun`],
    (cjk.hei)[黑体], [`SimHei`],
    (cjk.kai)[楷体], [`SimKai`],
    (cjk.fang)[仿宋], [`SimFang`],
    (cjk.lishu)[隶书], [`LiShu`],
    (cjk.youyuan)[幼圆], [`YouYuan`],
  )
]
