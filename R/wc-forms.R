#' Retrieve a form on a webclient page by name
#'
#' @note This returns a `webclient_form` object _not_ the `wc_obj` passed in
#' @param wc_obj a `webclient` object
#' @param name form name
#' @export
wc_get_form_by_name <- function(wc_obj, name) {

  pg <- wc_obj$wc$getCurrentWindow()$getEnclosedPage()

  if (.jnull() == pg) return(NULL)

  f <- pg$getFormByName(name)

  f

}
