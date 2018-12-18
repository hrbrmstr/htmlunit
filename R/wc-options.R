#' Block HtlUnit final rendering blocks until all background JavaScript tasks have finished executing
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param js_delay a `webclient` object
#' @param wait number of ms to wait/block
#' @family wc_opts
#' @export
wc_wait <- function(wc_obj, js_delay = 2000L) {

  res <- wc_obj$wc$waitForBackgroundJavaScriptStartingBefore(.jlong(as.integer(js_delay)))

  invisible(wc_obj)

}

#' Enable/Disable CSS support
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param enable if `TRUE` enable CSS support (which is the HtmlUnit default)
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_css <- function(wc_obj, enable) {

  wc_obj$wc_opts$setCssEnabled(enable)

  invisible(wc_obj)

}

#' Enable/Disable Do-Not-Track
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param enable if `TRUE` enable Do-Not-Track support (which is the HtmlUnit default)
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_dnt <- function(wc_obj, enable) {

  wc_obj$wc_opts$setDoNotTrackEnabled(enable)

  invisible(wc_obj)

}

#' Enable/Disable Image Downloading
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param enable if `TRUE` enable image downloading (which is the HtmlUnit default)
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_img_dl <- function(wc_obj, enable) {

  wc_obj$wc_opts$setDownloadImages(enable)

  invisible(wc_obj)

}

#' Enable/Disable Geolocation
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param enable if `TRUE` enable geolocation (which is the HtmlUnit default)
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_geo <- function(wc_obj, enable) {

  wc_obj$wc_opts$setGeolocationEnabled(enable)

  invisible(wc_obj)

}

#' Change default request timeout
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param timneout timeout (ms); The timeout is used twice. The first is for making
#'        the socket connection, the second is for data retrieval. If the
#'        time is critical you must allow for twice the time specified here.
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_timeout <- function(wc_obj, timeout) {

  wc_obj$wc_opts$setTimeout(timeout)

  invisible(wc_obj)

}

#' Resize the virtual browser window
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param h,w height and width (pixels)
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_resize <- function(wc_obj, h, w) {

  wc_obj$wc_opts$setScreenHeight(h)
  wc_obj$wc_opts$setScreenWidth(w)

  invisible(wc_obj)

}

#' Enable/Disable Ignoring SSL Validation Issues
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param enable if `TRUE` the client will accept connections to any host,
#'        regardless of whether they have valid certificates or not
#' @return the `webclient` object (invisibly)
#' @family wc_opts
#' @export
wc_use_insecure_ssl <- function(wc_obj, enable) {

  wc_obj$wc_opts$setUseInsecureSSL(enable)

  invisible(wc_obj)

}
