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

  if(palette == "dark") {
    primary <- "#DDDDDD"
    subtle <- "#888888"
    behind <- "#333333"
  }

  if(palette == "light") {
    primary <- "#111111"
    subtle <- "#CCCCCC"
    behind <- "#FCFCFC"
  }

  if(palette == "kunoichi") {
    primary <- "#FFFFFF"
    subtle <- "#562457"
    behind <- "#BA68C8"
  }

  theme_grey(...) %+replace%
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = behind, colour = behind),
      panel.background = ggplot2::element_rect(fill = subtle, colour = subtle),
      legend.background = ggplot2::element_rect(fill = behind, colour = behind),
      plot.title = ggplot2::element_text(colour = primary),
      plot.subtitle = ggplot2::element_text(colour = primary),
      axis.title = ggplot2::element_text(colour = primary),
      axis.text = ggplot2::element_text(colour = primary),
      legend.title = ggplot2::element_text(colour = primary),
      legend.text = ggplot2::element_text(colour = primary)
    )
}
