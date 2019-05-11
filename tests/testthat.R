library(testthat)
library(slumdown)

# temporary directories used by the installation tests
tmp <- tempdir()
dir_loc <- file.path(tmp, "slum_loc")
dir_rem <- file.path(tmp, "slum_rem")
dir_new <- file.path(tmp, "slum_new")

# temporary directories used by other tests
dir_null <- file.path(tmp, "slum_null")
dir_slum <- file.path(tmp, "slum_slum")

# create directories and *try* to make one a slum
dir.create(dir_null)
try(build_slum_locally(dir_slum), silent=TRUE)
if(!dir.exists(dir_slum)) dir.create(dir_slum)

test_check("slumdown")
