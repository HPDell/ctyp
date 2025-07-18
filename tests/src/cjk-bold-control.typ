#import "../../lib.typ": *
#import "../template.typ": testcase
#show: testcase

#[
  #let (theme, (song, hei, kai, fang)) = ctyp()
  #show: theme

  = 标题

  - #strong[通过 strong 显示的粗体]
  - #hei(weight: "bold")[通过 song(weight: "bold") 显示的宋体]
]

#[
  #let (theme, (song, hei, kai, fang)) = ctyp(
    font-cjk-map: (
      strong: (cjk: "hei:bold", latin: "serif"),
      heading: (cjk: "hei:regular", latin: "serif"),
    )
  )
  #show: theme

  = 标题

  - #strong[通过 strong 显示的粗体]
  - #song(weight: "bold")[通过 song(weight: "bold") 显示的宋体]
]
