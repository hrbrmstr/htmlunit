
[![Travis-CI Build
Status](https://travis-ci.org/hrbrmstr/htmlunit.svg?branch=master)](https://travis-ci.org/hrbrmstr/htmlunit)
[![Coverage
Status](https://img.shields.io/codecov/c/github/hrbrmstr/htmlunit/master.svg)](https://codecov.io/github/hrbrmstr/htmlunit?branch=master)
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/htmlunit)](https://cran.r-project.org/package=htmlunit)

# htmlunit

Tools to Scrape Dynamic Web Content via the ‘HtmlUnit’ Java Library

## Description

`HtmlUnit` (<http://htmlunit.sourceforge.net/>) is *a “‘GUI’-Less
browser for ‘Java’ programs”. It models ‘HTML’ documents and provides an
‘API’ that allows one to invoke pages, fill out forms, click links and
more just like one does in a “normal” browser. The library has fairly
good and constantly improving ‘JavaScript’ support and is able to work
even with quite complex ‘AJAX’ libraries, simulating ‘Chrome’, ‘Firefox’
or ‘Internet Explorer’ depending on the configuration used. It is
typically used for testing purposes or to retrieve information from web
sites.*

Tools are provided to work with this library at a higher level than
provided by the exposed ‘Java’ libraries in the
[`htmlunitjars`](https://gitlab.com/hrbrmstr/htmlunitjars) package.

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
    a
URL

## Installation

``` r
install.packages(c("htmlunitjars", "htmlunit"), repos = "https://cinc.rud.is", type="source")
```

## Usage

``` r
library(htmlunit)
library(tidyverse) # for some data ops; not req'd for pkg

# current verison
packageVersion("htmlunit")
## [1] '0.2.0'
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
(xdf <- wc_inspect("https://rud.is/b"))
## # A tibble: 55 x 9
##    method url                status_code message   content               content_length content_type  load_time headers 
##    <chr>  <chr>                    <int> <chr>     <chr>                          <dbl> <chr>             <dbl> <I(list>
##  1 GET    https://rud.is/b           301 Moved Pe… "<html>\r\n<head><ti…            162 text/html           113 <tibble…
##  2 GET    https://rud.is/b/          200 OK        "<!-- This page is c…          10974 text/html            29 <tibble…
##  3 GET    https://rud.is/b/…         200 OK        "// Source: wp-inclu…           4426 application/…        29 <tibble…
##  4 GET    https://rud.is/b/…         200 OK        ".wp-block-audio fig…           4320 text/css             21 <tibble…
##  5 GET    https://rud.is/b/…         200 OK        "/* http://prismjs.c…           1601 text/css             19 <tibble…
##  6 GET    https://rud.is/b/…         200 OK        ".wp_syntax {\n\tcol…            820 text/css             18 <tibble…
##  7 GET    https://rud.is/b/…         200 OK        "@media print{body{b…            338 text/css             18 <tibble…
##  8 GET    https://rud.is/b/…         200 OK        ".row-fluid{width:10…           2491 text/css             19 <tibble…
##  9 GET    https://rud.is/b/…         200 OK        "/*! normalize.css v…            850 text/css             21 <tibble…
## 10 GET    https://rud.is/b/…         200 OK        "@font-face{font-fam…           1965 text/css             20 <tibble…
## # … with 45 more rows

group_by(xdf, content_type) %>% 
  summarise(
    total_size = sum(content_length), 
    total_load_time = sum(load_time)/1000
  )
## # A tibble: 5 x 3
##   content_type             total_size total_load_time
##   <chr>                         <dbl>           <dbl>
## 1 application/javascript       146930           0.965
## 2 application/x-javascript       9959           0.226
## 3 image/webp                    33686           0.225
## 4 text/css                      43913           0.348
## 5 text/html                     11136           0.142
```

### DSL

``` r
wc <- web_client()

wc %>% wc_browser_info()
## < Netscape / 5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36 / en-US >

wc <- web_client()

wc %>% wc_go("https://usa.gov/")

# if you want to use purrr::map_ functions the result of wc_html_nodes() needs to be passed to as.list()

wc %>%
  wc_html_nodes("a") %>%
  sapply(wc_html_text, trim = TRUE) %>% 
  head(10)
##  [1] "Skip to main content"               ""                                   "1-844-USA-GOV1"                    
##  [4] "All Topics and Services"            "Branches of the U.S. Government"    "Budget of the U.S. Government"     
##  [7] "Data and Statistics about the U.S." "History and Historical Documents"   "American Flag"                     
## [10] "Learn About Life in the U.S."

wc %>%
  wc_html_nodes(xpath=".//a") %>%
  sapply(wc_html_text, trim = TRUE) %>% 
  head(10)
##  [1] "Skip to main content"               ""                                   "1-844-USA-GOV1"                    
##  [4] "All Topics and Services"            "Branches of the U.S. Government"    "Budget of the U.S. Government"     
##  [7] "Data and Statistics about the U.S." "History and Historical Documents"   "American Flag"                     
## [10] "Learn About Life in the U.S."

wc %>%
  wc_html_nodes(xpath=".//a") %>%
  sapply(wc_html_attr, "href") %>% 
  head(10)
##  [1] "#skiptarget"             "/"                       "/phone"                  "/#tpcs"                 
##  [5] "/branches-of-government" "/budget"                 "/statistics"             "/history"               
##  [9] "/flag"                   "/life-in-the-us"
```

Handy function to get rendered plain text for text mining:

``` r
wc %>% 
  wc_render("text") %>% 
  substr(1, 300) %>% 
  cat()
## Official Guide to Government Information and Services | USAGov
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
## Government Agencies
```

### htmlunit Metrics

| Lang  | \# Files |  (%) | LoC |  (%) | Blank lines |  (%) | \# Lines |  (%) |
| :---- | -------: | ---: | --: | ---: | ----------: | ---: | -------: | ---: |
| R     |       14 | 0.78 | 351 | 0.77 |         193 | 0.73 |      372 | 0.81 |
| Rmd   |        1 | 0.06 |  38 | 0.08 |          55 | 0.21 |       87 | 0.19 |
| Maven |        1 | 0.06 |  30 | 0.07 |           0 | 0.00 |        1 | 0.00 |
| Java  |        1 | 0.06 |  28 | 0.06 |          11 | 0.04 |        1 | 0.00 |
| make  |        1 | 0.06 |  10 | 0.02 |           4 | 0.02 |        0 | 0.00 |

## Code of Conduct

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
