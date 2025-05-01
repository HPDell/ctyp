#import "@local/ctyp:0.1.0": *

#set document(title: "CTYP 说明", author: "作者")

#let maketitle() = context {
  block(width: 100%, {
    show: strong
    set text(size: 1.6em)
    set align(center + horizon)
    document.title
  })
  block(width: 100%, {
    show: kai
    set text(size: 1.2em)
    set align(center + horizon)
    document.author.join()
  })
}

#show: ctyp

#maketitle()
