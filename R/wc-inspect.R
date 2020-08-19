#' Perform a "Developer Tools"-like Network Inspection of a URL
#'
#' Retrieves _all_ content loaded
#'
#' @md
#' @param url URL to fetch
#' @param js_delay (ms) How long to wait for JavaScript to execute/XHRs to load? (Default: 5000)
#' @param timeout Sets the timeout (milliseconds) of the web connection. Set to zero for an infinite wait.
#'        Defaults to `30000`. Note: The timeout is used twice. The first is for making the socket
#'        connection, the second is for data retrieval. If the time is critical you must allow for twice
#'        the time specified here.
#' @param css,images enable CSS/download images? (default `FALSE`)
#' @export
wc_inspect <- function(url, js_delay = 5000L, timeout = 30000L, css = FALSE, images = FALSE) {

  app <- J("is.rud.htmlunit.Zapp")

  app$getRequestsFor(
    url,
    .jlong(js_delay),
    as.integer(timeout),
    .jnew("java/lang/Boolean", css),
    .jnew("java/lang/Boolean", images)
  ) -> res

  res <- as.list(res)

  lapply(res, function(.x) {

    wr <- .x$getWebRequest()
    hdrs <- as.list(.x$getResponseHeaders())

    lapply(hdrs, function(.x) {
      data.frame(
        name = .x$getName() %||% NA_character_,
        value = .x$getValue() %||% NA_character_,
        stringsAsFactors = FALSE
      )
    }) -> hdrs

    hdrs <- do.call(rbind.data.frame, hdrs)
    class(hdrs) <- c("tbl_df", "tbl", "data.frame")

    data.frame(
      method = wr$getHttpMethod()$toString() %||% NA_character_,
      url = wr$getUrl()$toString() %||% NA_character_,
      status_code = .x$getStatusCode() %||% NA_integer_,
      message = .x$getStatusMessage() %||% NA_character_,
      content =I(list(charToRaw(.x$getContentAsString()))) %||% NA_character_,
      content_length = as.double(.x$getContentLength() %||% NA_real_),
      content_type = .x$getContentType() %||% NA_character_,
      load_time = as.double(.x$getLoadTime() %||% NA_real_),
      headers = I(list(hdrs)),
      stringsAsFactors = FALSE
    )

  }) -> out

  out <- do.call(rbind.data.frame, out)
  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}
