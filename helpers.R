
# copy the hugo theme to a zipped file for the package
refresh_local <- function() {
  hugo_files <- list.files(
    path = here::here("hugo-slum"),
    recursive = TRUE,
    full.names = TRUE
  )
  zip_file <- here::here("inst", "extdata", "hugo-slum.zip")
  if(file.exists(zip_file)) file.remove(zip_file)
  utils::zip(zip_file, hugo_files)
}
