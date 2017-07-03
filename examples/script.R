## script
setwd("../mizzou")

## mizzou theme
theme_mizzou()

## render slides
goodslides("mizzou-theme.Rmd")
browseURL("mizzou-theme.html")
setwd("../kansas")

### Kansas theme
theme_kansas()
goodslides("kansas-theme.Rmd")
browseURL("kansas-theme.html")
setwd("../custom")

## custom theme
goodslides.theme(
  color1 = "#609",
  color2 = "yellowgreen",
  stroke = FALSE
)
goodslides("custom-theme.Rmd")
browseURL("custom-theme.html")
