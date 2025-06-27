#import "../lib.typ": *
#let (theme, song, hei, kai, fang) = ctyp(
  fix-list-enum: false,
  fontset: (
    ..fontset-fandol,
    song: "FZNewShuSong-Z10S",
  )
)
#show: theme

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