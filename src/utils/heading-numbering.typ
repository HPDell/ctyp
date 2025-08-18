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
          show: par.with(first-line-indent: first-line-indent, hanging-indent: hanging-indent)
          it-number + it.body
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
        if it-number-format == none {
          return none
        }
        if type(it-number-format) == str {
          it-number-format = it-number-format
        } else if type(it-number-format) == dictionary and it-number-format.keys().contains("format") {
          it-number-format = it-number-format.format
        } else {
          panic("heading-numbering must be a string, dictionary or an array of strings/dictionaries")
        }
        numbering(it-number-format, ..nums)
      })
      show heading: it => block({
        let it-numbering = heading-numbering.at(it.level - 1, default: heading-numbering.last())
        if it-numbering == none {
          it.body
        } else if type(it-numbering) == dictionary {
          let it-sep = _convert-heading-numbering-sep(it-numbering.sep)
          let it-number = (it.numbering)(..counter(heading).at(it.location())) + it-sep
          let first-line-indent = it-numbering.at("first-line-indent", default: 0em)
          let hanging-indent = it-numbering.at("hanging-indent", default: measure(it-number).width)
          show: par.with(first-line-indent: first-line-indent, hanging-indent: hanging-indent)
          it-number + it.body
        } else {
          it
        }
      })
      body
    }
  } else {
    panic("heading-numbering must be a string, dictionary or an array of strings/dictionaries")
  }
}


