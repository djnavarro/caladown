
check_for_slumdown <- function(dir = here::here("themes", "hugo-slum")) {
  if(!dir.exists(dir)) {
    warning("Cannot find the hugo-slum theme")
  }
  return(invisible(NULL))
}


check_dir_blank <- function(dir) {

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
}
