# to run unit tests, we need functions to be able to execute even though the
# slumdown package is not a blogdown project.
# possible approach: include key files in inst, and weaken the "check slumdown"
# condition?

test_that("palettes use the correct names", {
#   expect_named(slum_getpalette("dark"), c("pagecolour","maintext", "faded", "highlight", "lowlight"))
})
