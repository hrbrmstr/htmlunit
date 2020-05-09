
test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

w <- web_client()

expect_equal(class(w), "webclient")
expect_equal(class(wc_browser_info(w)), "browserinfo")

expect_equal(class(wc_go(w, url = test_url)), "webclient")

expect_equal(wc_url(w), test_url)
expect_equal(wc_title(w), "")

expect_true(inherits(wc_render(w, "parsed"), "xml_document"))
expect_true(inherits(wc_render(w, "html"), "character"))
expect_true(inherits(wc_render(w, "text"), "character"))

expect_true(inherits(wc_click_on(w, "table"), "webclient"))

expect_equal(
  wc_html_nodes(w, "title") %>%  sapply(wc_html_text),
  ""
)

expect_equal(
  wc_html_nodes(w, "title") %>% sapply(wc_html_name),
  "title"
)

h <- wc_headers(w)
expect_true(any(h$value == "GitHub.com"))

expect_inherits(
  hu_read_html(url = test_url, ret = "html_document"),
  "xml_document"
)
expect_true(
  inherits(hu_read_html(url = test_url, ret = "text"),
  "character"
))

