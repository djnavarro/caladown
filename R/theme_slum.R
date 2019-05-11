#' Creates ggplot2 themes for the slum blogdown theme
#'
#' @param palette A character string specifying a palette
#' @param ... Additional arguments to be passed to theme_grey
#' @details Makes a ggplot2 theme
#' @return A ggplot2 theme
#' @importFrom ggplot2 %+replace%
#' @importFrom ggplot2 theme_grey
#' @importFrom ggplot2 theme
#' @importFrom ggplot2 element_rect
#' @importFrom ggplot2 element_text
#' @export
theme_slum <- function(palette = "dark", ...) {

  # check that this is a slumdown project and
  # retrieve the palette
  check_for_slumdown()
  pal <- slum_palette(palette)

  ggplot2::theme_grey(...) %+replace%
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = pal["pagecolour"], colour = pal["pagecolour"]),
      panel.background = ggplot2::element_rect(fill = pal["faded"], colour = pal["faded"]),
      legend.background = ggplot2::element_rect(fill = pal["pagecolour"], colour = pal["pagecolour"]),
      plot.title = ggplot2::element_text(colour = pal["maintext"]),
      plot.subtitle = ggplot2::element_text(colour = pal["maintext"]),
      axis.title = ggplot2::element_text(colour = pal["maintext"]),
      axis.text = ggplot2::element_text(colour = pal["maintext"]),
      legend.title = ggplot2::element_text(colour = pal["maintext"]),
      legend.text = ggplot2::element_text(colour = pal["maintext"]),
      strip.background = ggplot2::element_rect(fill = pal["maintext"], colour = pal["maintext"]),
      strip.text = ggplot2::element_text(colour = pal["pagecolour"])
    )
}
