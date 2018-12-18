#' Retrieve current page contents
#'
#' If there is a page in the active browser context, return the contents of
#' the page.
#'
#' The page contents can be returned as one of:
#'
#' - Parsed HTML (i.e. an `xml2` `html_document`)
#' - A string representation of the HTML document. NOTE: The charset used is the
#'   current page encoding.
#' - A textual representation of this page that represents what would be visible
#'   to the user if this page was shown in a web browser. This is useful for,
#'   say, text mining.
#'
#' @note This is an information retrieval function that does not return
#'       the `wc_obj` so must be the last function call in a `webclient` pipe.
#' @param wc_obj a `webclient` object
#' @param what what to return (see Details); NOTE that if there is no active
#'        page this function returns `NULL`.
#' @return if `what` is `parsed`, an `xml2` `html_document`; if `html`,
#'         the character HTML representation of the page; if `text`
#'         the rendered text of the document as viewed by a human.
#' @export
wc_render <- function(wc_obj, what = c("parsed", "html", "text")) {

  what <- match.arg(what, c("parsed", "html", "text"))

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  response <- pg$getWebResponse()
  content <- response$getContentAsString()

  switch(
    what,
    parsed = xml2::read_html(pg$asXml()),
    html = pg$asXml(),
    text = pg$asText()
  )

}
