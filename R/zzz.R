stop_logging <- function() {
  rJava::J("java.util.logging.LogManager")$getLogManager()$reset()
  invisible(NULL)
}

.onLoad <- function(libname, pkgname) {
  rJava::.jpackage(pkgname, jars = "*", lib.loc = libname)
  rJava::.jaddClassPath(dir(file.path(getwd(), "inst/java"), full.names = TRUE))
  stop_logging()
}


