
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

  - `hu_read_html`: Read HTML from a URL with Browser Emua;tion & in a
    JavaScript Context

## Installation

``` r
devtools::install_github("hrbrmstr/htmlunitjars")
devtools::install_github("hrbrmstr/htmlunit")
```

## Usage

``` r
library(htmlunit)

# current verison
packageVersion("htmlunit")
```

    ## [1] '0.1.0'

Something `xml2::read_html()` cannot do, read the table from
<https://hrbrmstr.github.io/htmlunitjars/index.html>:

![](man/figures/test-url-table.png)

``` r
test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

pg <- xml2::read_html(test_url)

html_table(pg)
```

    ## list()

☹️

But, `hu_read_html()` can\!

``` r
pg <- hu_read_html(test_url)

html_table(pg)
```

    ## [[1]]
    ##      X1   X2
    ## 1   One  Two
    ## 2 Three Four
    ## 3  Five  Six

All without needing a separate Selenium or Splash server instance.
