## slideR
R package for making minimalist, elegant html slides.

## Install


```r
if (!"devtools" %in% installed.packages()) {
  install.packages("devtools")
}
devtools::install_github("mkearney/slideR")
```

## Use

Convert markdown (.md) and Rmarkdown (.Rmd) files using the `slideR`
function. An [example of a compatible markdown file can be found here](docs/index).


```r
library(slideR)
slideR("example.md")
browseURL("example.html")
```

If the current working directory doesn't already have a frameworks
directory, the `slideR` function will download the front-end libraries
for you. Just make sure the markdown file is located in your working
directory or else the styles and formatting will break.

## Style and formatting

### Default theme

Over time I'll work on making this more oriented toward general use,
but for now the default theme is Mizzou---specifically their School of
Journalism and Data Science and Analytics program, both of which I'll
be joining this Fall.

### Custom themes

It's possible to customize style features of the slides, including colors,
fonts, and background images (logos) using the `slideR.theme`
function.


```r
slideR.theme(
  color1 = "yellowgreen",
  color2 = "mediumpurple4",
  logo1 = NULL,
  logo2 = NULL
)
slideR("example.md")
```


#### Kansas theme

To create a University of Kansas inspired theme, download the logo and
enter the following customizations.


```r
dir.create("images")
download.file(
  "https://dl.dropboxusercontent.com/u/94363099/logo.png",
  "images/logo.png"
)
slideR.theme(
  color1 = "#0051ba",
  color2 = "#fff",
  logo1 = "logo.png",
  logo2 = NULL,
  stroke = FALSE
)
slideR("example")
```

