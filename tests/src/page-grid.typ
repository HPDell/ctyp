#import "../lib.typ": ctyp, page-grid
#let (ctypset, cjk) = ctyp()
#show: page-grid
#show: ctypset

#grid(columns: (1em,) * 42, rows: 1em, stroke: 1pt, ..array.range(42).map(i => box()))

#array.range(23).map(i => numbering("一", i + 1)).join()
