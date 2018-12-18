#' Create a new HtmlUnit WebClient instance
#'
#' A new HtmlUnit web client (virtual browser) will be created and a `webclient`
#' object will be returned.
#'
#' This is part of the `htmlunit` DSL interface.s
#'
#' @param emulate browser to emulate; one of "`best`", "`chrome`", "`firefox`", "`ie`"
#' @param proxy_host,proxy_port the server/port that will act as proxy (default
#'        `NULL` = no proxy)
#' @return `webclient` object
#' @family dsl
#' @export
web_client <- function(emulate = c("best", "chrome", "firefox", "ie"),
                       proxy_host = NULL, proxy_port = NULL) {

  emulate <- match.arg(emulate, c("best", "chrome", "firefox", "ie"))
  available_browsers <- J("com.gargoylesoftware.htmlunit.BrowserVersion")

  switch(
    emulate,
    best = available_browsers$BEST_SUPPORTED,
    chrome = available_browsers$CHROME,
    firefox = available_browsers$FIREFOX_60,
    ie = available_browsers$INTERNET_EXPLORER
  ) -> use_browser

  wc <- new(J("com.gargoylesoftware.htmlunit.WebClient"), use_browser)
  wc_opts <- wc$getOptions()
  wc_opts$setThrowExceptionOnFailingStatusCode(FALSE)
  wc_opts$setThrowExceptionOnScriptError(FALSE)
  wc_opts$setDownloadImages(FALSE)

  list(
    wc = wc,
    wc_opts = wc_opts
  ) -> wc_obj

  class(wc_obj) <- c("webclient")

  invisible(wc_obj)

}

#' @rdname web_client
#' @export
webclient <- web_client

#' Visit a URL
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param url URL to retrieve
#' @return the `webclient` object (invisibly)
#' @export
wc_go <- function(wc_obj, url) {

  wc_obj$wc$getPage(url)

  invisible(wc_obj)

}

#' Retreive information about the browser used to create the `webclient`
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the browser version
#' @export
wc_browser_info <- function(wc_obj) {

  bv <- wc_obj$wc$getBrowserVersion()

  list(
    name = bv$getApplicationName(),
    version = bv$getApplicationVersion(),
    language = bv$getBrowserLanguage()
  ) -> bv_lst

  class(bv_lst) <- "browserinfo"

  bv_lst

}

#' Print method for `browserinfo` objects
#' @keywords internal
#' @param x `browserinfo` object
#' @param ... unused
#' @export
print.browserinfo <- function(x, ...) {

  cat(
    sprintf("< %s / %s / %s >\n", x$name, x$version, x$language)
  )

}


# Closes all virtual browser opened windows & stop all background JavaScript processing
#
# @param wc_obj a `webclient` object
# @return the `webclient` object (invisibly)
# @export
# wc_go <- function(wc_obj, url) {
#
#   wc_obj$wc$getPage(url)
#
#   invisible(wc_obj)
#
# }


#' Print method for `webclient` objects
#' @keywords internal
#' @param x `webclient` object
#' @param ... unused
#' @export
print.webclient <- function(x, ...) {

  cat("<webclient>\n")

}
