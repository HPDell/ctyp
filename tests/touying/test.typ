#import "/lib.typ": *
#import "@preview/kouhu:0.2.0": *
#import "@preview/touying:0.6.1": *
#import themes.university: *
#import "@preview/theorion:0.3.2": *
#import cosmos.clouds: *
#show: show-theorion

#let (ctypset, cjk) = ctyp(fix-first-line-indent: false, heading-numbering: "1.1")
#show: ctypset

#show: university-theme.with(
  config-info(
    title: "测试 Touying 幻灯片",
    date: datetime.today(),
    institution: [单位],
    logo: emoji.school,
  ),
  config-page(
    margin: (top: 2.25em, bottom: 1em, x: 2em),
  )
)

#title-slide()[
  #text(size: 2em)[*测试 Touying 幻灯片*]
]

== 目录 <touying:hidden>

#components.adaptive-columns(outline(title: none, indent: 1em))

= 动画

== 简单动画

可以使用 `#pause` 来 #pause 以在下一张幻灯片展示其他信息。

#pause

就像这样

#meanwhile

同时，#pause 可以使用 `#meanwhile` 来 #pause 同时展示一些其他信息。

== 复杂动画

在第 #touying-fn-wrapper((self: none) => str(self.subslide)) 张幻灯片中我们可以

使用 #uncover("2-")[`#uncover` 函数] 预留位置

使用 #only("2-")[`#only` 函数] 不预留位置

#alternatives[调用 `#only` 多次 \u{2717}][调用 `#alternatives` 函数 #sym.checkmark] 来选择其中一个。

= 定理

== 质数

#definition[
  一个自然数被称为 #highlight[_质数_]，当且仅当它大于1且无法被写作两个比它小的自然数的乘积。
]
#example[
  数字 $2$ 、 $3$ 和 $17$ 是质数。
  @cor_largest_prime 表明质数是无穷的。
]

#theorem(title: "Euclid")[
  质数有无穷多个。
]
#pagebreak(weak: true)
#proof[
  反证法。假设 $p_1, p_2, dots, p_n$ 是可数有穷个质数。
  令 $P = p_1 p_2 dots p_n$。 
  由于 $P + 1$ 不在该列中，它不可能是指数。
  因此，存在质因数 $p_j$ 可以整除 $P + 1$。
  由于 $p_j$ 也可以整除 $P$，它必须整差值 $(P + 1) - P = 1$，矛盾。
]

#corollary[
  没有最大的质数。
] <cor_largest_prime>
#corollary[
  有无穷多的合数。
]

#theorem[
  存在任意长的合数序列。
]

#proof[
  对于任意 $n > 2$，考虑 $
    n! + 2, quad n! + 3, quad ..., quad n! + n
  $
]

= 其他

== 并排幻灯片

#slide(composer: (1fr, 1fr))[
  第一列。
][
  第二列。
]


== 多页幻灯片

#kouhu(length: 406)


#show: appendix

= 附录

== 附录

注意该页的页码。
