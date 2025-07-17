#import "../lib.typ": *
#set page("a6")

#[
  #let (theme, (song, hei, kai, fang)) = ctyp()
  #show: theme

  - 中文"智能引号"
  - 中文“手动引号”
  - English "smart quotes"
  - *English "smart quotes"*
  - English “manual quotes”
]

#[
  #let (theme, (song, hei, kai, fang)) = ctyp(fix-smartquote: false)
  #show: theme

  - 中文"智能引号"
  - 中文“手动引号”
  - English "smart quotes"
  - *English "smart quotes"*
  - English “manual quotes”
]

