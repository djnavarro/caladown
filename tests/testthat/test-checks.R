
wd <- getwd()

test_that("package detects slumdown projects", {

  # throw warning if not a slumdown project?
  setwd(dir_null)
  expect_warning(check_for_slumdown(), "Cannot find the hugo-slum theme")

  # return null from project root?
  setwd(dir_slum)
  expect_null(check_for_slumdown())

  # return null from a subdirectory in the project?
  setwd(file.path(dir_slum, "content"))
  expect_null(check_for_slumdown())

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
