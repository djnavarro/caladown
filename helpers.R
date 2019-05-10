
# copy the hugo theme to a zipped file for the package: this is just a
# convenience function so that I can work on the hugo theme and the R
# package at the same time
refresh_hugo_cache <- function() {
  hugo_files <- list.files(
    path = here::here("hugo-slum"),
    recursive = TRUE,
    full.names = TRUE
  )
  zip_file <- here::here("inst", "extdata", "hugo-slum.zip")
  if(file.exists(zip_file)) file.remove(zip_file)
  utils::zip(zip_file, hugo_files)
}
