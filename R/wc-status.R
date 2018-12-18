#' Return status code of web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the HTTP status code and message of the web request or `NULL` if no active page
#' @export
wc_status<- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  list(
    status_code = response$getStatusCode(),
    message = response$getStatusMessage()
  )

}

#' Return content type of web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the content type of the web request or `NULL` if no active page
#' @export
wc_content_type <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  response$getContentType()

}

#' Return content length of the last web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the content length (in bytes) of the web request or `NULL` if no active page
#' @export
wc_content_length <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  response$getContentLength()

}

#' Return load time of the last web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the load time (in ms) of the web request or `NULL` if no active page
#' @export
wc_load_time <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  response$getLoadTime()

}

#' Return load time of the last web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the load time (in ms) of the web request or `NULL` if no active page
#' @export
wc_url <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  pg$getUrl()$toString()

}

#' Return page title for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return page title of the current page `NULL` if no active page
#' @export
wc_title <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  pg$getTitleText()

}

#' Return response headers of the last web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the response headers of the web request as a data frame or `NULL` if no active page
#' @export
wc_headers <- function(wc_obj) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  do.call(
    rbind.data.frame,
    c(
      lapply(
        as.list(r$getResponseHeaders()),
        function(x) list(name = x$getName(), value = x$getValue())
      ),
      stringsAsFactors=FALSE
    )
  ) -> out

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}

