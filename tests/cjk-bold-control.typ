#import "../lib.typ": *
#set page("a6")
#let (theme, (song, hei, kai, fang)) = ctyp()
#show: theme

= 标题

- #strong[通过 strong 显示的粗体]
- #song(weight: "bold")[通过 song(weight: "bold") 显示的宋体]

#let (theme, (song, hei, kai, fang)) = ctyp(
  font-cjk-map: (
    heading: (cjk: "hei", latin: "serif"),
  )
)
#show: theme

= 标题
