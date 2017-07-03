## goodslides
R package for making good slides

## Install

Download from Github to install.

```r
if (!"devtools" %in% installed.packages()) {
  install.packages("devtools")
}
devtools::install_github("mkearney/goodslides")
```

## Examples

Use the `goodslides()` function to convert markdown (.md) or Rmarkdown
(.Rmd) files into good slides. An example of a compatible markdown
file and its accompanied output can be found in [examples](examples).

```r
## load goodslides
library(goodslides)

## render markdown to html
goodslides("example.md")

## open html presentation slides
browseURL("example.html")
```

By default `goodslides()` will download relevant front-end libraries for
you. Just make sure the markdown file is located in your working
directory---which is where the frontend 'frameworks' files will be
placed. Otherwise, the slides will not be good.

## Themes

Users still have lots of room to customize beyond the intial default
template, which simply includes a couple of bright colors. To modify
the style and format of the slides, use the `goodslides.theme()`
function. For the most part, themes are limited to various color
pairs, but users may also experiment with logos and banners (logo1 =
topright, logo2 = topleft, logo3 = transition banner) and lighter
(stroke = TRUE) and darker (stroke = FALSE) variants.

```r
## set theme
goodslides.theme(
  color1 = "maroon",
  color2 = "white",
  logo1 = NULL,
  logo2 = NULL,
  stroke = FALSE
)
## render slides
goodslides("example.md")
```

### Mizzou theme

Over time I'll hopefully add more themes but for now there are only
two premade ones--University of Missouri and University of Kansas. The
Mizzou theme currently assumes the presenter has some interest or
affiliation with the School of Journalism and Data Science and
Analytics program.

```{r}
## set theme
theme_mizzou()

## render slides
goodslides("example.md")
```

### Kansas theme

The University of Kansas theme, on the other hand, is not specific to
any college or school.

```r
## set theme
theme_kansas()

## render slides
goodslides("example.md")
```

To modify and execute the example, you can also just clone this repository:

```bash
git clone https://github.com/mkearney/goodslides.git
```
