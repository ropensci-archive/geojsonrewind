context("rewind")

library("jsonlite")

test_that("rewind works with character input", {
  x <- '{"type":"Polygon","coordinates":[[[100.0,0.0],[101.0,0.0],[101.0,1.0],[100.0,1.0],[100.0,0.0]]]}'
  aa <- rewind(x)
  bb <- rewind(x, outer = FALSE)

  expect_is(aa, "character")
  expect_match(aa, "Polygon")
  expect_equal(fromJSON(aa, FALSE)$coordinates[[1]][[2]][[1]], 101)

  expect_is(bb, "character")
  expect_match(bb, "Polygon")
  expect_equal(fromJSON(bb, FALSE)$coordinates[[1]][[2]][[1]], 100)
})

test_that("rewind works with list input", {
  f <- system.file("tests/testthat/collection.input.geojson", package = "geojsonrewind")
  aa <- rewind(fromJSON(f, FALSE))

  expect_is(aa, "list")
  expect_named(aa, c('type', 'features'))
  expect_equal(aa$type, 'FeatureCollection')
  expect_is(aa$features, 'list')
  expect_equal(length(aa$features), 3)
})

test_that("rewind fails well", {
  expect_error(rewind(), "argument \"x\" is missing")
  expect_error(rewind(5), "no 'rewind' method for numeric")
  expect_error(rewind(mtcars), "no 'rewind' method for data.frame")
})

# FIXME: clearly not working
test_that("rewind - checks - with lists", {
  # f <- system.file("tests/testthat/featuregood.input.geojson", package = "geojsonrewind")
  # aa <- rewind(x = fromJSON(f, FALSE))
  #
  # out <- fromJSON(system.file("tests/testthat/featuregood.output.geojson", package = "geojsonrewind"), FALSE)
  # expect_identical(
  #   aa,
  #   out
  # )
  #
  #
  # f <- system.file("tests/testthat/multipolygon.input.geojson", package = "geojsonrewind")
  # aa <- rewind(fromJSON(f, FALSE))
  #
  # out <- fromJSON(system.file("tests/testthat/multipolygon.output.geojson", package = "geojsonrewind"), FALSE)
  # expect_identical(
  #   aa,
  #   out
  # )
})

test_that("rewind - checks - with json", {
  f <- system.file("tests/testthat/featuregood.input.geojson", package = "geojsonrewind")
  aa <- rewind(toJSON(fromJSON(f, FALSE), auto_unbox = TRUE))

  out <- toJSON(fromJSON(system.file("tests/testthat/featuregood.output.geojson", package = "geojsonrewind"), FALSE), auto_unbox = TRUE)
  expect_identical(
    aa,
    out
  )


  f <- system.file("tests/testthat/multipolygon.input.geojson", package = "geojsonrewind")
  aa <- rewind(fromJSON(f, FALSE))

  out <- fromJSON(system.file("tests/testthat/multipolygon.output.geojson", package = "geojsonrewind"), FALSE)
  expect_identical(
    aa,
    out
  )
})
