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
  pname <- pkgname
  pkg_exists <- eval(paste("require(",pname,")"))
  if (!require(pname)){
    install.packages(pname, dependencies = TRUE)
    require(pname)
  } else {
    require(pname)
  }
}