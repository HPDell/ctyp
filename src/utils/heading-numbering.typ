#let _convert-heading-numbering-sep(sep) = {
  if type(sep) == none {
    box(width: 0pt)
  } else if type(sep) == length {
    box(width: sep)
  } else if type(sep) == str or type(sep) == content {
    sep
  } else {
    sym.wj
  }
}

#let _heading-container(heading-numbering, body) = context {
  if type(heading-numbering) == dictionary and heading-numbering.at("runin", default: false) {
    box(body)
  } else {
    body
  }
}

#let _config-heading-numbering(heading-numbering) = {
  if type(heading-numbering) == str {
    (body) => {
      set heading(numbering: heading-numbering)
      body
    }
  } else if type(heading-numbering) == dictionary and heading-numbering.keys().contains("format") {
    let first-line-indent = heading-numbering.at("first-line-indent", default: 0em)
    (body) => {
      set heading(numbering: (..nums) => {
        let counts = nums.pos();
        numbering(heading-numbering.format, ..counts)
      })
      if heading-numbering.keys().contains("sep") and heading-numbering.sep != auto {
        show heading: it => {
          let it-sep = _convert-heading-numbering-sep(heading-numbering.sep)
          let it-number = (it.numbering)(..counter(heading).at(it.location())) + it-sep
          let hanging-indent = heading-numbering.at("hanging-indent", default: measure(it-number).width)
          set align(heading-numbering.at("align", default: left))
          show: par.with(first-line-indent: first-line-indent, hanging-indent: hanging-indent)
          box(width: hanging-indent, it-number) + it.body
        }
        body
      } else {
        body
      }
    }
  } else if type(heading-numbering) == array {
    (body) => {
      set heading(numbering: (..nums) => {
        let it-level = nums.pos().len()
        let it-number-format = heading-numbering.at(it-level - 1, default: heading-numbering.last())
        if type(it-number-format) == str {
          it-number-format = it-number-format
        } else if type(it-number-format) == dictionary and it-number-format.keys().contains("format") {
          it-number-format = it-number-format.format
        } else {
          panic("heading-numbering must be a string, dictionary or an array of strings/dictionaries")
        }
        if it-number-format == none {
          none
        } else {
          numbering(it-number-format, ..nums)
        }
      })
      let heading-settings = heading-numbering.enumerate().map(((it-level, it-numbering)) => {
        (body) => {
          show heading.where(level: it-level + 1): it => {
            let it-numbering = heading-numbering.at(it.level - 1, default: heading-numbering.last())
            if it-numbering == none {
              it.body
            } else if type(it-numbering) == dictionary {
              let it-sep = _convert-heading-numbering-sep(it-numbering.at("sep", default: 4pt))
              let it-number = (it.numbering)(..counter(heading).at(it.location()))
              let first-line-indent = it-numbering.at("first-line-indent", default: 0em)
              let hanging-indent = it-numbering.at("hanging-indent", default: measure(it-number + it-sep).width)
              set align(it-numbering.at("align", default: left))
              set par(first-line-indent: first-line-indent, hanging-indent: hanging-indent)
              if it-number == none {
                it.body
              } else {
                box(width: hanging-indent, it-number + it-sep) + it.body
              }
            } else {
              it
            }
          }
          body
        }
      }).reduce((lhs, rhs) => (body) => { lhs(rhs(body)) })
      show: heading-settings
      body
    }
  } else {
    panic("heading-numbering must be a string, dictionary or an array of strings/dictionaries")
  }
}


