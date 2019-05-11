
# Functions to check that various conditions hold.
# They're not well named: ideally should make clear
# what action they'll take (e.g., stop_if_not_slumdown
# vs warn_if_not_slumdown)


check_for_slumdown <- function(dir = here::here("themes", "hugo-slum")) {
  if(!dir.exists(dir)) {
    warning("Cannot find the hugo-slum theme")
  }
  return(invisible(NULL))
}



check_if_dir_empty <- function(dir) {
  if(dir.exists(dir)) {
    dir_contents <- list.files(dir, recursive = TRUE)
    if(length(dir_contents) > 0) {
      stop("'", dir, "' exists and is not empty")
    }
  }
  return(invisible(NULL))
}



check_for_rstudio <- function() {

  # throw error if the rstudioapi package is missing
  if(class(try(find.package("rstudioapi"))) == "try-error") {
    stop("rstudio is not available")
  }

  # throw error if the package says rstudio is unavailable
  if(!rstudioapi::isAvailable()) {
    stop("rstudio is not available")
  }

  return(invisible(NULL))
}
