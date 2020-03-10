#' Perform a "Developer Tools"-like Network Inspection of a URL
#'
#' Retrieves _all_ content loaded
#'
#' @md
#' @param url URL to fetch
#' @param js_delay (ms) How long to wait for JavaScript to execute/XHRs to load? (Default: 5000)
#' @export
wc_inspect <- function(url, js_delay = 5000L) {

  app <- J("is.rud.htmlunit.Zapp")

  res <- app$getRequestsFor(url, .jlong(js_delay))
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
