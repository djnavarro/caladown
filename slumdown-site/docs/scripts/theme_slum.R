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
    theme(
      plot.background = element_rect(fill = behind, colour = behind),
      panel.background = element_rect(fill = subtle, colour = subtle),
      legend.background = element_rect(fill = behind, colour = behind),
      plot.title = element_text(colour = primary),
      plot.subtitle = element_text(colour = primary),
      axis.title = element_text(colour = primary),
      axis.text = element_text(colour = primary),
      legend.title = element_text(colour = primary),
      legend.text = element_text(colour = primary)
    )
}
