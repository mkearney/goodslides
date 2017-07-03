
#' goodslides
#'
#' Compiles markdown file to html5 slides
#'
#' @param f Name of file - must use either .md or .Rmd file extension.
#' @param \dots Passed to goodslides.theme.
#' @return Saved html file using same name but with .html extension.
#' @export
#' @importFrom slidify knit2slides
goodslides <- function(f, ...) {
  stopifnot(grepl("\\.md$|\\.Rmd$", f))
  if (!dir.exists("frameworks") & !file.exists(file.path("..", "goodslides"))) {
    unzip(
      system.file("data/goodslides-archive.zip", package = "goodslides")
    )
    sh <- file.copy(list.files("goodslides-archive", full.names = TRUE),
                    ".", recursive = TRUE)
    unlink("goodslides-archive", recursive = TRUE)
    unlink("__MACOSX", recursive = TRUE)
  }
  goodslides.theme(...)
  ## read lines of provided file name
  con <- file(f)
  x <- readLines(con, warn = FALSE)
  close(con)
  ## if md is provided convert to Rmd
  f <- gsub("\\.md$", ".Rmd", f)
  ## which lines are yaml
  yamln <- 1:grep("^\\-\\-\\-", x)[2]
  ## preamble/title slide
  pre <- yaml_lines(x)
  ## format transition slides
  x <- transition_slides(x)
  ## create and save temp file
  tmp <- gsub("\\/", "", tempfile(tmpdir = "", fileext = ".Rmd"))
  ##tmp <- file.path("/tmp", f)
  cat(
    paste(pre, paste(x[-yamln], collapse = "\n"), sep = "\n"),
    file = tmp,
    fill = TRUE)
  ## build
  suppressMessages(slidify::knit2slides(tmp))
  ## rename
  oldhtml <- gsub("\\.Rmd", ".html", tmp)
  newhtml <- gsub("\\.Rmd", ".html", f)
  sh <- file.rename(oldhtml, newhtml)
  ## cleanup
  sh <- file.remove(tmp, gsub("\\.Rmd", ".md", tmp))
  message("All done! Output created: ", newhtml)
}

#' yaml_lines
#'
#' Returns preamble and title slide from yaml lines
#'
#' @param x Output from specified markdown file.
#' @return Character vector of lines for Rmd file.
#' @noRd
yaml_lines <- function(x) {
    yamln <- 1:grep("^\\-\\-\\-", x)[2]
    yaml <- x[yamln][-c(1, length(yamln))]
    yaml <- strsplit(yaml, ":")
    yaml <- lapply(yaml, trimws)
    parms <- lapply(yaml, function(x) paste(x[2:length(x)], collapse = ": "))
    names(parms) <- lapply(yaml, "[[", 1)
    parms <- parms[names(parms) %in% c("author", "school", "university", "hitheme", "title")]
    preamble(parms)
}

#' transition_slides
#'
#' Identifies and reformats transition slides
#'
#' @param x Lines read in from markdown file.
#' @return Character vector of lines with Rmd file.
#' @noRd
transition_slides <- function(x) {
  tns <- grep("^---[ ]{1,}\\.transition", x)
  sls <- grep("^---", x)
  tns2 <- sls[!sls %in% tns & sls > min(tns, na.rm = TRUE)]
  tns2nd <- integer(length(tns))
  for (i in seq_along(tns)) {
    tns2nd[i] <- tns2[tns2 > tns[i]][1]
  }
  tns <- Map(c, tns, tns2nd)
  if (is.na(tns[[length(tns)]][2])) {
    tns[[length(tns)]][2] <- length(x)
  }
  for (i in seq_along(tns)) {
    x[tns[[i]][1]:tns[[i]][2]] <- format_transition_slide(
      x[tns[[i]][1]:tns[[i]][2]]
    )
  }
  x
}

#' format_transition_slide
#'
#' @param lines All lines from a transition slide.
#' @return Reformatted lines to be used in slidified Rmd.
#' @noRd
format_transition_slide <- function(lines) {
  h <- grep("^#{1,} ", lines)
  lines[h] <- paste0(
    "## &nbsp;

<h1 class=\"mytransition\">", gsub("^#{1,} ", "", lines[h]), "</h1>"
)
  lines
}

#' preamble
#'
#' Builds and formats lines to be used as preamble
#'
#' @param \dots Names params parsed from YAML lines.
#' @return Character vector of preamble lines for slidified Rmd.
#' @noRd
preamble <- function(...) {
  dots <- c(...)
  ## title and hitheme are required params
  title <- dots[["title"]]
  if (is.null(title)) {
    title <- ""
  }
  hitheme <- dots[["hitheme"]]
  if (is.null(hitheme)) {
    hitheme <- "googlecode"
  }
  ## the rest are treated as additional title slide params
  dots <- dots[!names(dots) %in% c("hitheme", "title")]
  if (length(dots) > 0) {
    dots <- paste0('<p class="titleinfo">',
                   paste(dots, collapse = "<br>\n"),
                   '</p>')
  } else {
    dots <- NULL
  }
  paste0(
    '---
framework   : "html5slides"
revealjs    : {theme: "Default", transition: cube}
widgets     : [bootstrap]
mode        : selfcontained
url         : {lib: "."}
hitheme     : ', hitheme, '
--- .transition

<h2></h2>

<link rel="stylesheet" href="./frameworks/html5slides/default/html5slides.css">

<br>
<br>

<h1 class="mytitle">', title, '</h1>

', dots, '

---

')
}

