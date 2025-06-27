#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "fonts/fandol.typ": fandol-fontset
#import "enumitem.typ": enumitem

#let _default-font-cjk-map = (
  text: "serif",
  strong: "sans",
  emph: "mono",
  heading: "serif",
)

#let ctyp(
  font-cjk: fandol-fontset,
  font-cjk-map: _default-font-cjk-map,
  font-latin: auto,
  fix-list-enum: true
) = {
  // Merge font-cjk-map with default options.
  let font-cjk-map = (:.._default-font-cjk-map, ..font-cjk-map)

  /// This function wraps the given font with a Latin cover.
  let _font-latin-cover(element) = {
    
    // Extract CJK font name
    let font-identifier = font-cjk-map.at(element)
    let (shape, ..variant) = font-identifier.split(":")
    let font-family = font-cjk.at(font-identifier)
    let font-name = if variant.len() > 0 {
      font-family.last().at(variant, default: font-family.first())
    } else {
      font-family.first()
    }

    // Cover CJK font with Latin font.
    let font-latin = if font-latin == auto {
      "Linux Libertine"
    } else if font-latin == none {
      font-name
    } else if type(font-latin) == str {
      font-latin
    } else {
      panic("latin must be a string, auto or none")
    }
    (
      (
        name: font-latin,
        covers: "latin-in-cjk"
      ),
      font-name
    )
  }

  let theme = (body) => {
    set text(lang: "zh")

    /// [Font Settings] Begin
    /// This region apply fonts to default text, emph, and strong.
    set text(font: _font-latin-cover("text"))
    show emph: set text(
      font: _font-latin-cover("emph"),
      style: "italic"
    )
    show strong: set text(
      font: _font-latin-cover("strong"),
      weight: "bold"
    )
    show heading: set text(
      font: _font-latin-cover("heading"),
      weight: "bold"
    )
    /// [Font Settings] End
    
    /// [Paragraph Settings] Begin
    /// This region apply paragraph settings to specific elements.
    set par(first-line-indent: (amount: 2em, all: true), justify: true)
    
    show heading: set block(above: 1em, below: 1em)
    set heading(numbering: "1.1.")
    show quote.where(block: false): set par(
      first-line-indent: (amount: 1em, all: true)
    )
    show quote.where(block: false).and(quote.where(quotes: false)): set par(
      first-line-indent: (amount: 2em, all: true)
    )
    /// [Paragraph Settings] End
    
    /// [Other Settings] Begin
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
    /// [Other Settings] End
    
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
  let font-utils = font-cjk.family.pairs().map(((k, v)) => {
    (k, (body) => text(font: v, weight: "regular", body))
  }).to-dict()
  (
    theme: theme,
    ..font-utils
  )
}
