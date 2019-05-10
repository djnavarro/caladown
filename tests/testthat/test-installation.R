# this test requires hugo to be present and to be able to
# install stuff from github. it works locally but travis is
# throwing an error:
#
# /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.20' not found
# /usr/lib/x86_64-linux-gnu/libstdc++.so.6: version `GLIBCXX_3.4.21' not found

test_that("remote and local installations are identical", {

  # skip on travis
  skip_on_travis()

  # temporary directories (actually use tempdir please)
  tmp <- tempdir()
  dir_loc <- file.path(tmp, "slum_loc")
  dir_rem <- file.path(tmp, "slum_rem")

  # build a local version and from the remote source
  slumdown::build_slum_locally(dir_loc)
  slumdown::build_slum_remotely(dir_rem)

  # list all the files
  fl <- list.files(dir_loc, recursive = TRUE)
  fr <- list.files(dir_rem, recursive = TRUE)

  # are they the same?
  expect_equal(fl, fr)
})


# this is redundant on the local test, but it's worth
# having *something* I can run on travis
test_that("local installation has 153 files", {

  # temporary directories (actually use tempdir please)
  tmp <- tempdir()
  dir_loc <- file.path(tmp, "slum_loc")

  # build a local version and from the remote source
  slumdown::build_slum_locally(dir_loc)

  # list all the files
  fl <- list.files(dir_loc, recursive = TRUE)

  # are they the same?
  expect_length(fl, 153)
})


