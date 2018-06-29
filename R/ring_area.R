#' geojson area function
#'
#' @export
#' @param x A list of coordinates. See examples for its form
#' @details ported from `geojson-aera` JS library at
#' <https://github.com/mapbox/geojson-area>
#'
#' Calculate the approximate area of the polygon were it projected onto
#' the earth.  Note that this area will be positive if ring is oriented
#' clockwise, otherwise it will be negative.
#'
#' Reference:
#' Robert. G. Chamberlain and William H. Duquette, "Some Algorithms for
#'   Polygons on a Sphere", JPL Publication 07-03, Jet Propulsion
#'   Laboratory, Pasadena, CA, June 2007
#'   http://trs-new.jpl.nasa.gov/dspace/handle/2014/40409
#' @return single integer - The approximate signed geodesic area of the
#' polygon in square meters. Positive if ring is oriented
#' clockwise, otherwise it will be negative.
#' @examples
#' x <- '{
#'  "type":"Polygon",
#'  "coordinates":[
#'    [[100.0,0.0],[100.0,1.0],[101.0,1.0],[101.0,0.0],[100.0,0.0]]
#'  ]
#' }'
#' x <- jsonlite::fromJSON(x, FALSE)
#' ring_area(x = x$coordinates[[1]])
#' ring_area(x = rev(x$coordinates[[1]]))
ring_area <- function(x) {
  area <- 0
  coords_length <- length(x)
  if (coords_length > 2) {
    for (i in seq_along(x)[-length(x)]) {
      if (i == coords_length - 2) {
        lower_index <- coords_length - 2
        middle_index <- coords_length - 1
        upper_index <- 1
      } else if (i == coords_length - 1) {
        lower_index <- coords_length - 1
        middle_index <- 1
        upper_index <- 2
      } else {
        lower_index <- i
        middle_index <- i + 1
        upper_index <- i + 2
      }
      p1 <- x[[lower_index]]
      p2 <- x[[middle_index]]
      p3 <- x[[upper_index]]
      area <- area + (rad(p3[[1]]) - rad(p1[[1]])) * sin(rad(p2[[2]]))
    }
    area <- area * wgs84_radius * (wgs84_radius / 2)
  }
  return(area)
}

rad <- function(x) x * pi / 180

wgs84_radius <- 6378137
wgs84_flattening_denom <- 298.257223563
wgs84_flattening <- 1/wgs84_flattening_denom
wgs84_polar_radius <- wgs84_radius * (1 - wgs84_flattening)
