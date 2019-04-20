#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param theme Location of hugo theme
#' @param hostname Where to look for repo
#' @param project Create a tidy slum
#' @param nojekyll Add a nojekyll file
#' @param ... Other arguments to be passed to blogdown::new_site
#' @details This is just a wrapper to blogdown::new_site
#' @importFrom blogdown new_site
#' @export
slum_new <- function(
  dir = ".",
  theme = "djnavarro/hugo-slum",
  hostname = "github.com",
  project = TRUE,
  nojekyll = TRUE,
  ...) {

  # create the blogdown site
  blogdown::new_site(
    dir = dir,
    ...,
    theme = theme,
    hostname = hostname,
    sample = FALSE
  )

  # create a .nojekyll file
  if(nojekyll) {
    jekyll_path <- file.path(dir,"static",".nojekyll")
    writeLines(character(), jekyll_path)
    message("Created file .nojekyll in", file.path(dir,"static"))
  }

  # creat an Rstudio project (or .here if not in Rstudio)
  if(project) {
    usethis::create_project(normalizePath(dir))
  }
}

#' List the colour palettes that slum knows
#' @importFrom here here
#' @export
slum_palettes <- function() {

  # check if this is actually a slumdown blog
  theme_dir <- here::here("themes", "hugo-slum")
  if(!dir.exists(theme_dir)) {
    stop(theme_dir," does not exist")
  }

  # list the styles from the theme directory
  base_css <- here::here("themes", "hugo-slum", "static", "css")
  styles <- list.files(base_css, pattern = "palette_.*\\.css")

  # list the styles from the user directory
  user_css <- here::here("static", "css")
  if(dir.exists(user_css)) {
    user_styles <- list.files(user_css, pattern = "palette_.*\\.css")
    styles <- c(styles, user_styles)
  }

  return(styles)
}
