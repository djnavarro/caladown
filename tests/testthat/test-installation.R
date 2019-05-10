# Note to self - remember, tests are run in their own *environments* but that
# does not prevent side effects. Files created by a test are not deleted

# temporary directories
tmp <- tempdir()
dir_loc <- file.path(tmp, "slum_loc")
dir_rem <- file.path(tmp, "slum_rem")


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
