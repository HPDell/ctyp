#import "@preview/cjk-unbreak:0.1.0": remove-cjk-break-space
#import "fonts/fandol.typ": fandol-fontset
#import "enumitem.typ": enumitem
#import "utils/page-grid.typ": page-grid

#let _default-font-latin = (
  serif: "Libertinus Serif",
  sans: "Libertinus Sans",
  mono: "Libertinus Mono",
)

#let ctyp(
  fontset-cjk: auto,
  font-cjk-map: (:),
  font-latin: (:),
  fix-list-enum: true,
  fix-list-args: (:),
  fix-enum-args: (:),
) = {
  // Merge font-cjk-map with default options.
  let fontset-cjk = if fontset-cjk == auto {
    fandol-fontset
  } else if type(fontset-cjk) == dictionary {
    fontset-cjk
  } else {
    panic("fontset-cjk must be a dict, auto or none")
  }
  let font-cjk = fontset-cjk.family
  let font-cjk-map = (:..fontset-cjk.map, ..font-cjk-map)
  let font-latin = (:.._default-font-latin, ..font-latin)

  /// This function wraps the given font with a Latin cover.
  let _font-latin-cover(element) = {// Extract CJK font name
    let font-identifier = font-cjk-map.at(element)
    let (shape, ..variant) = font-identifier.cjk.split(":")
    variant = if variant.len() > 0 { variant.first() } else { none }
    let font-family = font-cjk.at(shape)
    let font-cjk-name = if variant == none or variant in font-family.variants {
      font-family.name
    } else {
      font-cjk.values().first().name
    }

    let latin = font-latin.at(font-identifier.latin, default: "Libertinus Serif")

    // Cover CJK font with Latin font.
    let latin = if latin == auto {
      if font-latin == auto { 
        "Libertinus Serif"
      } else if type(font-latin) == str {
        font-latin
      } else {
        panic("font-latin must be a string or auto")
      }
    } else if latin == none {
      font-cjk-name
    } else if type(latin) == str {
      latin
    } else {
      panic("latin must be a string, auto or none")
    }
    (
      (
        name: latin,
        covers: "latin-in-cjk"
      ),
      font-cjk-name
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
    show raw: set text(
      font: _font-latin-cover("raw"),
      weight: "regular"
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
  if fix-list-enum  {
    theme = (body) => {
      show: theme
      show list: body => {
        set par(spacing: .6em)
        enumitem(..fix-list-args, body.children)
      }
      show enum: body => {
        set par(spacing: .6em)
        enumitem(..fix-enum-args, body.children)
      }
      body
    }
  }
  let font-utils = fontset-cjk.family.pairs().map(((k, v)) => {
    (k, (body) => text(font: v.name, weight: "regular", body))
  }).to-dict()
  (
    theme,
    font-utils
  )
}
