#import "../lib.typ": *
#set page("a6")
#let (theme, (song, hei, kai, fang)) = ctyp(
  font-cjk-map: (
    heading: (cjk: "song", latin: "serif"),
  )
)
#show: theme

= 标题

- #strong[通过 strong 显示的粗体]
- *#song[通过 song 修改的 strong 粗体]*
