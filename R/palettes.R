# Functions that work with palettes

#' List the colour palettes that slum knows
#' @importFrom here here
#' @export
slum_listpalettes <- function() {

  check_slumdown()

  # list the styles from the theme directory
  base_css <- here::here("themes", "hugo-slum", "static", "css")
  styles <- list.files(
    base_css, pattern = "palette_.*\\.css", full.names = TRUE)

  # list the styles from the user directory
  user_css <- here::here("static", "css")
  if(dir.exists(user_css)) {
    user_styles <- list.files(
      user_css, pattern = "palette_.*\\.css", full.names = TRUE)
    styles <- c(user_styles, styles)
  }

  return(styles)
}

#' Retrieve palette information
#' @param palette Character string with the name of the palette (e.g., "dark")
#' @details Searches the two standard locations (user static/css and theme
#' static/css) to find a slum palette with the appropriate name.
#' @return A named character vector
#' @importFrom here here
#' @export
slum_getpalette <- function(palette) {

  check_slumdown()

  # look in user directory first
  palette_file <- here::here("static", "css",
                             paste0("palette_", palette, ".css"))

  # if not there look in theme directory
  if(!file.exists(palette_file)) {
    palette_file <- here::here("themes", "hugo-slum", "static", "css",
                               paste0("palette_", palette, ".css"))
  }

  # if not there either, give up
  if(!file.exists(palette_file)) {
    stop(palette, " palette not found")
  }

  # read the palette file
  raw <- readLines(palette_file)

  # extract relevant information
  inds <- grep("^.*--(.*):(.*);.*$", raw)
  tidy <- gsub(
    pattern = "^.*--(.*):(.*);.*$",
    replacement = "\\1 \\2",
    x = raw[inds])

  # convert to a named vector of colours
  x <- strsplit(tidy, "  *")
  names <- sapply(x, function(x){x[1]})
  values <- sapply(x, function(x){x[2]})
  names(values) <- names

  return(values)
}



#' Retrieve palette information
#' @param name Character string with the name of the new palette (e.g., "cerulean")
#' @param pagecolour Character string with hex code (e.g., "#333333") for the page colour
#' @param maintext Character string specifying the main text colour
#' @param faded Character string specifying the "faded" colour
#' @param highlight Character string for highlight (mostly in links)
#' @param lowlight Character string for lowlight (mostly in code)
#' @param overwrite Should an existing file be overwritten?
#' @details Writes a file to the user directory
#' @importFrom here here
#' @export
slum_addpalette <- function(name, pagecolour, maintext, faded, highlight, lowlight, overwrite = FALSE) {

  check_slumdown()

  # content of the palette file
  pal <- c(
    paste0(" /* ", name, " colour scheme */"),
    ":root { ",
    paste0("  --pagecolour: ", pagecolour , ";  "),
    paste0("  --maintext: ", maintext, ";  "),
    paste0("  --faded: ", faded, "; "),
    paste0("  --highlight: ", highlight, "; "),
    paste0("  --lowlight: ", lowlight, "; "),
    "}"
  )

  # create a user css directory if needed
  path <- here::here("static", "css")
  if(!dir.exists(path)) {
    dir.create(path)
  }

  # create the css file
  fname <- paste0("palette_", name, ".css")
  if(file.exists(file.path(path, fname)) & overwrite == FALSE) {
    stop(name, "palette already exists in static/css/")
  } else {
    writeLines(pal, file.path(path, fname))
  }

}


#' Specify background colour with knitr
#' @param palette The palette name (default = "dark")
#' @param name The colour (default = "pagecolour")
#' @details Convenience function that uses knitr to pass a background colour
#' argument to the graphics device
#'
#' @importFrom knitr opts_chunk
#' @export
slum_setdevicecolour <- function(palette = "dark", name = "pagecolour") {
  knitr::opts_chunk$set(dev.args = list(bg=slum_getpalette(palette)[name]))
}

