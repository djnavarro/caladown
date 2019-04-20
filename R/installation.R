#' Creates new blogdown site with slum theme
#'
#' @param dir Where to create the new blog
#' @param ... Arguments to be passed to blogdown::new_site
#' @details This is just a wrapper to blogdown::new_site
#' @importFrom blogdown new_site
#' @export
new_site <- function(dir = ".", ...) {
  blogdown::new_site(
    ...,
    theme = "djnavarro/hugo-slum",
    sample = FALSE
  )
}
