#import "./fonts/index.typ": *
#import "./utils/enumitem.typ": enumitem
#import "./utils/page-grid.typ": page-grid

#let _default-cjk-regex = "[\p{Han}\u3002\uff1f\uff01\uff0c\u3001\uff1b\uff1a\u201c\u201d\u2018\u2019\uff08\uff09\u300a\u300b\u3008\u3009\u3010\u3011\u300e\u300f\u300c\u300d\uff43\uff44\u3014\u3015\u2026\u2014\uff5e\uff4f\uffe5]"

#let _default-font-latin = (
  serif: "Libertinus Serif",
  mono: "DejaVu Sans Mono",
)

#let _default-weight-map = (
  "thin": 100,
  "extralight": 300,
  "light": 300,
  "regular": 400,
  "medium": 500,
  "semibold": 600,
  "bold": 700,
  "extrabold": 800,
  "heavy": 900,
)

#let _default-font-styles = ("normal", "italic", "oblique")

#let _default-font-functions = (
  "highlight": highlight,
  "underline": underline.with(offset: 2pt),
  "strike": strike,
)

/// This function sets up a basic typesetting environment for CJK documents.
/// It applies CJK fonts, sets up paragraph styles, and provides utility functions for CJK text styling.
/// -> array
#let ctyp(
  /// Specify fontset.
  /// If `auto`, it will use the default Fandol fontset.
  /// If a string, it must be one of the packed fontsets defined in packed fontsets.
  /// If a dictionary, it uses the following structure:
  /// - `family`: a dictionary mapping font shapes to font families. Including the following fields:
  ///   - `[shape]`: a string representing the font shape (e.g., "song", "hei").
  ///     Can be repeated for multiple shapes.
  ///     For CJK fonts, shapes can be various, including but not limited to "song", "hei", "kai", "fang".
  ///     Each shape must have the following fields:
  ///     - `name`: the name of the font family. It should be a valid font name that can be used in Typst.
  ///     - `variants`: an array of font variants (e.g., ["bold", "italic"]).
  /// - `map`: a dictionary mapping elements to font identifiers.
  ///   - `[element]`: a string representing the element (e.g., "text", "strong"). Can be repeated for multiple elements.
  ///     For now, only the following elements are supported: `text`, `emph`, `strong`, `raw`, `heading`.
  ///     Each element must have the following fields:
  ///     - `cjk`: the CJK font identifier, which is a string in the format "shape:variant".
  ///     - `latin`: the Latin font identifier, which is a string or one of the predefined values ("serif", "sans", "mono").
  /// -> auto | str | dictionary
  fontset-cjk: auto,
  /// Specify latin fonts. Must be a dictionary mapping latin font shapes to font names.
  /// It follows the structure:
  /// - `serif`: the serif font name.
  /// - `sans`: the sans-serif font name.
  /// - `mono`: the monospace font name.
  /// -> dictionary
  font-latin: (:),
  /// Modify the CJK font mapping for specific elements.
  /// It follows the structure:
  /// - `[element]`: a string representing the element (e.g., "text", "strong"). Can be repeated for multiple elements.
  ///     For now, only the following elements are supported: `text`, `emph`, `strong`, `raw`, `heading`.
  ///     Each element must have the following fields:
  ///   - `cjk`: the CJK font identifier, which is a string in the format "shape:variant".
  ///   - `latin`: the Latin font identifier, which is a string or one of the predefined values ("serif", "sans", "mono").
  /// -> dictionary
  font-cjk-map: (:),
  /// Whether to fix the styles for lists and enumerations.
  /// If true, it will apply the styles defined in `fix-list-args` and `fix-enum-args`.
  /// -> bool
  fix-list-enum: true,
  /// Additional arguments for list styles.
  /// -> dictionary
  fix-list-args: (:),
  /// Additional arguments for enumeration styles.
  /// -> dictionary
  fix-enum-args: (:),
  /// Whether to fix smart quotes.
  /// If true, it will automatically convert quotes to smart quotes.
  /// -> bool
  fix-smartquote: true,
  /// Reset the strong delta to 0.
  /// This is used to reset the strong delta for the strong element.
  /// -> int
  reset-strong-delta: 0,
  /// Whether to remove CJK break spaces.
  /// If true, it will remove break spaces between CJK characters.
  /// This is used to prevent CJK characters from being broken by spaces.
  /// -> bool
  remove-cjk-break-space: true
) = {
  // Merge font-cjk-map with default options.
  let fontset-cjk = if fontset-cjk == auto {
    fandol-fontset
  } else if type(fontset-cjk) == dictionary {
    fontset-cjk
  } else if type(fontset-cjk) == str and fontset-cjk in packed-fontset.keys() {
    packed-fontset.at(fontset-cjk)
  } else {
    panic("fontset-cjk must be a dict, auto or one of the packed fontsets: " + packed-fontset.keys().join(", "))
  }
  let font-cjk = fontset-cjk.family
  let font-cjk-map = (:..fontset-cjk.map, ..font-cjk-map)
  let font-latin = (:.._default-font-latin, ..font-latin)

  let _apply-font-to-cjk(..args, body) = {
    let text-args = args.named()
    let cjk-function = text
    if text-args.style in _default-font-functions.keys() {
      cjk-function = _default-font-functions.at(text-args.style)
      text-args.style = "normal"
    }
    show regex(_default-cjk-regex): set text(..text-args)
    show regex(_default-cjk-regex): cjk-function
    show: if fix-smartquote { (body) => {
      show smartquote: set text(font: args.named().font.at(0).name)
      body
    }} else { (body) => body }
    body
  }

  /// This function wraps the given font with a Latin cover.
  let _font-latin-cover(element) = {// Extract CJK font name
    let font-identifier = font-cjk-map.at(element)
    let (shape, ..variants) = font-identifier.cjk.split(":")
    // let variant = if variants.len() > 0 { variants.first() } else { none }
    let font-family = font-cjk.at(shape)
    let font-weight = "regular"
    let font-style = "normal"
    for variant in variants {
      if variant in _default-weight-map.keys() {
        font-weight = variant
      } else if variant in (.._default-font-styles, .._default-font-functions.keys()) {
        font-style = variant
      }
    }
    let font-cjk-name = if font-weight == none or font-weight == "regular" or font-weight in font-family.variants {
      font-family.name
    } else if variant in _default-font-styles {
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
      font: ((
        name: latin,
        covers: "latin-in-cjk"
      ), font-cjk-name),
      weight: if font-weight == none { 400 } else { _default-weight-map.at(font-weight, default: 400) },
      style: font-style
    )
    
  }

  let theme = (body) => {
    set text(lang: "zh")

    /// [Font Settings] Begin
    /// This region apply fonts to default text, emph, and strong.
    let font-select = ("text", "emph", "strong", "raw", "heading").map(k => (k, _font-latin-cover(k))).to-dict()
    set text(font: font-select.text.font)
    show: if fix-smartquote { (body) => {
      show smartquote: set text(font: font-select.text.font.at(0).name)
      body
    }} else { (body) => body }
    set strong(delta: if type(reset-strong-delta) == int {
      reset-strong-delta
    } else { 0 })
    show emph: set text(font: font-select.emph.font)
    show emph: _apply-font-to-cjk.with(..font-select.emph)
    show strong: set text(font: font-select.strong.font, weight: "bold")
    show strong: _apply-font-to-cjk.with(..font-select.strong)
    show raw: set text(font: font-select.raw.font)
    show raw: _apply-font-to-cjk.with(..font-select.raw)
    show heading: set text(font: font-select.heading.font)
    show heading: _apply-font-to-cjk.with(..font-select.heading)
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
  if remove-cjk-break-space {
    theme = (body) => {
      show: theme
      show regex(_default-cjk-regex + " " + _default-cjk-regex): it => {
        let (a, _, b) = it.text.clusters()
        a + b
      }
      body
    }
  }
  let font-utils = fontset-cjk.family.pairs().map(((k, v)) => { (
    k, 
    (body, weight: "regular", latin: "serif") => {
      let latin-font-name = if type(latin) == str {
        if latin in font-latin.keys() {
          font-latin.at(latin)
        } else {
          latin
        }
      } else {
        panic("latin must be a string representing a font name or a font shape")
      }
      set text(font: (
        (name: latin-font-name, covers: "latin-in-cjk"),
        v.name
      ), weight: weight)
      body
    }
  ) }).to-dict()
  (
    theme,
    font-utils
  )
}
