#import "/lib.typ": *

#let testcase(
  page-args: (:), 
  body
) = {
  let page-args = (
    paper: "a7",
    ..page-args
  )
  set page(..page-args)
  body
}

#testcase[
  #let (ctypset, cjk) = ctyp()
  #show: ctypset
  #show: page-grid.with(width: 18, height: 24)

  #grid(columns: (1em,) * 18, rows: 1em, stroke: 1pt, ..array.range(18).map(i => box()))

  #array.range(40).map(i => numbering("一", i + 1)).join()
]

#testcase[
  #let (ctypset, cjk) = ctyp()
  #show: ctypset
  #show: page-grid.with(width: 18, height: 24, note-right: 5)

  #grid(columns: (1em,) * 18, rows: 1em, stroke: 1pt, ..array.range(18).map(i => box()))

  #array.range(40).map(i => numbering("一", i + 1)).join()
]
