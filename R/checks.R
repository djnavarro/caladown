
check_slumdown <- function() {

  theme_dir <- here::here("themes", "hugo-slum")
  if(!dir.exists(theme_dir)) {
    warning("The current project doesn't look like a slumdown blog")
  }
}


check_dir_blank <- function(dir) {

}
