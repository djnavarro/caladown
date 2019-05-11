
wd <- getwd()

test_that("there are two palettes on default install", {

  palettes <- file.path(dir_slum, "themes", "hugo-slum", "static","css",
                        c("palette_dark.css", "palette_light.css"))
  palettes <- normalizePath(palettes)

  moveto(dir_slum)
  expect_equal(normalizePath(slum_palette_paths()), palettes)

  moveto(file.path(dir_slum, "content"))
  expect_equal(normalizePath(slum_palette_paths()), palettes)

  moveto(dir_null)
  expect_equal(slum_palette_paths(), character(0))
  expect_warning(slum_palette_paths(), "Cannot find the hugo-slum theme")

})


test_that("palettes are appropriately formed", {

  moveto(dir_null)
  expect_error(slum_palette("light"), "palette not found")

  moveto(dir_slum)
  expect_error(slum_palette("not-a-real-palette"), "palette not found")
  expect_named(
    slum_palette("light"),
    c("pagecolour", "maintext", "faded", "highlight", "lowlight")
  )

})


setwd(wd)
