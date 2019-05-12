
# copy the hugo theme to a zipped file for the package: this is just a
# convenience function so that I can work on the hugo theme and the R
# package at the same time
refresh_hugo_cache <- function() {

  # list all the hugo files
  hugo_files <- list.files(
    path = here::here("hugo-slum"),
    recursive = TRUE
  )

  # find (and remove) zip file
  zip_file <- here::here("inst", "extdata", "hugo-slum.zip")
  if(file.exists(zip_file)) file.remove(zip_file)

  # create zip
  utils::zip(
    zipfile = zip_file,
    files = file.path(".", "hugo-slum", hugo_files)
  )

}

# copy the hugo theme across to the hugo-slum project, to ensure that
# the different versions stay in sync.
clean_standalone <- function() {

  # location of root of the other project
  standalone_root <- normalizePath(here::here("..","hugo-slum"))

  # function to wipe a directory
  clean_dir <- function(subdir) {
    dir <- normalizePath(file.path(standalone_root, subdir))
    files <- normalizePath(list.files(dir, recursive = TRUE,
                                      full.names = TRUE, include.dirs = TRUE))
    unlink(files, recursive = TRUE, force = TRUE)
  }

  clean_dir("archetypes")
  clean_dir("docs")
  clean_dir("exampleSite")
  clean_dir("layouts")
  clean_dir("static")

  clean_file <- function(file) {
    path <- file.path(standalone_root, file)
    if(file.exists(path)) file.remove(path)
  }

  clean_file("LICENSE")
  clean_file("README.md")
  clean_file("README.Rmd")
  clean_file("theme.toml")

}

# extract
extract_to_standalone <- function() {

  # path to the hugo-slum zip file
  theme_zip <- normalizePath(here::here("inst", "extdata", "hugo-slum.zip"))
  standalone_root <- normalizePath(here::here(".."))
  utils::unzip(zipfile = theme_zip, exdir = standalone_root)
}

sync_slums <- function() {
  refresh_hugo_cache() # from slumdown root version to zip
  clean_standalone() # clear the standalone version
  extract_to_standalone() # extract from zip to standalone
}

