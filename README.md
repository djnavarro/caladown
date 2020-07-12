The slumdown package
================
Danielle Navarro
11 Jul 2020

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/djnavarro/slumdown.svg?branch=master)](https://travis-ci.org/djnavarro/slumdown)
[![Codecov test
coverage](https://codecov.io/gh/djnavarro/slumdown/branch/master/graph/badge.svg)](https://codecov.io/gh/djnavarro/slumdown?branch=master)
![Lifecycle
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)
[![CRAN
status](https://www.r-pkg.org/badges/version/slumdown)](https://cran.r-project.org/package=slumdown)
<!-- badges: end -->

<!--<img src="README_files/slumdown.png" width="30%" align="right" />-->

The goal of slumdown is to allow R users to create lightweight websites
powered by Hugo and is designed to be compatible with both
[hugodown](https://hugodown.r-lib.org/) and
[blogdown](https://bookdown.org/yihui/blogdown/), and allows users to
generate graphics that match the visual style of the site via the
[thematic](https://rstudio.github.io/thematic/) package. You can see an
example site at:

<https://djnavarro.github.io/hugo-slum/>

There are two components to slumdown, a [Hugo
theme](https://github.com/djnavarro/hugo-slum) and an [R
package](https://github.com/djnavarro/slumdown). The simplest way to get
started is simply to download the R package from GitHub using the
following command:

``` r
remotes::install_github("djnavarro/slumdown")
```

Hugodown and blogdown are structured differently, so you must choose
which system you wish to use at the outset. If you want to use blogdown,
you can create a new site as follows:

``` r
slumdown::create_blogdown_slum("path_to_blog_folder")
```

For hugodown, the command is:

``` r
slumdown::create_hugodown_slum("path_to_blog_folder")
```

At present these are the only two functions exported by the slumdown
package (documentation is [here](https://slumdown.djnavarro.net/), but
very minimal at the moment). For more information, it is probably best
to look at the [tutorial](https://djnavarro.github.io/hugo-slum/post/)
section of the example site.
