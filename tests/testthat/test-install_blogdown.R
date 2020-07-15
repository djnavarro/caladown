test_that("blogdown install works", {

  # check that something installs
  path <- tempfile()
  result <- try(create_blogdown_calade(path, serve = FALSE, install_hugo = FALSE))
  expect_false(class(result) == "try-error")

})
