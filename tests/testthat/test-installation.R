
test_that("slumdown only works in an appropriate project", {
  expect_warning(check_slumdown(), "a slumdown blog")
})
