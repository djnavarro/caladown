

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

  # don't return anything
  return(invisible(NULL))
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
  check_if_dir_empty(dir)

  # path to the hugo-slum zip file
  theme_zip <- system.file(
    "extdata", "hugo-slum.zip",
    package = "slumdown", mustWork = TRUE
  )

  # path to the themes folder and the example site
  dir_theme <- file.path(dir,"themes")
  dir_sample <- file.path(dir,"themes", "hugo-slum", "exampleSite")

  # create the directories for the theme
  if(!dir.exists(dir)) dir.create(dir)
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

  # don't return anything
  return(invisible(NULL))
}



#' Adds a nojekyll file to a slumdown blog
#'
#' @param dir Where is the blog directory
#' @param quietly Suppress the output message (default = FALSE)
#' @details Adds the .nojekyll file for github pages deployment
#' @export
build_slum_nojekyll <- function(dir, quietly = FALSE) {

  # paths
  static_dir <- file.path(dir, "static")
  jekyll_path <- file.path(dir, "static", ".nojekyll")

  # create directory if needed
  if(!dir.exists(static_dir)) {
    dir.create(static_dir)
  }

  # create blank file
  writeLines(character(), jekyll_path)

  # optionally, message user
  if(!quietly) {
    message("Created file .nojekyll in", static_dir)
  }

  # don't return anything
  return(invisible(NULL))
}



#' Adds a project file to slumdown blog
#'
#' @param dir Where is the blog directory
#' @param open Should RStudio open the project?
#' @details Creates an RStudio project file to specify project root.
#' @importFrom usethis create_project
#' @export
build_slum_project <- function(dir, open = interactive()) {

  # throw an error if rstudio is not available
  check_for_rstudio()

  # otherwise create the project
  usethis::create_project(
    path =  normalizePath(dir),
    open = open
  )
}


#' Adds a here sentinel file to a slumdown blog
#'
#' @param dir Where is the blog directory
#' @param quietly Suppress the output message (default = FALSE)
#' @details Adds the .here file to specify project root
#' @export
build_slum_here <- function(dir, quietly = FALSE) {

  # throw error if directory doesn't exist
  if(!dir.exists(dir)) {
    stop("Specified location for .here does not exist")
  }

  # create blank file
  writeLines(character(), file.path(dir, ".here"))

  # optionally, message user
  if(!quietly) {
    message("Created file .here in", dir)
  }

  # don't return anything
  return(invisible(NULL))
}



#' Creates new slumdown site
#'
#' @param dir Where to create the new blog
#' @param remote Install from github (remote = TRUE) or locally (remote = FALSE)
#' @param project String specifying whether to use an rstudio project
#' (project = "rstudio") or a .here file (project = "here")
#' @param nojekyll Add a nojekyll file?
#' @details Create a new slumdown blog
#' @export
new_slum <- function(dir, remote = FALSE, project = "rstudio", nojekyll = TRUE) {

  # first build the bulk of the blog
  if(remote) {
    build_slum_remotely(dir)

  } else {
    build_slum_locally(dir)
  }

  # add a nojekyll file if requested
  if(nojekyll) {
    build_slum_nojekyll(dir)
  }

  # add files specifying the location of the project root
  if(project == "rstudio") {
    build_slum_project(dir)

  } else if(project == "here") {
    build_slum_here(dir)

  } else {
    stop("Value for `project` must be 'rstudio' or 'here'")
  }

  return(invisible(NULL))
}








