/// [skip]
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
    fontset-cjk: "noto",
    font-cjk-map: (
      heading: (cjk: "hei", latin: "sans")
    )
  )
  #show: theme
  #set text(size: 10pt)

  #block(width: 100%)[
    #set align(center)
    #set text(size: 1.5em)
    #(cjk.hei)[Noto 字体集]\
    #(cjk.song)[——案例]
  ]

  = 小节字体：Noto宋体

  正文内容：Noto宋体。
  *粗体：Noto黑体。*
  _强调：Noto宋体。_
  由于没有“Noto宋体”，因此默认将 emph 显示为下划线样式（标记模式中使用下划线“`_`”表示 `emph()`，因此使用下划线）。
  其他所有字体如下表所示。

  #table(
    columns: (1fr, 1fr),
    align: (_, y) => if y == 0 { center } else { left },
    table.header[*字体名称*][*字体标识*],
    (cjk.song)[Noto宋体], [`Source Han Serif SC`],
    (cjk.hei)[Noto黑体], [`Source Han Sans SC`],
  )
]
