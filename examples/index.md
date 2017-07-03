## Examples of goodslides

### Mizzou theme

- Live demo [can be seen here](mizzou/mizzou-theme)


```r
## mizzou theme
theme_mizzou()
## render slides
goodslides("mizzou-theme.Rmd")
```

### Kansas theme

- Live demo [can be seen here](kansas/kansas-theme)


```r
## kansas theme
theme_kansas()
goodslides("kansas-theme.Rmd")
```

### Custom theme

- Live demo [can be seen here](custom/custom-theme)


```r
## custom theme
goodslides.theme(
  color1 = "#609",
  color2 = "yellowgreen", 
  stroke = FALSE
)
goodslides("custom-theme.Rmd")
```
