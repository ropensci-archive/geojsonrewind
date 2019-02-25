#' rewind2
#'
#' @export
#' @param x A geojson object, either as list, character string, or json
#' class
#' @param outer (logical) counterclockwise (`TRUE`, default) or
#' clockwise (`FALSE`)
#' @details ported from `geojson-rewind` JS library at
#' <https://github.com/mapbox/geojson-rewind>
#' @return a geojson object, as json/character class
#' @examples
#' toj <- function(x) jsonlite::toJSON(x, auto_unbox = TRUE)
#' 
#' # list
#' str <- "POLYGON((100 0, 100 5, 105 5, 105 0, 100 0))"
#' (x <- unclass(wkt2geojson(str)))
#' rewind2(x)
#' 
#' # linestring
#' st <- list(LineString = matrix(c(0.0, 2.0, 4.0, 5.0,
#'                                0.0, 1.0, 2.0, 4.0),
#'                                ncol = 2))
#' rewind2(st)
#' 
#' # 
#' geojsonio::map_leaf(toj(x))
#' geojsonio::map_leaf(toj(str_rev))
#'
#' # json
#' library(jsonlite)
#' rewind(toJSON(fromJSON(x), auto_unbox = TRUE))
rewind2 <- function(x, fmt = 6) {
  UseMethod("rewind2")
}
rewind2.default <- function(x, fmt = 6) {
  stop("no 'rewind2' method for ", class(x)[1L], call. = FALSE)
}
rewind2.list <- function(x, fmt = 6) {
  wkt <- wellknown::geojson2wkt(x, fmt)
  wkt_rev <- wicket::wkt_reverse(wkt)
  unclass(wellknown::wkt2geojson(wkt_rev))
}
rewind2.json <- function(x, fmt = 6) {
  wkt <- wellknown::geojson2wkt(list(Polygon = x$geometry$coordinates), fmt)
  wkt_rev <- wicket::wkt_reverse(wkt)
  unclass(wellknown::wkt2geojson(wkt_rev))
}
# rewind2wkt <- function(x, fmt = 6) {
#   wkt <- wellknown::geojson2wkt(list(Polygon = x$geometry$coordinates), fmt)
#   wicket::wkt_reverse(wkt)
# }

coerce2wkformat <- function(x) {
  if (all(c("type", "geometry") %in% tolower(names(x)))) {
    # do something
  } else if (any(geojson_types %in% tolower(names(x)))) {
    # do something
  }
}

geojson_types <- c("point", "multipoint", "linestring", "multilinestring", 
  "polygon", "multipolygon")
