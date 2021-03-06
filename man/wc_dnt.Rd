% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wc-options.R
\name{wc_dnt}
\alias{wc_dnt}
\title{Enable/Disable Do-Not-Track}
\usage{
wc_dnt(wc_obj, enable)
}
\arguments{
\item{wc_obj}{a \code{webclient} object}

\item{enable}{if \code{TRUE} enable Do-Not-Track support (which is the HtmlUnit default)}
}
\value{
the \code{webclient} object (invisibly)
}
\description{
Enable/Disable Do-Not-Track
}
\note{
The caller does not have to assign the output of this function to a
variable as the browser state is managed internally by HtmlUnit.
}
\seealso{
Other wc_opts: 
\code{\link{wc_css}()},
\code{\link{wc_geo}()},
\code{\link{wc_img_dl}()},
\code{\link{wc_resize}()},
\code{\link{wc_timeout}()},
\code{\link{wc_use_insecure_ssl}()},
\code{\link{wc_wait}()}
}
\concept{wc_opts}
