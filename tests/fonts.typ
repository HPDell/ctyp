#import "../lib.typ": *
#let (theme, song, hei, kai, fang) = ctyp()
#show: theme

= 《浪淘沙·九曲黄河万里沙》

滚滚长江东逝水，#song[浪花淘尽英雄]。是非成败转头空。青山依旧在，几度夕阳红。

白发渔樵江渚上，#hei[惯看秋月春风]。一壶浊酒喜相逢。古今多少事，都付笑谈中。


#let (theme, song, hei, kai, fang) = ctyp(
  font-cjk-map: (
    heading: "hei"
  ),
)
#show: theme

= 《浪淘沙·九曲黄河万里沙》

滚滚长江东逝水，#kai[浪花淘尽英雄]。是非成败转头空。青山依旧在，几度夕阳红。

白发渔樵江渚上，#fang[惯看秋月春风]。一壶浊酒喜相逢。古今多少事，都付笑谈中。
