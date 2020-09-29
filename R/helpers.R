dir_copy_contents <- function(path, new_path) {
  for (path in dir_ls(path)) {
    if (is_file(path)) {
      file_copy(path, path(new_path, path_file(path)))
    } else {
      dir_copy(path, path(new_path, path_file(path)))
    }
  }
}
