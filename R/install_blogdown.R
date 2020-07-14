#' Create a calade site using blogdown
#'
#' @description
#' Create a calade site using blogdown
#'
#' @param path Path to create site
#' @param open Open new site after creation?
#' @param ... Arguments to pass to blogdown::new_site
#' @export
create_blogdown_calade <- function(
  path = ".",
  open = rlang::is_interactive(),
  ...
) {
  blogdown::new_site(
    dir = path,
    theme = "https://github.com/djnavarro/hugo-calade/archive/master.zip",
    sample = FALSE,
    ...
  )

  if (open) {
    usethis::proj_activate(path)
  }
}
