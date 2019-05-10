
#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param project Create a tidy slum
#' @param nojekyll Add a nojekyll file
#' @param ... Other arguments to be passed to blogdown::new_site
#' @details This is just a wrapper to blogdown::new_site
#' @export
new_slum <- function(
  dir = ".",
  project = TRUE,
  nojekyll = TRUE,
  ...) {

  # create the blogdown site with no theme
  blogdown::new_site(
    dir = dir,
    theme = "djnavarro/hugo-slum",
    sample = FALSE,
    serve = FALSE
  )

  # create a .nojekyll file
  if(nojekyll) {
    dir.create(file.path(dir,"static"))
    jekyll_path <- file.path(dir,"static",".nojekyll")
    writeLines(character(), jekyll_path)
    message("Created file .nojekyll in", file.path(dir,"static"))
  }

  # create an Rstudio project (or .here if not in Rstudio)
  # NOTE: this isn't robust if it's .here I think????
  if(project) {
    usethis::create_project(normalizePath(dir))
  }

}



#' Build slumdown blog from remote source
#'
#' @importFrom blogdown new_site
#' @param dir string specifying the blog location
#' @detail Creates the directory structure for a new slumdown blog using
#' the github repository as the source. This method of installation is
#' a wrapper to blogdown::new_site, and requires internet access.
#' @export
build_slum_remotely <- function(dir) {
  blogdown::new_site(
    dir = dir,
    theme = "djnavarro/hugo-slum",
    sample = FALSE,
    serve = FALSE
  )
}


#' Build slumdown blog from local source
#'
#' @importFrom utils unzip
#' @param dir string specifying the blog location
#' @details Creates the directory structure for a new slumdown blog using
#' the local copy of the hugo-slum.zip file. It does not rely on internet
#' resources.
#' @export
build_slum_locally <- function(dir) {

  # check that location of the output is
  # safe before attempting to write
  check_dir_blank(dir)

  # path to the hugo-slum zip file
  theme_zip <- system.file(
    "extdata", "hugo-slum.zip",
    package = "slumdown", mustWork = TRUE
  )

  # path to the themes folder and the example site
  dir_theme <- file.path(dir,"themes")
  dir_sample <- file.path(dir,"themes", "hugo-slum", "exampleSite")

  # create the directories for the theme
  dir.create(dir)
  dir.create(dir_theme)

  # unzip the theme itself
  utils::unzip(zipfile = theme_zip, exdir = dir_theme)

  # create directories for the sample site. this is such a
  # ridiculous way to do this. sigh.
  dir.create(file.path(dir, "content"))
  dir.create(file.path(dir, "content", "post"))
  dir.create(file.path(dir, "content", "project"))
  dir.create(file.path(dir, "layouts"))
  dir.create(file.path(dir, "layouts", "partials"))
  dir.create(file.path(dir, "static"))
  dir.create(file.path(dir, "static", "data"))

  # copy the example site into the blog root directory
  site_files <- list.files(dir_sample, recursive = TRUE)
  file.copy(
    from = file.path(dir_sample, site_files),
    to = file.path(dir, site_files)
  )

  # write the index.Rmd file
  writeLines(
    c("---","site: blogdown:::blogdown_site","---"),
    file.path(dir, "index.Rmd")
  )

}







