#let page-grid(
  width: 42,
  height: 65,
  ..args,
  body
) = {
  set page(margin: (
    x: (100% - width * 1em) / 2,
    y: (100% - height * 1em) / 2,
    ..args.named()
  ))
  body
}