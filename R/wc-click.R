#' Click on a DOM element in a webclient loaded page
#'
#' @note The caller does not have to assign the output of this function to a
#'       variable as the browser state is managed internally by HtmlUnit.
#' @param wc_obj a `webclient` object
#' @param css,xpath Node to click on. Supply one of css or xpath depending on whether you want to use a css or xpath 1.0 selector.
#' @export
wc_click_on <- function(wc_obj, css, xpath) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  if (missing(css) && missing(xpath))
    stop("Please supply one of css or xpath", call. = FALSE)

  if (!missing(css) && !missing(xpath))
    stop("Please supply css or xpath, not both", call. = FALSE)

  if (!missing(css)) {
    if (!is.character(css) && length(css) == 1) stop("`css` must be a string")

    item <- pg$querySelector(css)

  } else {
    if (!is.character(xpath) && length(xpath) == 1)
      stop("`xpath` must be a string")

    item <- as.list(pg$getByXPath(xpath))[[1]]

  }

  if (length(item) == 0) {
    warning("No item found with that selector.")
  } else if (length(item) > 1) {
    warning("More than one item found with that selector.")
  } else {
    item$click()
  }

  return(wc_obj)

}
