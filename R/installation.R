#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param here Whether to create a .here file
#' @param nojekyll Whether to create a .nojekyll file
#' @param enter_slum Whether to change the working directory
#' @param theme Location of hugo theme
#' @param ... Arguments to be passed to blogdown::new_site
#' @details This is just a wrapper to blogdown::new_site
#' @importFrom blogdown new_site
#' @importFrom here set_here
#' @export
new_slum <- function(
  dir = ".", here = TRUE, nojekyll = TRUE, enter_slum = TRUE,
  theme = "https://github.com/djnavarro/hugo_slum", ...) {

  # create the blogdown site
  blogdown::new_site(
    dir = dir,
    ...,
    theme = theme,
    sample = FALSE
  )

  # create a .here file
  if(here) {
    here::set_here(dir, verbose = TRUE)
  }

  # create a .nojekyll file
  if(nojekyll) {
    jekyll_path <- file.path(dir,"static",".nojekyll")
    writeLines(character(), jekyll_path)
    message("Created file .nojekyll in", file.path(dir,"static"))
  }

  # go to that directory
  if(enter_slum) {
    setwd(dir)
  }
}
