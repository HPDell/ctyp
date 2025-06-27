#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "enumitem.typ": enumitem

#let fontset-fandol = (
  song: "FandolSong",
  hei: "FandolHei",
  kai: "FandolKai",
  fang: "FandolFang R"
)

#let _font-latin-cover(font, latin: none) = {
  if type(latin) == str {
    (
      (
        name: latin,
        covers: "latin-in-cjk"
      ),
      font
    )
  } else if latin == none {
    font
  } else {
    panic("latin must be a string or none")
  }
}

#let ctyp(
  font-cjk: (:),
  font-latin: "Libertinus Serif",
  fontset: fontset-fandol,
  fix-list-enum: true
) = {
  let theme = (body) => {
    set text(lang: "zh")

    set text(font: _font-latin-cover(fontset.at(font-cjk.at("main", default: "song")), latin: font-latin))
    
    show emph: set text(font: _font-latin-cover(fontset.at(font-cjk.at("emph", default: "kai")), latin: font-latin))

    show strong: set text(
      font: _font-latin-cover(fontset.at(font-cjk.at("strong", default: "song")), latin: font-latin),
      weight: if font-cjk.at("strong", default: "song") == "hei" { 
        "thin" 
      } else { "bold" }
    )
    
    set par(first-line-indent: (amount: 2em, all: true), justify: true)
    
    show heading: set block(above: 1em, below: 1em)
    set heading(numbering: "1.1.")
    
    show quote.where(block: false): set par(
      first-line-indent: (amount: 1em, all: true)
    )
    
    show quote.where(block: false).and(quote.where(quotes: false)): set par(
      first-line-indent: (amount: 2em, all: true)
    )
    
    show quote.where(block: true): body => {
      show: block
      show: pad.with(x: 2em)
      let quotes = if body.quotes == auto { not body.block } else { body.quotes }
      if quotes == true {
        quote(block: false, body.body)
      } else {
        par(body.body)
      }
      if body.attribution != none {
        box(width: 100%, {
          set align(right)
          "——" + body.attribution
        })
      }
    }
    
    show: remove-cjk-break-space

    body
  }
  if (fix-list-enum) {
    theme = (body) => {
      show: theme
      show list: body => {
        show: block.with(above: 1em, below: 1em, inset: (left: 0em))
        set par(spacing: .6em)
        enumitem(body.children)
      }
      show enum: body => {
        show: block.with(above: 1em, below: 1em, inset: (left: 0em))
        set par(spacing: .6em)
        enumitem(body.children)
      }
      body
    }
  }
  let song = (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.song, latin: font-latin), weight: weight, body)
  let hei = (body, weight: "thin") => text(font: _font-latin-cover(fontset-fandol.hei, latin: font-latin), weight: weight, body)
  let fang = (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.fang, latin: font-latin), weight: weight, body)
  let kai = (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.kai, latin: font-latin), weight: weight, body)
  (
    theme: theme,
    song: song,
    hei: hei,
    fang: fang,
    kai: kai
  )
}
