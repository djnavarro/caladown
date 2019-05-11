

wd <- getwd()

test_that("package detects slumdown projects", {

  # throw warning if not a slumdown project?
  moveto(dir_null)
  expect_warning(check_for_slumdown(), "Cannot find the hugo-slum theme")
  expect_false(check_for_slumdown())

  # return null from project root?
  moveto(dir_slum)
  expect_true(check_for_slumdown())

  # return null from a subdirectory in the project?
  moveto(file.path(dir_slum, "content"))
  expect_true(check_for_slumdown())

})


test_that("package detects emptiness of directories", {

  # throw error if not empty
  expect_error(check_if_dir_empty(dir_slum), "exists and is not empty")

  # return null if exists and empty
  expect_null(check_if_dir_empty(dir_null))

  # return null does not exist
  expect_null(check_if_dir_empty(dir_fake))

})

setwd(wd)
