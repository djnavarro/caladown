---
output: hugodown::md_document
title: "Tutorial part 3: Deploying the site"
author: "Danielle Navarro"
date: "2020-06-07"
slug: deploying-the-site
tags: "tutorial"
summary: "The usual advice for deploying a blogdown or hugodown site is to deploy to Netlify rather than GitHub Pages, because there are a few peculiarities to GitHub Pages that can make it difficult. The third part of the tutorial walks you through both versions."
header:
  caption: "A caption"
  image: 'header/banner.png'
  profile: 'header/profile.png'
rmd_hash: 916644faba413bf3

---

The usual advice for deploying a blogdown or hugodown site is to deploy to Netlify rather than GitHub Pages, because there are a few peculiarities to GitHub Pages that can make it difficult. The third part of the tutorial walks you through both versions, or to be more precise, it will walk you through both versions once I familiarise myself with Netlify and various other things. For the moment, only the GitHub Pages version is documented here.

Deploying a hugodown site to GitHub Pages
-----------------------------------------

The way I set up all my static websites is through [GitHub Pages](https://pages.github.com/). If you have created your site using hugodown, the first thing you need to do is to have Hugo build a copy of your site in the `docs` folder. Hugodown makes this easy to do:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>hugodown</span>::<span class='nf'><a href='https://rdrr.io/pkg/hugodown/man/hugo_build.html'>hugo_build</a></span>(dest = <span class='s'>"docs"</span>)</code></pre>

</div>

Once you have done this, you are ready to deploy. If you haven't already done so, initialise a git repository in your project and then push it to GitHub. The laziest way I know of to do this is with the following R commands:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>usethis</span>::<span class='nf'><a href='https://usethis.r-lib.org/reference/use_git.html'>use_git</a></span>()
<span class='k'>usethis</span>::<span class='nf'><a href='https://usethis.r-lib.org/reference/use_github.html'>use_github</a></span>()</code></pre>

</div>

On GitHub, go to the "Settings" tab and scroll down to the section entitled "GitHub Pages". There should be a drop down menu underneath the subheading "Source". Click on it and select "master branch /docs folder". The site should now deploy.

Deploying a hugodown site to Netlify
------------------------------------

To be added later :-)

Deploying a blogdown site to GitHub
-----------------------------------

To be added later :-)

Deploying a blogdown site to Netlify
------------------------------------

To be added later :-)

