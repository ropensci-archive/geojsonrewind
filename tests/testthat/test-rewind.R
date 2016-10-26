context("rewind")

library("jsonlite")

test_that("rewind works with character input", {
  x <- '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]]]}'
  aa <- rewind(x)
  bb <- rewind(x, outer = FALSE)

  expect_is(aa, "json")
  expect_is(unclass(aa), "character")
  expect_match(aa, "Polygon")
  expect_equal(fromJSON(aa, FALSE)$coordinates[[1]][[2]][[1]], 101)

  expect_is(bb, "json")
  expect_is(unclass(bb), "character")
  expect_match(bb, "Polygon")
  expect_equal(fromJSON(bb, FALSE)$coordinates[[1]][[2]][[1]], 100)
})

test_that("rewind fails well", {
  expect_error(rewind(), "argument \"x\" is missing")
  expect_error(rewind(5), "no 'rewind' method for numeric")
  expect_error(rewind(mtcars), "no 'rewind' method for data.frame")
})
