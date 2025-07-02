#import "../lib.typ": *
#let (theme, _) = ctyp()
#show: theme

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