
[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Signed
by](https://img.shields.io/badge/Keybase-Verified-brightgreen.svg)](https://keybase.io/hrbrmstr)
![Signed commit
%](https://img.shields.io/badge/Signed_Commits-100%25-lightgrey.svg)
[![Linux build
Status](https://travis-ci.org/hrbrmstr/htmlunit.svg?branch=master)](https://travis-ci.org/hrbrmstr/htmlunit)
[![Coverage
Status](https://codecov.io/gh/hrbrmstr/htmlunit/branch/master/graph/badge.svg)](https://codecov.io/gh/hrbrmstr/htmlunit)
![Minimal R
Version](https://img.shields.io/badge/R%3E%3D-3.2.0-blue.svg)
![License](https://img.shields.io/badge/License-Apache-blue.svg)

# htmlunit

Tools to Scrape Dynamic Web Content via the ‘HtmlUnit’ Java Library

## Description

‘HtmlUnit’ (<https://htmlunit.sourceforge.net/>) is a “‘GUI’-Less
browser for ‘Java’ programs”. It models ‘HTML’ documents and provides an
‘API’ that allows one to invoke pages, fill out forms, click links and
more just like one does in a “normal” browser. The library has fairly
good and constantly improving ‘JavaScript’ support and is able to work
even with quite complex ‘AJAX’ libraries, simulating ‘Chrome’, ‘Firefox’
or ‘Internet Explorer’ depending on the configuration used. It is
typically used for testing purposes or to retrieve information from web
sites. Tools are provided to work with this library at a higher level
than provided by the exposed ‘Java’ libraries in the ‘htmlunitjars’
package.

## What’s Inside The Tin

The following functions are implemented:

### DSL

  - `web_client`/`webclient`: Create a new HtmlUnit WebClient
    instance<br/><br/>

  - `wc_go`: Visit a URL<br/>

  - `wc_html_nodes`: Select nodes from web client active page html
    content

  - `wc_html_text`: Extract attributes, text and tag name from webclient
    page html content<br/><br/>

  - `wc_html_attr`: Extract attributes, text and tag name from webclient
    page html content

  - `wc_html_name`: Extract attributes, text and tag name from webclient
    page html content

  - `wc_headers`: Return response headers of the last web request for
    current page

  - `wc_browser_info`: Retreive information about the browser used to
    create the ‘webclient’

  - `wc_content_length`: Return content length of the last web request
    for current page

  - `wc_content_type`: Return content type of web request for current
    page<br/><br/>

  - `wc_render`: Retrieve current page contents<br/><br/>

  - `wc_css`: Enable/Disable CSS support

  - `wc_dnt`: Enable/Disable Do-Not-Track

  - `wc_geo`: Enable/Disable Geolocation

  - `wc_img_dl`: Enable/Disable Image Downloading

  - `wc_load_time`: Return load time of the last web request for current
    page

  - `wc_resize`: Resize the virtual browser window

  - `wc_status`: Return status code of web request for current page

  - `wc_timeout`: Change default request timeout

  - `wc_title`: Return page title for current page

  - `wc_url`: Return load time of the last web request for current page

  - `wc_use_insecure_ssl`: Enable/Disable Ignoring SSL Validation Issues

  - `wc_wait`: Block HtlUnit final rendering blocks until all background
    JavaScript tasks have finished executing

### Just the Content (pls)

  - `hu_read_html`: Read HTML from a URL with Browser Emulation & in a
    JavaScript Context

### Content++

  - `wc_inspect`: Perform a “Developer Tools”-like Network Inspection of
    a URL

## Installation

``` r
install.packages("htmlunit", repos = "https://cinc.rud.is")
# or
remotes::install_git("https://git.rud.is/hrbrmstr/htmlunit.git")
# or
remotes::install_git("https://git.sr.ht/~hrbrmstr/htmlunit")
# or
remotes::install_gitlab("hrbrmstr/htmlunit")
# or
remotes::install_bitbucket("hrbrmstr/htmlunit")
# or
remotes::install_github("hrbrmstr/htmlunit")
```

NOTE: To use the ‘remotes’ install options you will need to have the
[{remotes} package](https://github.com/r-lib/remotes) installed.

## Usage

``` r
library(htmlunit)
library(tidyverse) # for some data ops; not req'd for pkg

# current verison
packageVersion("htmlunit")
## [1] '0.3.0'
```

Something `xml2::read_html()` cannot do, read the table from
<https://hrbrmstr.github.io/htmlunitjars/index.html>:

![](man/figures/test-url-table.png)

``` r
test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

pg <- xml2::read_html(test_url)

html_table(pg)
## list()
```

☹️

But, `hu_read_html()` can\!

``` r
pg <- hu_read_html(test_url)

html_table(pg)
## [[1]]
##      X1   X2
## 1   One  Two
## 2 Three Four
## 3  Five  Six
```

All without needing a separate Selenium or Splash server instance.

### Content++

We can also get a HAR-like content + metadata dump:

``` r
xdf <- wc_inspect("https://rstudio.com")

colnames(xdf)
## [1] "method"         "url"            "status_code"    "message"        "content"        "content_length"
## [7] "content_type"   "load_time"      "headers"

select(xdf, method, url, status_code, content_length, load_time)
## # A tibble: 168 x 5
##    method url                                                                       status_code content_length load_time
##    <chr>  <chr>                                                                           <int>          <dbl>     <dbl>
##  1 GET    https://rstudio.com/                                                              302            154       278
##  2 GET    https://www.rstudio.com/                                                          200         125451       281
##  3 GET    https://www.rstudio.com/wp-includes/js/wp-emoji-release.min.js?ver=5.1.1          200           4426        47
##  4 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200           4193       147
##  5 GET    https://fonts.googleapis.com/css?family=Lato:100,300,regular,700,900%7CO…         200            820       151
##  6 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200           1306        24
##  7 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200           7102        26
##  8 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200           9680        23
##  9 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200           1001        20
## 10 GET    https://442r58kc8ke1y38f62ssb208-wpengine.netdna-ssl.com/wp-content/plug…         200            271        21
## # … with 158 more rows

group_by(xdf, content_type) %>% 
  summarise(
    total_size = sum(content_length), 
    total_load_time = sum(load_time)/1000
  )
## # A tibble: 8 x 3
##   content_type           total_size total_load_time
##   <chr>                       <dbl>           <dbl>
## 1 application/javascript     673583           3.79 
## 2 application/json             4147           0.914
## 3 image/gif                      70           0.202
## 4 image/jpeg                  59772           0.022
## 5 image/png                  577497           0.423
## 6 text/css                   131846           0.773
## 7 text/html                  126021           0.592
## 8 text/javascript            191565           0.492
```

### DSL

``` r
wc <- web_client(emulate = "chrome")

wc %>% wc_browser_info()
## < Netscape / 5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/76.0.3809.100 Safari/537.36 / en-US >

wc <- web_client()

wc %>% wc_go("https://usa.gov/")

# if you want to use purrr::map_ functions the result of wc_html_nodes() needs to be passed to as.list()

wc %>%
  wc_html_nodes("a") %>%
  sapply(wc_html_text, trim = TRUE) %>% 
  head(10)
##  [1] "Skip to main content"               ""                                   "Español"                           
##  [4] "1-844-USA-GOV1"                     "All Topics and Services"            "About the U.S."                    
##  [7] "American Flag"                      "Branches of the U.S. Government"    "Budget of the U.S. Government"     
## [10] "Data and Statistics about the U.S."

wc %>%
  wc_html_nodes(xpath=".//a") %>%
  sapply(wc_html_text, trim = TRUE) %>% 
  head(10)
##  [1] "Skip to main content"               ""                                   "Español"                           
##  [4] "1-844-USA-GOV1"                     "All Topics and Services"            "About the U.S."                    
##  [7] "American Flag"                      "Branches of the U.S. Government"    "Budget of the U.S. Government"     
## [10] "Data and Statistics about the U.S."

wc %>%
  wc_html_nodes(xpath=".//a") %>%
  sapply(wc_html_attr, "href") %>% 
  head(10)
##  [1] "#content"                "/"                       "/espanol/"               "/phone"                 
##  [5] "/#tpcs"                  "#"                       "/flag"                   "/branches-of-government"
##  [9] "/budget"                 "/statistics"
```

Handy function to get rendered plain text for text mining:

``` r
wc %>% 
  wc_render("text") %>% 
  substr(1, 300) %>% 
  cat()
## USA.gov: The U.S. Government's Official Web Portal | USAGov
## Skip to main content
## 
## 
## An official website of the United States government Here's how you know
## 
## 
## 
## 
## 
## 
## 
## 
## 
## 
## Search
##  Search
## 
## 
## Search
##  1-844-USA-GOV1
## 
## 
## 
## All Topics and Services
## 
## 
## About the U.S.
## 
## 
## Benefits, Grants, Loans
## 
## 
## Government Agencies and
```

### htmlunit Metrics

| Lang  | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :---- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R     |       14 | 0.78 | 351 | 0.76 |         193 | 0.74 |      372 | 0.83 |
| Rmd   |        1 | 0.06 |  41 | 0.09 |          52 | 0.20 |       75 | 0.17 |
| Maven |        1 | 0.06 |  30 | 0.06 |           0 | 0.00 |        1 | 0.00 |
| Java  |        1 | 0.06 |  28 | 0.06 |          11 | 0.04 |        0 | 0.00 |
| make  |        1 | 0.06 |  14 | 0.03 |           4 | 0.02 |        0 | 0.00 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
