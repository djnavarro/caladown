#' Create a hugodown slum site
#'
#' @description
#' Create site with hugodown
#'
#' @param path Path to create site
#' @param open Open new site after creation?
#' @param rstudio Create RStudio project?
#' @export
create_hugodown_slum <- function(
  path = ".",
  open = rlang::is_interactive(),
  rstudio = rstudioapi::isAvailable()) {

  # Use most recent version that release was tested with
  hugodown:::hugo_locate("0.66.0")

  fs::dir_create(path)
  usethis::ui_silence(old <- usethis::proj_set(path, force = TRUE))
  on.exit(usethis::ui_silence(usethis::proj_set(old)))

  usethis::use_rstudio()
  usethis::ui_done("Downloading slum theme")
  zip <- curl::curl_download(
    "https://github.com/djnavarro/hugo-slum/archive/hugodown.zip",
    fs::file_temp("hugodown")
  )
  exdir <- fs::file_temp("hugodown")
  utils::unzip(zip, exdir = exdir)
  exdir <- fs::path(exdir, "hugo-slum-hugodown") # update when hugodown branch is merged

  usethis::ui_done("Copying site components")
  dir_copy_contents(fs::path(exdir, "exampleSite"), path)

  usethis::ui_done("Installing slum theme")
  theme_path <- fs::dir_create(fs::path(path, "themes", "slum"))
  dir_copy_contents(exdir, theme_path)
  fs::dir_delete(fs::path(theme_path, "exampleSite"))

  # write the hugodown yaml file
  slum_write_hugodown(path)

  # Create Rmd post archetype
  # Must modify template because site archetype is _unioned_ with template
  post_archetype <- fs::path(path, "themes", "slum", "archetypes")
  fs::file_move(fs::path(post_archetype, "default.md"), fs::path(post_archetype, "default.Rmd"))
  slum_patch_post_archetype(fs::path(post_archetype, "default.Rmd"))

  # Patch <head>
  slum_write_custom_head(path)

  slum_patch_config(path)


  # The slum example site has .Rmd posts to patch
  usethis::ui_done("Patching example site")
  rmd_posts <- fs::dir_ls(fs::path(path, "content"), glob = "*.Rmd", recurse = TRUE)
  lapply(rmd_posts, slum_patch_post_archetype)

  usethis::use_git_ignore(c("resources", "public"))
  #  file_copy(path_package("hugodown", "academic", "README.md"), path) # slum doesn't have one :|

  # build the tutorial posts
  usethis::ui_done("Building site")
  lapply(hugodown::site_outdated(site = path), function(x) invisible(suppressMessages(suppressWarnings(rmarkdown::render(x,quiet = TRUE)))))

  # Can we open config files for editing in new session? Or should we have
  # edit_config()
  if (open) {
    usethis::proj_activate(path)
  }
}


# probably not the optimal way to do this given that the slum archetype is so small
slum_patch_post_archetype <- function(path) {
  lines <- brio::read_lines(path)
  lines <- c(lines[1],
             "output: hugodown::md_document",
             lines[-1]
  )

  brio::write_lines(lines, path)
}


slum_write_hugodown <- function(path) {
  opts <- list(
    hugo_version = "0.66.0"
  )
  yaml::write_yaml(opts, fs::path(path, "_hugodown.yaml"))
}



slum_write_custom_head <- function(path) {

  fs::dir_create(fs::path(path, "static", "css"))
  fs::file_copy(fs::path_package("slumdown", "slum", "highlight.css"), fs::path(path, "static", "css"))

  head <- fs::path(path, "layouts", "partials", "head_custom.html")
  fs::dir_create(fs::path_dir(head))

  lines <- brio::read_lines(head)

  # append to existing
  brio::write_lines(c(
    lines,
    "",
    "<link rel='stylesheet' href='{{ \"css/highlight.css\" | relURL }}' title='hl-light'>",
    "{{ range .Params.html_dependencies }}",
    "  {{ . | safeHTML }}",
    "{{ end }}"
  ), head)
}


slum_patch_config <- function(path) {

  config <- fs::path(path, "config.toml")
  lines <- brio::read_lines(config)

  # append to existing
  brio::write_lines(c(
    lines,
    '',
    '# needed for hugodown',
    '[markup]',
    '  defaultMarkdownHandler = "goldmark"',
    '  [markup.goldmark]',
    '    [markup.goldmark.renderer]',
    '      unsafe = true  # Enable user to embed HTML snippets in Markdown content.',
    '  [markup.highlight]',
    '    codeFences = true',
    '  [markup.tableOfContents]',
    '    startLevel = 2',
    '    endLevel = 3',
    ''
  ), config)


}







dir_copy_contents <- function(path, new_path) {
  for (path in fs::dir_ls(path)) {
    if (fs::is_file(path)) {
      fs::file_copy(path, fs::path(new_path, fs::path_file(path)))
    } else {
      fs::dir_copy(path, fs::path(new_path, fs::path_file(path)))
    }
  }
}







