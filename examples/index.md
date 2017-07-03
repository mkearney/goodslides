---
hitheme     : googlecode
author      : Michael W. Kearney
school      : School of Journalism<br>Informatics Institute
university  : University of Missouri
title       : DSCA 8000:<br>Slide presentation template
---

## rtweet pkg

```{r, eval=FALSE}
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

```{r, eval=TRUE}
10 + 10

foo <- function(n) {
  data.frame(
    var1 = rnorm(n),
	var2 = rnorm(n)
  )
}
df <- foo(10)
print(df)
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

