% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wc-status.R
\name{wc_content_type}
\alias{wc_content_type}
\title{Return content type of web request for current page}
\usage{
wc_content_type(wc_obj)
}
\arguments{
\item{wc_obj}{a \code{webclient} object}
}
\value{
the content type of the web request or \code{NULL} if no active page
}
\description{
Return content type of web request for current page
}
\note{
This is an information retrieval function that does not return
the \code{wc_obj} so must be the last function call in a \code{webclient} pipe.
}
