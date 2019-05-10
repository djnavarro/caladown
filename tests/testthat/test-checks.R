test_that("multiplication works", {
  expect_equal(2 * 2, 4)
})

test_that("slumdown only works in an appropriate project", {
  expect_warning(check_slumdown(), "a slumdown blog")
})
