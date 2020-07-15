The caladown package
================
Danielle Navarro
11 Jul 2020

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/djnavarro/caladown.svg?branch=master)](https://travis-ci.com/djnavarro/caladown)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

<!--<img src="README_files/caladown.png" width="30%" align="right" />-->

The goal of caladown is to allow R users to create lightweight websites
powered by Hugo and is designed to be compatible with both
[hugodown](https://hugodown.r-lib.org/) and
[blogdown](https://bookdown.org/yihui/blogdown/), and allows users to
generate graphics that match the visual style of the site via the
[thematic](https://rstudio.github.io/thematic/) package. You can see an
example site at:

<https://djnavarro.github.io/hugo-calade/>

There are two components to caladown, a [Hugo
theme](https://github.com/djnavarro/hugo-calade) and an [R
package](https://github.com/djnavarro/caladown). The simplest way to get
started is simply to download the R package from GitHub using the
following command:

``` r
remotes::install_github("djnavarro/caladown")
```

Hugodown and blogdown are structured differently, so you must choose
which system you wish to use at the outset. If you want to use blogdown,
you can create a new site as follows:

``` r
caladown::create_blogdown_calade("path_to_blog_folder")
```

For hugodown, the command is:

``` r
caladown::create_hugodown_calade("path_to_blog_folder")
```

At present these are the only two functions exported by the caladown
package (documentation is [here](https://caladown.djnavarro.net/), but
very minimal at the moment). For more information, it is probably best
to look at the [tutorial](https://djnavarro.github.io/hugo-calade/post/)
section of the example site.
