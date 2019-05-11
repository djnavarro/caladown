
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
