test_that("hugodown install works", {

  # install hugo if need be
  hugodown::hugo_install("0.66.0")

  # check that something installs
  path <- tempfile()
  result <- try(create_hugodown_calade(path))
  expect_false(class(result) == "try-error")

  # check top level structure
  top_files <- c("_hugodown.yaml", "config.toml", "content", "index.Rmd",
                 "layouts", "README.md", "static", "themes")
  tmp_files <- list.files(path)
  expect_equal(setdiff(top_files, tmp_files), character(0L))

})
