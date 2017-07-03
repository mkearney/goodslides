---
author      : "Michael W. Kearney"
title       : "DSCA 8000:<br>Slide presentation template"
framework   : html5slides
widgets     : bootstrap
highlighter : highlight.js
hitheme     : github
mode        : selfcontained
url         : {lib: "."}
knit        : goodslides::goodslides
---

## rtweet pkg


```r
## stream
rt <- stream_tweets(timeout = 30, verbose = FALSE)
## plot
mutate(rt, eng = ifelse(lang == "en" & !is.na(lang),
                        "English", "Non-English")) %>%
  group_by(eng) %>%
  ts_data("5 secs") %>%
  group_by(eng) %>%
  trimts(1, 1) %>%
  ggplot(aes(x = time, y = n)) +
  geom_smooth(method = "loess", aes(group = eng), colour = "#aa00cc", alpha = .3) +
  geom_point(aes(fill = eng), shape = 21, size = 3.5, alpha = .7) +
  labs(title = "Filtering Twitter's stream API using stop words",
       subtitle = "Tweets collected and aggregated in 10 second
	   intervals in R using rtweet") +
  ggthemes::theme_fivethirtyeight(base_size = 18) +
  theme(legend.title = element_blank()) +
  scale_color_manual(values = c("#5577fa", "#df6666")) +
  scale_fill_manual(values = c("#5577fa", "#df6666"))
```

---

## R code example


```r
10 + 10
```

```
## [1] 20
```

```r
foo <- function(n) {
  data.frame(
    var1 = rnorm(n),
	var2 = rnorm(n)
  )
}
df <- foo(10)
print(df)
```

```
##        var1      var2
## 1   0.43225 -0.150125
## 2   1.40051  0.287400
## 3   0.21360 -0.816828
## 4   2.09123  0.225610
## 5   0.56325  1.161580
## 6   0.53642 -1.284858
## 7   0.36809  0.258306
## 8   0.24627  0.099335
## 9  -0.25374 -0.510551
## 10  1.09260  0.784540
```

--- .transition

## Diversity

---

## Diversity
** Exposure to diversity higher than ever**
- Travel
- Technology
- Trade
- Television

--- .transition

## That's all!

