
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

### Standard

  - `hu_read_html`: Read HTML from a URL with Browser Emulation & in a
    JavaScript Context

### DSL

  - `web_client`: Create a new HtmlUnit WebClient instance
  - `wc_go`: Visit a URL
  - `wc_browser_info`: Retreive information about the browser used to
    create the ‘webclient’
  - `wc_status`: Return status code of web request for current page
  - `wc_render`: Retrieve current page contents

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
## [1] '0.1.0'
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

### DSL

``` r
wc <- web_client()

wc %>% wc_browser_info()
## < Netscape / 5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36 / en-US >

wc %>% wc_go(test_url)

wc %>% wc_render("html") 
## [1] "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n<html>\r\n  <head>\r\n    <meta charset=\"utf-8\"/>\r\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\r\n    <title>\r\n    </title>\r\n    <meta name=\"description\" content=\"\"/>\r\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\"/>\r\n    <link rel=\"stylesheet\" href=\"\"/>\r\n  </head>\r\n  <body>\r\n    <script>\r\n//<![CDATA[\r\n\n\n      function createTable(tableData) {\n        var table = document.createElement('table');\n        var row = {};\n        var cell = {};\n      \n        tableData.forEach(function(rowData) {\n          row = table.insertRow(-1);\n          rowData.forEach(function(cellData) {\n            cell = row.insertCell();\n            cell.textContent = cellData;\n          });\n        });\n        document.body.appendChild(table);\n      }\n      \n      createTable([\n        [\"One\", \"Two\"], \n        [\"Three\", \"Four\"], \n        [\"Five\", \"Six\"]\n      ]);\n\n    \r\n//]]>\r\n    </script>\r\n    <table>\r\n      <tbody>\r\n        <tr>\r\n          <td>\r\n            One\r\n          </td>\r\n          <td>\r\n            Two\r\n          </td>\r\n        </tr>\r\n        <tr>\r\n          <td>\r\n            Three\r\n          </td>\r\n          <td>\r\n            Four\r\n          </td>\r\n        </tr>\r\n        <tr>\r\n          <td>\r\n            Five\r\n          </td>\r\n          <td>\r\n            Six\r\n          </td>\r\n        </tr>\r\n      </tbody>\r\n    </table>\r\n  </body>\r\n</html>\r\n"

wc %>% wc_render("parsed") 
## {xml_document}
## <html>
## [1] <head>\n<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">\n<meta charset="utf-8">\n<meta http-e ...
## [2] <body>\r\n    <script>\r\n//<![CDATA[\r\n\n\n      function createTable(tableData) {\n        var table = documen ...

wc %>% wc_render("text") 
## [1] "One\tTwo\nThree\tFour\nFive\tSix"
```
