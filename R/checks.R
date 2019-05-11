
check_slumdown <- function() {

  theme_dir <- here::here("themes", "hugo-slum")
  if(!dir.exists(theme_dir)) {
    warning("The current project doesn't look like a slumdown blog")
  }
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
