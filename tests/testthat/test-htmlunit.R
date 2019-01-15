context("Core htmlunit ops work")
test_that("we can do something", {

  test_url <- "https://hrbrmstr.github.io/htmlunitjars/index.html"

  w <- web_client()

  expect_is(w, "webclient")
  expect_is(wc_browser_info(w), "browserinfo")

  expect_is(wc_go(w, url = test_url), "webclient")

  expect_equal(wc_url(w), test_url)
  expect_equal(wc_title(w), "")

  expect_is(wc_render(w, "parsed"), "xml_document")
  expect_is(wc_render(w, "html"), "character")
  expect_is(wc_render(w, "text"), "character")

  expect_is(wc_click_on(w, "table"), "webclient")

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

  expect_is(
    hu_read_html(url = test_url, ret = "html_document"),
    "xml_document"
  )
  expect_is(
    hu_read_html(url = test_url, ret = "text"),
    "character"
  )


})
