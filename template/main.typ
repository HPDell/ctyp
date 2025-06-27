#import "@local/ctyp:0.1.0": *

#set document(title: "标题", author: "作者")

#let (theme, ..fonts) = ctyp()

#let maketitle() = context {
  block(width: 100%, {
    show: strong
    set text(size: 1.6em)
    set align(center + horizon)
    document.title
  })
  block(width: 100%, {
    show: fonts.kai
    set text(size: 1.2em)
    set align(center + horizon)
    document.author.join()
  })
}

#show: theme

#maketitle()
