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

#let test-content = [
  == 临江仙

  === 正文

  滚滚长江东逝水，浪花淘尽英雄。
  是非成败转头空。青山依旧在，几度夕阳红。

  白发渔樵江渚上，惯看秋月春风。
  一壶浊酒喜相逢。古今多少事，都付笑谈中。

  === 作者

  杨慎（1488年12月8日--1559年8月8日），字用修，初号月溪、升庵，又号逸史氏、博南山人、洞天真逸、滇南戍史、金马碧鸡老兵等。
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp()
  #show: theme

  = 无标题编号

  #test-content
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp(
    heading-numbering: "1.1",
  )
  #show: theme

  = 字符串标题编号

  #test-content
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp(
    heading-numbering: (
      format: "1.1",
      sep: 1em
    )
  )
  #show: theme

  = 字典标题编号并测试悬挂缩进

  #test-content
]

#testcase[
  #let (theme, (song, hei, kai, fang)) = ctyp(
    heading-numbering: ((
      format: "一、",
      sep: 0em
    ), "1.1", "1.1.1")
  )
  #show: theme

  = 数组标题编号并测试悬挂缩进

  #test-content
]
