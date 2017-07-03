#' @title goodslides
#'
#' @description goodslides provides a simple way for good html
#'   slides in R.
#'
#' @examples
#' \dontrun{
#' ## convert slides.md to html slides presentation
#' goodslides("slides.md")
#' }
#'
#' @docType package
#' @aliases goodslide
#' @name goodslides
NULL

.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Time for some goodslides!")
}
