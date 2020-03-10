
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
## [1] '0.3.1'
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
## # A tibble: 46 x 5
##    method url                                                                       status_code content_length load_time
##    <chr>  <chr>                                                                           <int>          <dbl>     <dbl>
##  1 GET    https://rstudio.com/                                                              200          12225       468
##  2 GET    https://dev.visualwebsiteoptimizer.com/j.php?a=450622&u=https%3A%2F%2Frs…         200           1254       263
##  3 GET    https://dev.visualwebsiteoptimizer.com/6.0/va-41bacd491c20ae77339f81a709…         200          55687        68
##  4 GET    https://use.fontawesome.com/releases/v5.0.6/css/all.css                           200           8699       170
##  5 GET    https://d33wubrfki0l68.cloudfront.net/bundles/c5ddb3e999592179708beea702…         200          53046       153
##  6 GET    https://cdn.rawgit.com/noelboss/featherlight/1.7.13/release/featherlight…         200            763       172
##  7 GET    https://d33wubrfki0l68.cloudfront.net/css/4a0f49009a213e6e2207c6f66893f0…         200            505        15
##  8 GET    https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min…         200            548       211
##  9 GET    https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-aweso…         200           6663       127
## 10 GET    https://snap.licdn.com/li.lms-analytics/insight.min.js                            200           1576       136
## # … with 36 more rows

group_by(xdf, content_type) %>% 
  summarise(
    total_size = sum(content_length), 
    total_load_time = sum(load_time)/1000
  )
## # A tibble: 12 x 3
##    content_type               total_size total_load_time
##    <chr>                           <dbl>           <dbl>
##  1 ""                              44288           0.185
##  2 "application/javascript"       262203           0.724
##  3 "application/json"               4100           0.848
##  4 "application/x-javascript"     152398           0.521
##  5 "image/gif"                        35           0.209
##  6 "image/jpeg"                    59772           0.026
##  7 "image/png"                     40634           0.064
##  8 "image/svg+xml"                 41727           0.141
##  9 "text/css"                     118100           1.08 
## 10 "text/html"                     12642           0.518
## 11 "text/javascript"              249525           0.926
## 12 "text/plain"                       28           0.183
```

### DSL

``` r
wc <- web_client(emulate = "chrome")

wc %>% wc_browser_info()
## < Netscape / 5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36 / en-US >

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
## An official website of the United States government Here's how you know
## 
## 
## Search
## Search
## Search
## 1-844-USA-GOV1
## All Topics and Services
## Benefits, Grants, Loans
## Government Agencies and Elected Officials
## Jobs and Unemployme
```

### htmlunit Metrics

| Lang  | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :---- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R     |       14 | 0.78 | 351 | 0.76 |         193 | 0.74 |      372 | 0.83 |
| Rmd   |        1 | 0.06 |  41 | 0.09 |          52 | 0.20 |       75 | 0.17 |
| Maven |        1 | 0.06 |  30 | 0.07 |           0 | 0.00 |        1 | 0.00 |
| Java  |        1 | 0.06 |  28 | 0.06 |          12 | 0.05 |        0 | 0.00 |
| make  |        1 | 0.06 |  10 | 0.02 |           4 | 0.02 |        0 | 0.00 |

## Code of Conduct

Please note that this project is released with a Contributor Code of
Conduct. By participating in this project you agree to abide by its
terms.
