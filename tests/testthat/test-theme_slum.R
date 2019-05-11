wd <- getwd()

test_that("theme_slum returns a theme", {

  moveto(dir_null)
  expect_equal(theme_slum("light"), ggplot2::theme_grey())

  moveto(dir_slum)
  expect_equal(theme_slum("fakeslum"), ggplot2::theme_grey())
  expect_equal(class(theme_slum("light")), class(ggplot2::theme_grey()))

})

setwd(wd)
