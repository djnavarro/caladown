---
output: hugodown::md_document
title: "A project of one's own"
author: "Danielle Navarro"
date: "1929-09-01"
slug: of-ones-own
tags: "art"
summary: "An example of a project page, creating a simple generative art system in R. There is more code on this page than elsewhere on the example site, which may be useful if you want to see what the syntax highlighting looks like for slumdown sites."
header:
  caption: "A caption"
  image: 'header/banner.png'
  profile: 'header/profile.png'
rmd_hash: 33498515f7fe042b

---

Projects are no different to blog posts in slumdown. They're formatted the same way, generated the same way, and so on. The only difference is that they're indexed separately. This is sometimes useful for separating casual blog posts from more substantive projects.

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='nf'><a href='https://rdrr.io/r/base/library.html'>library</a></span>(<span class='k'><a href='https://github.com/thomasp85/scico'>scico</a></span>)
<span class='nf'><a href='https://rdrr.io/r/base/library.html'>library</a></span>(<span class='k'><a href='https://tibble.tidyverse.org'>tibble</a></span>)
<span class='nf'><a href='https://rdrr.io/r/base/library.html'>library</a></span>(<span class='k'><a href='https://dplyr.tidyverse.org'>dplyr</a></span>)
<span class='nf'><a href='https://rdrr.io/r/base/library.html'>library</a></span>(<span class='k'><a href='http://ggplot2.tidyverse.org'>ggplot2</a></span>)</code></pre>

</div>

In this post I'll create a simple generative art system, one that is loosely based on computational model that I use in my everyday research. The main purpose for including it here, however, is to illustrate what the syntax highlighting looks like using the current CSS settings. At the moment it is a little crude, but I'll aim to refine this. Note that this may look different depending on whether the site is generated in hugodown or blogdown!

To get started, I'll define a function that return parameters specifying the art:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>parameters</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>(<span class='k'>seed</span>, <span class='k'>samples</span> = <span class='m'>100000</span>, <span class='k'>plot_range</span> = <span class='m'>7.5</span>,
                       <span class='k'>train_range</span> = <span class='m'>2</span>, <span class='k'>train_size</span> = <span class='m'>3</span>) {
  <span class='nf'><a href='https://rdrr.io/r/base/list.html'>list</a></span>(
    seed = <span class='k'>seed</span>,
    samples = <span class='k'>samples</span>,
    plot_range = <span class='k'>plot_range</span>,
    train_range = <span class='k'>train_range</span>,
    train_size = <span class='k'>train_size</span>
  )
}</code></pre>

</div>

The next step is to generate the data to be visualised. In this case the data correspond to a set of rectangles that (in the original cognitive science context) would correspond to a collection of possible hypotheses about the extension of a novel category in a two dimensional stimulus space. Rectangles will be shaded on the basis of their size. To that end I'll define a `generator()` function:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>generator</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>(<span class='k'>params</span>) {
  
  <span class='nf'><a href='https://rdrr.io/r/base/Random.html'>set.seed</a></span>(<span class='k'>params</span><span class='o'>$</span><span class='k'>seed</span>)
  
  <span class='k'>train</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/with.html'>with</a></span>(<span class='k'>params</span>, <span class='nf'><a href='https://tibble.tidyverse.org/reference/tibble.html'>tibble</a></span>(
    x = <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span>(<span class='k'>train_size</span>, min = <span class='o'>-</span><span class='k'>train_size</span><span class='o'>/</span><span class='m'>2</span>, max = <span class='k'>train_size</span><span class='o'>/</span><span class='m'>2</span>),
    y = <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span>(<span class='k'>train_size</span>, min = <span class='o'>-</span><span class='k'>train_size</span><span class='o'>/</span><span class='m'>2</span>, max = <span class='k'>train_size</span><span class='o'>/</span><span class='m'>2</span>)
  ))
  
  <span class='k'>train_with</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>(<span class='k'>hypotheses</span>, <span class='k'>train</span>) {
    <span class='k'>n</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/nrow.html'>nrow</a></span>(<span class='k'>train</span>)
    <span class='kr'>for</span>(<span class='k'>i</span> <span class='kr'>in</span> <span class='m'>1</span><span class='o'>:</span><span class='k'>n</span>) {
      <span class='k'>hypotheses</span> <span class='o'>&lt;-</span> <span class='k'>hypotheses</span> <span class='o'>%&gt;%</span> 
        <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span>(
          <span class='k'>x_min</span> <span class='o'>&lt;</span> <span class='k'>train</span><span class='o'>$</span><span class='k'>x</span>[<span class='k'>i</span>], <span class='k'>x_max</span> <span class='o'>&gt;</span> <span class='k'>train</span><span class='o'>$</span><span class='k'>x</span>[<span class='k'>i</span>], 
          <span class='k'>y_min</span> <span class='o'>&lt;</span> <span class='k'>train</span><span class='o'>$</span><span class='k'>y</span>[<span class='k'>i</span>], <span class='k'>y_max</span> <span class='o'>&gt;</span> <span class='k'>train</span><span class='o'>$</span><span class='k'>y</span>[<span class='k'>i</span>]
        )
    }
    <span class='nf'><a href='https://rdrr.io/r/base/function.html'>return</a></span>(<span class='k'>hypotheses</span>)
  }
  
  <span class='k'>hypotheses</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/with.html'>with</a></span>(<span class='k'>params</span>, <span class='nf'><a href='https://tibble.tidyverse.org/reference/tibble.html'>tibble</a></span>(
    mid_x = <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span>(<span class='k'>samples</span>, min = <span class='o'>-</span><span class='k'>plot_range</span>, max = <span class='k'>plot_range</span>), 
    mid_y = <span class='nf'><a href='https://rdrr.io/r/stats/Uniform.html'>runif</a></span>(<span class='k'>samples</span>, min = <span class='o'>-</span><span class='k'>plot_range</span>, max = <span class='k'>plot_range</span>),
    len_x = <span class='nf'><a href='https://rdrr.io/r/stats/GammaDist.html'>rgamma</a></span>(<span class='k'>samples</span>, rate = <span class='m'>.5</span>, shape = <span class='m'>1</span>),
    len_y = <span class='nf'><a href='https://rdrr.io/r/stats/GammaDist.html'>rgamma</a></span>(<span class='k'>samples</span>, rate = <span class='m'>.5</span>, shape = <span class='m'>1</span>)
  )) <span class='o'>%&gt;%</span>
    <span class='nf'><a href='https://dplyr.tidyverse.org/reference/mutate.html'>mutate</a></span>(
      x_min = <span class='k'>mid_x</span> <span class='o'>-</span> <span class='k'>len_x</span> <span class='o'>/</span> <span class='m'>2</span>, 
      x_max = <span class='k'>mid_x</span> <span class='o'>+</span> <span class='k'>len_x</span> <span class='o'>/</span> <span class='m'>2</span>,
      y_min = <span class='k'>mid_y</span> <span class='o'>-</span> <span class='k'>len_y</span> <span class='o'>/</span> <span class='m'>2</span>,
      y_max = <span class='k'>mid_y</span> <span class='o'>+</span> <span class='k'>len_y</span> <span class='o'>/</span> <span class='m'>2</span>
    ) <span class='o'>%&gt;%</span>
    <span class='nf'>train_with</span>(<span class='k'>train</span>) <span class='o'>%&gt;%</span>
    <span class='nf'><a href='https://dplyr.tidyverse.org/reference/filter.html'>filter</a></span>( 
      <span class='k'>x_min</span> <span class='o'>&gt;</span> <span class='o'>-</span><span class='k'>params</span><span class='o'>$</span><span class='k'>plot_range</span>, 
      <span class='k'>x_max</span> <span class='o'>&lt;</span>  <span class='k'>params</span><span class='o'>$</span><span class='k'>plot_range</span>,
      <span class='k'>y_min</span> <span class='o'>&gt;</span> <span class='o'>-</span><span class='k'>params</span><span class='o'>$</span><span class='k'>plot_range</span>, 
      <span class='k'>y_max</span> <span class='o'>&lt;</span>  <span class='k'>params</span><span class='o'>$</span><span class='k'>plot_range</span>
    )
  <span class='nf'><a href='https://rdrr.io/r/base/function.html'>return</a></span>(<span class='k'>hypotheses</span>)
}</code></pre>

</div>

Now that we have a function that generates the data we need a function that will make a pretty plot from the data. This can be done in many ways, but I like ggplot2 so I'll use that:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>plotter</span> <span class='o'>&lt;-</span> <span class='nf'>function</span>(<span class='k'>hypotheses</span>) {
  
  <span class='k'>pal</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/sample.html'>sample</a></span>(<span class='nf'><a href='https://rdrr.io/pkg/scico/man/scico_data.html'>scico_palette_names</a></span>(), <span class='m'>1</span>)
  <span class='k'>bg</span> <span class='o'>&lt;-</span> <span class='s'>"#333333"</span>;
  <span class='k'>r</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://rdrr.io/r/base/Extremes.html'>max</a></span>(
    <span class='k'>hypotheses</span><span class='o'>$</span><span class='k'>y_max</span>,
    <span class='k'>hypotheses</span><span class='o'>$</span><span class='k'>x_max</span>, 
    <span class='o'>-</span><span class='k'>hypotheses</span><span class='o'>$</span><span class='k'>y_min</span>,
    <span class='o'>-</span><span class='k'>hypotheses</span><span class='o'>$</span><span class='k'>x_min</span>
  )
  
  <span class='k'>picture</span> <span class='o'>&lt;-</span> <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggplot.html'>ggplot</a></span>(
    data = <span class='k'>hypotheses</span>, 
    mapping = <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span>(xmin = <span class='k'>x_min</span>, ymin = <span class='k'>y_min</span>, 
                  xmax = <span class='k'>x_max</span>, ymax = <span class='k'>y_max</span>)
  ) <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_tile.html'>geom_rect</a></span>(<span class='nf'><a href='https://ggplot2.tidyverse.org/reference/aes.html'>aes</a></span>(fill = <span class='k'>len_x</span> <span class='o'>+</span> <span class='k'>len_y</span>), 
              alpha = <span class='m'>.15</span>, color = <span class='s'>"white"</span>, 
              size = <span class='m'>.1</span>, show.legend = <span class='kc'>FALSE</span>) <span class='o'>+</span> 
    
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/geom_tile.html'>geom_rect</a></span>(fill = <span class='m'>NA</span>, color = <span class='nf'><a href='https://rdrr.io/r/base/paste.html'>paste0</a></span>(<span class='k'>bg</span>, <span class='s'>"22"</span>), 
              size = <span class='m'>.1</span>, show.legend = <span class='kc'>FALSE</span>) <span class='o'>+</span> 
    
    <span class='c'># stylistic</span>
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/ggtheme.html'>theme_void</a></span>() <span class='o'>+</span>
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/theme.html'>theme</a></span>(plot.background = <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/element.html'>element_rect</a></span>(fill = <span class='k'>bg</span>, colour = <span class='k'>bg</span>)) <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/scale_continuous.html'>scale_x_continuous</a></span>(<span class='kr'>NULL</span>, labels = <span class='kr'>NULL</span>, limits = <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span>(<span class='o'>-</span><span class='k'>r</span>, <span class='k'>r</span>)) <span class='o'>+</span> 
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/scale_continuous.html'>scale_y_continuous</a></span>(<span class='kr'>NULL</span>, labels = <span class='kr'>NULL</span>, limits = <span class='nf'><a href='https://rdrr.io/r/base/c.html'>c</a></span>(<span class='o'>-</span><span class='k'>r</span>, <span class='k'>r</span>)) <span class='o'>+</span> 
    <span class='k'>scico</span>::<span class='nf'><a href='https://rdrr.io/pkg/scico/man/ggplot2-scales.html'>scale_fill_scico</a></span>(palette = <span class='k'>pal</span>) <span class='o'>+</span>
    <span class='nf'><a href='https://ggplot2.tidyverse.org/reference/coord_fixed.html'>coord_equal</a></span>() 
  
  <span class='nf'><a href='https://rdrr.io/r/base/function.html'>return</a></span>(<span class='k'>picture</span>)
}</code></pre>

</div>

Here are a few images generated from this system, varying only the `seed` parameter:

<div class="highlight">

<pre class='chroma'><code class='language-r' data-lang='r'><span class='k'>thematic</span>::<span class='nf'><a href='https://rdrr.io/pkg/thematic/man/thematic.html'>thematic_on</a></span>(bg = <span class='s'>"#333333"</span>)
<span class='m'>1</span> <span class='o'>%&gt;%</span> <span class='nf'>parameters</span>() <span class='o'>%&gt;%</span> <span class='nf'>generator</span>() <span class='o'>%&gt;%</span> <span class='nf'>plotter</span>()
</code></pre>
<img src="figs/unnamed-chunk-5-1.png" width="700px" style="display: block; margin: auto;" />
<pre class='chroma'><code class='language-r' data-lang='r'><span class='m'>2</span> <span class='o'>%&gt;%</span> <span class='nf'>parameters</span>() <span class='o'>%&gt;%</span> <span class='nf'>generator</span>() <span class='o'>%&gt;%</span> <span class='nf'>plotter</span>()
</code></pre>
<img src="figs/unnamed-chunk-5-2.png" width="700px" style="display: block; margin: auto;" />
<pre class='chroma'><code class='language-r' data-lang='r'><span class='m'>3</span> <span class='o'>%&gt;%</span> <span class='nf'>parameters</span>() <span class='o'>%&gt;%</span> <span class='nf'>generator</span>() <span class='o'>%&gt;%</span> <span class='nf'>plotter</span>()
</code></pre>
<img src="figs/unnamed-chunk-5-3.png" width="700px" style="display: block; margin: auto;" />
<pre class='chroma'><code class='language-r' data-lang='r'><span class='m'>4</span> <span class='o'>%&gt;%</span> <span class='nf'>parameters</span>() <span class='o'>%&gt;%</span> <span class='nf'>generator</span>() <span class='o'>%&gt;%</span> <span class='nf'>plotter</span>()
</code></pre>
<img src="figs/unnamed-chunk-5-4.png" width="700px" style="display: block; margin: auto;" />
<pre class='chroma'><code class='language-r' data-lang='r'><span class='m'>5</span> <span class='o'>%&gt;%</span> <span class='nf'>parameters</span>() <span class='o'>%&gt;%</span> <span class='nf'>generator</span>() <span class='o'>%&gt;%</span> <span class='nf'>plotter</span>()
</code></pre>
<img src="figs/unnamed-chunk-5-5.png" width="700px" style="display: block; margin: auto;" />

</div>

