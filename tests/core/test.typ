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
  #let (theme, (song, hei, kai, fang)) = ctyp()
  #show: theme

  = 字体函数调用

  滚滚长江东逝水，#song[浪花淘尽英雄]。
  是非成败转头空。#kai[青山依旧在，几度夕阳红]。

  白发渔樵江渚上，#hei[惯看秋月春风]。
  一壶浊酒喜相逢。#fang[古今多少事，都付笑谈中]。
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp(
    font-cjk-map: (
      emph: (cjk: "song:bold", latin: "serif"),
      strong: (cjk: "hei:bold", latin: "serif"),
      heading: (cjk: "hei", latin: "serif"),
    ),
  )
  #show: theme

  = 字体映射设置变体

  #song(weight: "bold")[滚滚长江东逝水]，_浪花淘尽英雄_。
  是非成败转头空。青山依旧在，几度夕阳红。

  #song(weight: "regular")[白发渔樵江渚上]，*惯看秋月春风*。
  一壶浊酒喜相逢。古今多少事，都付笑谈中。
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp()
  #show: theme

  = 智能引号修复（开启）

  - 中文"智能引号"
  - 中文“手动引号”
  - English "smart quotes"
  - *English "smart quotes"*
  - English “manual quotes”
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp(fix-smartquote: false)
  #show: theme
  
  = 智能引号修复（关闭）

  - 中文"智能引号"
  - 中文“手动引号”
  - English "smart quotes"
  - *English "smart quotes"*
  - English “manual quotes”
]