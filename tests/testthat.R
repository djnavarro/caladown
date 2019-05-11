library(testthat)
library(slumdown)

# temporary directories used by the installation tests
tmp <- tempdir()
dir_loc <- file.path(tmp, "slum_loc")
dir_loc2 <- file.path(tmp, "slum_loc2")
dir_rem <- file.path(tmp, "slum_rem")
dir_new <- file.path(tmp, "slum_new")

# temporary directories used by other tests
dir_null <- file.path(tmp, "slum_null")
dir_slum <- file.path(tmp, "slum_slum")
dir_fake <- file.path(tmp, "slum_fake")

# null is an empty directory (vs. fake doesn't exist)
dir.create(dir_null)

# slum is supposed to be a slumdown directory
try(new_slum(dir_slum, project = "here"), silent=TRUE)
if(!dir.exists(dir_slum)) dir.create(dir_slum)


test_check("slumdown")
