# Note to self - remember, tests are run in their own *environments* but that
# does not prevent side effects. Files created by a test are not deleted

# temporary directories
tmp <- tempdir()
dir_loc <- file.path(tmp, "slum_loc")
dir_rem <- file.path(tmp, "slum_rem")
dir_new <- file.path(tmp, "slum_new")


# very weak test of local installation
test_that("local installation has 153 files", {

  build_slum_locally(dir_loc)
  fl <- list.files(dir_loc, recursive = TRUE)
  expect_length(fl, 153)

})



# a better test, requiring the local installation to produce
# the exact same set of files as the remote installation using
# blogdown::new_site()
test_that("remote and local installations are identical", {

  # on travis the remote install throws an error:
  # /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.20' not found
  # /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.21' not found
  skip_on_travis()

  # also skip if we are offline or on CRAN (lol, this is never going to CRAN)
  skip_if_offline()
  skip_on_cran()

  # build a local version and from the remote source
  build_slum_locally(dir_loc)
  build_slum_remotely(dir_rem)

  # list all the files
  fl <- list.files(dir_loc, recursive = TRUE)
  fr <- list.files(dir_rem, recursive = TRUE)

  # are they the same?
  expect_equal(fl, fr)
})


test_that("nojekyll file created when requested", {

  # initially we expect there to be no such file
  jekyll_file <- file.path(dir_loc, "static", ".nojekyll")
  expect_false(file.exists(jekyll_file))

  # should appear when requested
  build_slum_nojekyll(dir_loc)
  expect_true(file.exists(jekyll_file))

})


test_that("project file created when requested", {

  # possible files that might be created
  here_file <- file.path(dir_loc, ".here")
  proj_file <- file.path(dir_loc, "slum_loc")

  # neither should exist initially
  expect_false(file.exists(here_file))
  expect_false(file.exists(proj_file))

  # one of the two should appear when requested
  build_slum_project(dir_loc)
  expect_true( file.exists(here_file) || file.exists(proj_file) )

})


# a little redundant, but a handy little integration test
test_that("new_slum creates a theme", {

  new_slum(dir_new)
  dir_theme <- file.path(dir_new, "themes", "hugo-slum")
  expect_true(dir.exists(dir_theme))

})
