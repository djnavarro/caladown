#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param theme Location of hugo theme
#' @param hostname Where to look for repo
#' @param ... Other arguments to be passed to blogdown::new_site
#' @details This is just a wrapper to blogdown::new_site
#' @importFrom blogdown new_site
#' @export
slum_new <- function(
  dir = ".",
  theme = "djnavarro/hugo_slum",
  hostname = "github.com", ...) {

  # create the blogdown site
  blogdown::new_site(
    dir = dir,
    ...,
    theme = theme,
    hostname = hostname,
    sample = FALSE
  )
}

#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param here Whether to create a .here file
#' @param nojekyll Whether to create a .nojekyll file
#' @details This is just a wrapper to blogdown::new_site
#' @export
slum_tidy <- function(
  dir = ".", here = TRUE, nojekyll = TRUE) {

  # create a .here file
  if(here) {
    here_path <- file.path(dir,".here")
    writeLines(character(), here_path)
    message("Created file .here in", file.path(dir))
  }

  # create a .nojekyll file
  if(nojekyll) {
    jekyll_path <- file.path(dir,"static",".nojekyll")
    writeLines(character(), jekyll_path)
    message("Created file .nojekyll in", file.path(dir,"static"))
  }
}


