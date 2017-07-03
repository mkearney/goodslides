#' goodslides.theme
#'
#' Sets style theme for html slides.
#'
#' @param base_size Size of base font. Defaults to 28.
#' @param base_weight Weight of base font. Defaults to 300.
#' @param base_color Color of base font. Defaults to #111.
#' @param base_family Base font family. Defaults to Roboto.
#' @param code_family Code font family. Defaults to Inconsolata.
#' @param heading_family Heading font family. Defaults to Montserrat.
#' @param heading_weight Weight of heading font. Defaults to 600.
#' @param color1 Primary theme color. Defaults to yellowgreen.
#' @param color2 Secondary theme color. Defaults to dark purple.
#' @param color3 Optional color used for stroke outline.
#' @param logo1 First logo.
#' @param logo2 Second logo.
#' @param logo3 Third logo. For transition slides.
#' @param stroke Logical indicating whether to use dark outline on slide headings.
#'   Default to true.
#' @return Saves modified style file.
#' @export
goodslides.theme <- function(base_size = NULL,
                             base_weight = NULL,
                             base_family = NULL,
                             base_color = NULL,
                             code_family = NULL,
                             heading_family = NULL,
                             heading_weight = NULL,
                             color1 = NULL,
                             color2 = NULL,
                             color3 = NULL,
                             logo1 = NULL,
                             logo2 = NULL,
                             logo3 = NULL,
                             stroke = TRUE,
                             new = TRUE) {
  if (new) {
    unlink("frameworks", recursive = TRUE)
  }
  if (!dir.exists("frameworks") &
      !file.exists(file.path("..", "goodslides", "DESCRIPTION"))) {
    unzip(
      system.file("data/goodslides-archive.zip",
                  package = "goodslides"),
      junkpaths = FALSE,
      exdir = "."
    )
    file.copy(
      list.files("goodslides-archive", full.names = TRUE),
      ".",
      recursive = TRUE
    )
    unlink("goodslides-archive", recursive = TRUE)
    unlink("__MACOSX", recursive = TRUE)
  }
  css <- readLines(
    "frameworks/html5slides/default/html5slides.css",
    warn = FALSE
  )
  if (any(grepl("color1", css))) {
    ## update font styles
    css <- update_stroke(css, stroke)
    if (stroke & is.null(color3)) color3 <- "#fff"
    if (is.null(color1)) color1 <- "yellowgreen"
    if (is.null(color2)) color2 <- "#104"
    if (stroke) {
      color4 <- color2
      color2 <- color1
    } else {
      color4 <- color2
    }
    css <- update_logos(css, logo1, logo2, logo3)
    css <- update_colors(css, color1, color2, color3, color4)
    css <- update_base(css, base_family, base_color, base_weight, base_size)
    css <- update_heading(css, heading_family, heading_weight)
    css <- update_code_family(css, code_family)
    writeLines(css, "frameworks/html5slides/default/html5slides.css")
  }
}

#' theme_kansas
#'
#' A university of kansas inspired theme.
#'
#' @return Sets Kansas-themed html presentation.
#' @export
#' @noRd
theme_kansas <- function() {
  goodslides.theme(
    color1 = "#0051ba",
    color2 = "#fff",
    logo1 = "kansas.png",
    stroke = FALSE
  )
}

#' theme_mizzou
#'
#' A university of missouri inspired theme.
#'
#' @return Sets Mizzou-themed html presentation.
#' @export
#' @noRd
theme_mizzou <- function() {
  goodslides.theme(
    color1 = "#f1b82d",
    color2 = "#000",
    logo1 = "mizzou-journalism.png",
    logo2 = "mizzou-dsa.png",
    logo3 = "mizzou-banner.png",
    stroke = TRUE
  )
}


update_code_family <- function(css, family = NULL) {
  if (is.null(family)) family <- "Inconsolata"
  gsub("code_family", family, css)
}


update_colors <- function(css, color1, color2, color3 = NULL, color4 = NULL) {
  stopifnot(is.character(css))
  stopifnot(is.character(color1), length(color1) == 1L)
  stopifnot(is.character(color2), length(color2) == 1L)
  if (is.null(color3)) color3 <- color1
  stopifnot(is.character(color3), length(color3) == 1L)
  css <- gsub("color1", color1, css)
  css <- gsub("color2", color2, css)
  css <- gsub("color3", color3, css)
  if (!is.null(color4)) {
    css <- gsub("color4", color4, css)
  }
  css
}

update_logos <- function(css, logo1 = NULL, logo2 = NULL, logo3 = NULL) {
  if (is.null(logo1) & is.null(logo2)) {
    css[grep("background-image.*logo1", css)] <- ""
  } else if (!is.null(logo2)) {
    if (file.exists(file.path("images", logo2))) {
      logo2 <- paste0("../../../images/", logo2)
    } else if (file.exists(file.path("frameworks/html5slides/default/images", logo2))) {
      logo2 <- paste0("images/", logo2)
    } else if (file.exists(logo2)) {
      logo2 <- paste0("../../../../images/", logo2)
    } else {
      logo2 <- ""
    }
    css <- gsub("images/logo2", logo2, css)
  }
  if (!is.null(logo1)) {
    if (file.exists(file.path("images", logo1))) {
      logo1 <- paste0("../../../images/", logo1)
    } else if (file.exists(file.path("frameworks/html5slides/default/images", logo1))) {
      logo1 <- paste0("images/", logo1)
    } else if (file.exists(logo1)) {
      logo1 <- paste0("../../../../images/", logo1)
    } else {
      logo1 <- ""
    }
    css <- gsub("images/logo1", logo1, css)
  }
  if (!is.null(logo3)) {
    if (file.exists(file.path("images", logo3))) {
      logo3 <- paste0("../../../images/", logo3)
    } else if (file.exists(file.path("frameworks/html5slides/default/images", logo3))) {
      logo3 <- paste0("images/", logo3)
    } else if (file.exists(logo3)) {
      logo3 <- paste0("../../../../images/", logo3)
    } else {
      logo3 <- NULL
    }
  }
  if (is.null(logo3)) {
    css[grep("background-image.*logo3", css)] <- ""
    css <- gsub("background-color: color3", "background: color3", css)
  } else {
    css <- gsub("images/logo3", logo3, css)
  }
  css
}


update_base <- function(css, family, color, weight, size) {
  if (is.null(family)) family <- "Helvetica Neue"
  css <- gsub("base_family", family, css)
  if (is.null(color)) color <- "#111"
  css <- gsub("base_color", color, css)
  if (is.null(weight)) weight <- "400"
  css <- gsub("base_weight", weight, css)
  if (is.null(size)) size <- "28"
  gsub("base_size", size, css)
}

update_heading <- function(css, family, weight) {
  if (is.null(family)) family <- "Montserrat"
  css <- gsub("heading_family", family, css)
  if (is.null(weight)) weight <- "600"
  gsub("heading_weight", weight, css)
}


update_stroke <- function(css, stroke = FALSE) {
  if (stroke) {
    css
  } else {
    gsub("-webkit-text-stroke: 1px color2;", "", css)
  }
}
