# Note to self - remember, tests are run in their own *environments* but that
# does not prevent side effects. Files created by a test are not deleted


# temporary directories
tmp <- tempdir()
dir_loc <- file.path(tmp, "slum_loc")
dir_rem <- file.path(tmp, "slum_rem")
dir_new <- file.path(tmp, "slum_new")


# weak test of local installation
test_that("local installation produces files", {

  build_slum_locally(dir_loc)
  fl <- list.files(dir_loc, recursive = TRUE)

  expect_true(length(fl)>0)

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

# handy way to play test interactively: NEVER AUTOMATE
if(FALSE) {
  desk_loc <- "~/../Desktop/slum_loc"
  slumdown::build_slum_locally(desk_loc)
  f_loc <- list.files(desk_loc, recursive = TRUE)

  desk_rem <- "~/../Desktop/slum_rem"
  slumdown::build_slum_remotely(desk_rem)
  f_rem <- list.files(desk_rem, recursive = TRUE)

  setdiff(f_loc, f_rem)
  setdiff(f_rem, f_loc)
}


test_that("nojekyll file created when requested", {

  # initially we expect there to be no such file
  jekyll_file <- file.path(dir_loc, "static", ".nojekyll")
  expect_false(file.exists(jekyll_file))

  # should appear when requested
  build_slum_nojekyll(dir_loc)
  expect_true(file.exists(jekyll_file))

})


#' @importFrom methods is
test_that("project file created when requested", {

  # skip this test in some contexts
  skip_on_cran()

  # in rstudio it should build a project, in
  # other contexts it should throw an error
  rstudio_check <- try(check_for_rstudio(), silent = TRUE)
  if(is(rstudio_check, "try-error")) {

    # NOTE: it would be better to include regex here
    expect_error(build_slum_project(dir_loc))

  } else {

    # possible files that might be created
    here_file <- file.path(dir_loc, ".here")
    proj_file <- file.path(dir_loc, "slum_loc")

    # neither should exist initially
    expect_false(file.exists(here_file))
    expect_false(file.exists(proj_file))

    # attempt to add the project file
    build_slum_project(dir_loc)

    # an rproj file should exist but not a here file
    expect_false(file.exists(here_file))
    expect_true(file.exists(proj_file))

  }

})


# a little redundant, but a handy integration test
test_that("new_slum creates a theme", {

  rstudio_check <- try(check_for_rstudio(), silent = TRUE)
  if(!is(rstudio_check, "try-error")) {
    new_slum(dir_new, remote = FALSE, project = "rstudio", nojekyll = TRUE)
    dir_theme <- file.path(dir_new, "themes", "hugo-slum")
    expect_true(dir.exists(dir_theme))
  }

})
