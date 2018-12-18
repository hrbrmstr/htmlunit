#' Select nodes from web client active page html content
#'
#' @md
#' @param wc_obj a `webclient` object
#' @param css,xpath Nodes to select. Supply one of css or xpath depending on whether you want to use a css or xpath 1.0 selector.
#' @export
#' @examples \dontrun{
#' wc <- web_client()
#'
#' wc %>% wc_go("https://usa.gov/")
#'
#' wc %>%
#'   wc_html_nodes("a") %>%
#'   sapply(wc_html_text)
#'
#' wc %>%
#'   wc_html_nodes(xpath=".//a") %>%
#'   sapply(wc_html_text)
#'
#' wc %>%
#'   wc_html_nodes(xpath=".//a") %>%
#'   sapply(wc_html_attr, "href")
#' }
wc_html_nodes <- function(wc_obj, css, xpath) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  if (missing(css) && missing(xpath))
    stop("Please supply one of css or xpath", call. = FALSE)

  if (!missing(css) && !missing(xpath))
    stop("Please supply css or xpath, not both", call. = FALSE)

  if (!missing(css)) {
    if (!is.character(css) && length(css) == 1) stop("`css` must be a string")

    out <- pg$querySelectorAll(css)

  } else {
    if (!is.character(xpath) && length(xpath) == 1)
      stop("`xpath` must be a string")

    out <- pg$getByXPath(xpath)

  }

  out

}

#' Extract attributes, text and tag name from webclient page html content
#'
#' @md
#' @param dom_node a webclient page DOM node (likely produced by [wc_html_nodes()])
#' @param trim if `TRUE` will trim leading/trailing white space
#' @export
#' @examples \dontrun{
#' wc <- web_client()
#'
#' wc %>% wc_go("https://usa.gov/")
#'
#' wc %>%
#'   wc_html_nodes("a") %>%
#'   sapply(wc_html_text)
#'
#' wc %>%
#'   wc_html_nodes(xpath=".//a") %>%
#'   sapply(wc_html_text)
#'
#' wc %>%
#'   wc_html_nodes(xpath=".//a") %>%
#'   sapply(wc_html_attr, "href")
#' }
wc_html_text <- function(dom_node, trim = FALSE) {
  x <- dom_node$getTextContent()
  if (trim) x <- trimws(x)
  x
}

#' @rdname wc_html_text
#' @export
#' @param attr name of attribute to retrieve
wc_html_attr <- function(dom_node, attr) {
  dom_node$getAttribute(attr)
}

#' @rdname wc_html_text
#' @export
wc_html_name <- function(dom_node) {
  dom_node$getNodeName()
}
