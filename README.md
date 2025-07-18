# CTyp: Typst 的基础中文环境

CTyp 是一个用于提供 Typst 中文排版支持的包。
该包集成了一些常用的中文排版设置，用于提供快速的中文排版体验。

> [!WARNING]
> 由于 Typst 的中文排版支持仍不完善，该包只能提供非语言级的排版支持。
> 并不保证能够实现所有中文排版需求。

## 快速开始

通过以下代码快速使用 CTyp 包的设置：

```typ
#import "@local/ctyp:0.1.0": ctyp
#let (ctypset, cjk) = ctyp()
#show: ctypset
```

> [!NOTE]
> 变量名 `ctypset` 和 `cjk` 可以自行设置，无需使用文档中的名字。

## 主要功能

- [x] 中文字体设置
- [x] 页面边距根据字符数控制
- [x] 列表符号/编号基线位置修复

具体功能请参考[使用手册](doc/manual.pdf)或 Wiki。

## 开发路线

- [ ] 使用 [Elembic](https://typst.app/universe/package/elembic) 包实现可配置的元素。
- [ ] 接口修改为类似于 [Touying](https://typst.app/universe/package/touying) 中的 `config-*` 函数。
- [ ] 根据 [Chinese layout gap analysis](https://typst-doc-cn.github.io/clreq/) 文档尽可能实现更多中文排版需求。

## 贡献

欢迎提交 PR 或 Issue。

## 许可证

CTyp 使用 [MIT 许可证](LICENSE)。
