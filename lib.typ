#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "@preview/kouhu:0.2.0": kouhu

#let fontset-fandol = (
  song: "FandolSong",
  hei: "FandolHei",
  kai: "FandolKai",
  fang: "FandolFang R"
)

#let mod(x, y) = {
  if x < y {
    x
  } else {
    int(calc.round(calc.fract(x / y) * y))
  }
}

#let enumitem(body) = {
  let item-template(label-skip: 1em, hanging: 1em, item) = block(
    inset: (left: 1em),
    above: .6em,
    {
      set par(first-line-indent: (amount: 0em, all: true), hanging-indent: 0em)
      box(width: 0em, move(item.marker, dx: -1em))
      item.body
    }
  )
  let cur = (0,)
  let queue = ((
    marker: none,
    body: []
  ),)
  let cur-max = (body.children.len(),)
  let depth = 0
  let doc = []
  while cur.at(0) < cur-max.at(0) {
    if cur.at(depth) >= cur-max.at(depth) {
      let qe = queue.pop()
      queue.last().body += item-template(qe)
      let _ = cur.pop()
      let _ = cur-max.pop()
      depth -= 1
      cur.last() += 1
      continue
    }
    let c = 0
    let elem = body
    while c <= depth {
      elem = if elem.func() == list {
        elem.children.at(cur.at(c))
      } else if elem.func() == list.item {
        elem.body.children.at(cur.at(c))
      } else {
        elem
      }
      c += 1
    }
    if elem.func() == list.item {
      let marker = box(width: 1em, body.marker.at(mod(depth, body.marker.len())))
      if "children" in elem.body.fields() {
        queue.push((
          marker: marker,
          body: []
        ))
        depth += 1
        cur.push(0)
        cur-max.push(elem.body.children.len())
      } else {
        queue.push((
          marker: marker,
          body: elem.body
        ))
        cur.at(depth) += 1
        let qe = queue.pop()
        queue.last().body += item-template(qe)
      }
    } else {
      queue.last().body += elem
      cur.at(depth) += 1
    }
  }
  queue.pop().body
}

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
  fontset: fontset-fandol
) = {
  (
    theme: (body) => {
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
      

      show list: body => context {
        show: block.with(above: 1em, below: 1em, inset: (left: 1em))
        set par(spacing: .6em)
        enumitem(body)
      }
      
      show: remove-cjk-break-space

      body
    },
    song: (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.song, latin: font-latin), weight: weight, body),
    hei: (body, weight: "thin") => text(font: _font-latin-cover(fontset-fandol.hei, latin: font-latin), weight: weight, body),
    fang: (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.fang, latin: font-latin), weight: weight, body),
    kai: (body, weight: "regular") => text(font: _font-latin-cover(fontset-fandol.kai, latin: font-latin), weight: weight, body),
  )
}
