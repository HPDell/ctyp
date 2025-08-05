#import "@preview/cjk-unbreak:0.1.1": remove-cjk-break-space
#import "/lib.typ": *
#let (theme, (song, hei, kai, fang)) = ctyp(remove-cjk-break-space: false)
#show: theme

#show: remove-cjk-break-space

滚滚长江东逝水，浪花淘尽英雄。
是非成败转头空。青山依旧在，几度夕阳红。

白发渔樵江渚上，惯看秋月春风。
*一壶浊酒喜相逢*。古今多少事，都付笑谈中。