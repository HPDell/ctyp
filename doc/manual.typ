#import "@local/ctyp:0.1.0": ctyp, fandol-fontset, page-grid
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.8": *
#codly(languages: codly-languages)
#import "@preview/theorion:0.3.3": cosmos
#import cosmos.default: *

#show: page-grid
#let (ctypset, (song, hei, kai, fang)) = ctyp(
  fix-list-args: (inset: (left: 1em)),
)
#show: ctypset
#show: codly-init

#block(width: 100%, below: 2em)[
  #set align(center)
  #text(size: 1.5em, strong[CTyp 使用手册])
  
  #emph[版本: 0.1.0]
]

CTyp 是一个用于提供 Typst 中文排版支持的包。
该包集成了一些常用的中文排版设置，用于提供快速的中文排版体验。

#warning-box[
  由于 Typst 的中文排版支持仍不完善，该包只能提供非语言级的排版支持。
  并不保证能够实现所有中文排版需求。
]

= 快速开始

通过以下代码快速使用 CTyp 包的设置：

```typ
#import "@local/ctyp:0.1.0": ctyp
#let (ctypset, cjk) = ctyp()
#show: ctypset
```

#note-box[
  变量名 `ctypset` 和 `cjk` 可以自行设置，无需使用文档中的名字。
]

= 字体设置

== 字体集合

字体集合是一系列字体名称的集合，包括其变体。
字体集合通常包含以下元素：宋体、黑体、楷体、仿宋。
字体集合至少包含一个元素，但无需包含所有元素。
目前 CTyp 包提供 Fandol 字体集合。

字体集合应当是如下结构的字典，

```typ
#let fandol-fontset = (
  family: (
    song: (name: "FandolSong", variants: ("bold",)),
    hei: (name: "FandolHei", variants: ("bold",)),
    ... // 其他字体
  ),
  map: (
    text: (cjk: "song", latin: "serif"),
    strong: (cjk: "hei", latin: "serif"),
    .. // 其他元素
  )
)
```

#note-box(title: [格式说明])[
- `family`： 一个字典，列出了所用的各种字形，如 `song`, `hei`, `kai`, `fang` 等。
  - `[key]`：字形的名称，是一个字典。
    - `name`：所用的字体的名称。
    - `variants`：这个字体包含的所有变体。
- `map`：一个字典，列出各种元素所使用的 CJK 字体和西文字体对应关系。
  - `[element]`：元素的名称
    - `cjk`：CJK 字体映射，格式为 `"family":"variant"`。其中 `family` 是 `family` 中的键，`variant` 是 `variants` 中的值。若指定了不再存在的变体，认为该字体不存在，回归使用 `family` 字典中的第一个字体。
    - `latin`：西文字体映射，可选项是 `"serif"`, `"sans"`, `"mono"` 或者字体名称。
      - `serif`：使用衬线字体。
      - `sans`：使用无衬线字体。
      - `mono`：使用等宽字体。
]


== 修改字体映射

在字体集合提供默认字体映射的基础上，可以为特定元素修改其所使用的字体。
设置方法是通过 `ctyp()` 函数中的参数 `font-cjk-map()` 来修改，格式参考字体集合字典中的 `map` 字段。
需要保证修改后的字体映射仍然能够找到对应的字体。

除了能够设置元素的中文字体，还可以设置对应的西文字体，使得中西文字体能够匹配。

#tip-box(title: [修改字体映射])[
  将 `strong` 元素从使用#strong[黑体]改为使用宋体

  ```typ
  #let (ctypset, cjk) = ctyp(
    font-cjk-map: (
      strong: (cjk: "song:bold", latin: "sans"),
    ),
    font-latin: (
      sans: "Arial"
    )
  )
  #show: _ctypset
  #strong[加粗的宋体内容]
  ```

  #let (_ctypset, _cjk) = ctyp(
    font-cjk-map: (
      strong: (cjk: "song:bold", latin: "sans"),
    ),
    font-latin: (
      sans: "Arial"
    )
  )
  #show: _ctypset
  *加粗的宋体内容，西文使用 Sans 字体*
]

从上面的例子可以看到，*默认情况下 `strong` 元素使用黑体，而不加粗*。
也就是和 `#hei(weight: "regular")[]` 的#hei(weight: "regular")[效果]相同。
如果使用#hei(weight: "bold")[加粗的黑体]，则可能过粗。
这通常也是 LaTeX 中的默认行为。
如果偏好 Microsoft Word 的行为，即使用黑体的情况下加粗，那么可以在 `font-cjk-map` 中将对应元素的 `cjk` 字段增加一个 `:bold` 后缀。

#important-box(title: [注意])[
  为了实现这一效果，`strong` 元素的 `delta` 被设置为 `0`，并全局生效。如果这导致了异常的行为，可以在 `ctyp()` 函数中设置 `reset-strong-delta` 参数为 `300`，则恢复默认行为。
  该值是 Typst 文档中标注的默认值。如果希望使用其他值，可以自行设置。
]

== 使用 CJK 字体

函数 `ctyp()` 的返回值中的第二个元素 `cjk` 是一个字典。字典的键都来自于字体集合中 `family` 字段的键，也就是字形的名称；值是一个函数，直接使用可以修改内容的字体。
这些函数提供一个参数 `weight` 用于设置字体粗细。

#tip-box(title: [直接使用 CJK 字体])[
```typ
#let (ctypset, cjk) = ctyp()
#let (song, hei, kai, fang) = cjk
- #song[这是宋体内容]
- #hei(weight: "bold")[这是黑体加粗内容]
- #kai[这是楷体内容]
- #fang[这是仿宋内容]
```

#let (ctypset_, cjk_) = ctyp()
#let (song, hei, kai, fang) = cjk_
- #song[这是宋体内容]
- #hei(weight: "bold")[这是黑体加粗内容]
- #kai[这是楷体内容]
- #fang[这是仿宋内容]
]

这些函数中的西文字体默认使用 `ctyp()` 函数参数 `font-latin` 中的 `serif` 字体。
若要修改西文字体，可以通过这些修改这些函数中的 `latin` 参数来实现，该参数接受 `font-latin` 中的键，或具体的字体名称。

#tip-box(title: [使用CJK字体并设置西文字体])[
  ```typ
  #fang(latin: "mono")[使用仿宋体和 monospace 西文字体。]
  ```
  
  #fang(latin: "mono")[使用仿宋体和 monospace 西文字体。]
]

== 智能引号（Smartquote）

当中文与英文混杂时，如果通过 ```typ set text(lang: "zh")``` 设置了，Typst 在英文中也会使用中文的智能引号。
为了修复这一问题，该包参考了#link("https://typst-doc-cn.github.io/guide/FAQ/smartquote-font.html")[“Typst 中文社区”]中提供的解决方案，将智能引号的字体设置为 Latin 字体。
考虑到中文书写时，往往不会使用智能引号，而是依赖输入法进行输入；而使用英文时，却往往需要智能引号，尤其是在纯文本编辑器中。
因此，该包默认开启了智能引号的字体设置。

#warning-box[
  该功能启用时，无论是中文还是英文，智能引号都会使用西文字体。反之，手动引号（使用 `sym.quote.l` 和 `sym.quote.r` 或与之相应的字符）都会使用中文字体。也就是说：
  - 中文应当使用“手动引号”，使用"智能引号"则会使用西文字体。
  - Users should use "smartquote" in Latin text; otherwise, “manual quotes” will result in CJK characters.
]

如果不喜欢该功能，可以将 `ctyp()` 函数的参数 `fix-smartquote` 设置为 `false`，则不修复智能引号字体。

= 列表

不论是编号列表还是符号列表，在使用中文时，很容易产生列表项目符号与内容基线不平的问题。
该包重新设置了列表的样式，使得列表项目符号与内容基线对齐。
该功能默认开启。

#note-box(title: [修复后的列表])[
+ 项目1
+ 项目2
  - 项目2.1
  - 项目2.2
  - 项目2.3
    - 项目2.3.1
    - 项目2.3.2
    - 项目2.3.3
      + 项目2.3.3.1
      + 项目2.3.3.2
        + 项目2.3.3.2.1
]

如果不喜欢该功能，可以将 `ctyp()` 函数的参数 `fix-list-enum` 设置为 `false`，则不修复列表样式。

#tip-box(title: [不修复列表])[
```typ
#let (theme, _) = ctyp(
  fix-list-enum: false,
)
#show: theme
```
]

= 页面设置

通常中文环境下，对页面的设置是基于字符数的。
该包提供了一个 `page-grid()` 函数，可以根据字符数设置页面的边距。
该函数接收 `page()` 函数的 `margin` 参数的所有合法值，但是对于 `width` 和 `height` 参数，必须是整数，表示字符的数量。

#tip-box(title: [页面设置])[
```typ
#import "@local/ctyp:0.1.0": page-grid
#show: page-grid.with(
  width: 45,
  height: 70
)
```
]

#note-box[
  由于 Typst 的限制，页面设置不能放在 `ctyp()` 函数中。
  目前采用的是提供单独的 `page-grid()` 函数来设置页面。
  这也有一些额外的好处，例如可以与其他包结合使用。
]
