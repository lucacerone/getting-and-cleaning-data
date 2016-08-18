ensure_directory_exists <- function(dname) {
  if (file.exists(dname)) {
    info <- file.info(dname)
    if (!info$isdir) stop("Can not create the directory '",dname, "' because a file exists with the same name.")
    message("Directory '",dname,"' exists.")
  } else {
    dir.create(dname)
    message("Directory '",dname,"' created.")
  }
}

download_data <- function(url, destfile, method , force = FALSE) {
  if (force || !file.exists(destfile)) {
    download.file(url, destfile, method)
  }
}

ensure_package_ <- function(pkgname) {
  if (!suppressWarnings(require(pkgname, quietly = TRUE, character.only = TRUE))){
    install.packages(pkgname, dependencies = TRUE)
    require(pkgname, character.only = TRUE)
  } else {
    require(pkgname, character.only = TRUE)
  }
}

import_features <- function() {
  features <- readr::read_delim("data/UCI HAR Dataset/features.txt", delim=" ", col_names = FALSE)
  unlist(features[,2], use.names = F)
}
