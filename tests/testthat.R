library(testthat)
library(slumdown)

# make sure the machine has hugo installed
blogdown::install_hugo()

test_check("slumdown")
