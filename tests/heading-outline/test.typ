#import "/lib.typ": *

#let testcase(
  page-args: (:), 
  body
) = {
  let page-args = (
    paper: "a6",
    margin: 1pt,
    ..page-args
  )
  set page(..page-args)
  body
}

#testcase[
  #let (ctypset, fonts) = ctyp(
    heading-numbering: ((
      format: "一",
      sep: 1em
    ), "1.1")
  )
  #show: ctypset

  #outline()

  = 一级标题

  == 二级标题

  测试内容
]
