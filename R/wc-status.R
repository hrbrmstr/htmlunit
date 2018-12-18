#' Return status code of web request for current page
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @return the HTTP status code and message of the web request or `NULL` if no active page
#' @export
wc_status<- function(wc_obj, url) {

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
#' @return the content type o the web request or `NULL` if no active page
#' @export
wc_status<- function(wc_obj, url) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()

  response$getContentType()

}
