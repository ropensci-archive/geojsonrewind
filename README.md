geojsonrewind
=============



[![Build Status](https://api.travis-ci.org/ropenscilabs/geojsonrewind.png)](https://travis-ci.org/ropenscilabs/geojsonrewind)
[![codecov.io](https://codecov.io/github/ropenscilabs/geojsonrewind/coverage.svg?branch=master)](https://codecov.io/github/ropenscilabs/geojsonrewind?branch=master)

port of the JS library [geojson-rewind](https://github.com/mapbox/geojson-rewind), with ports of parts of the JS libraries [geojson-area](https://github.com/mapbox/geojson-area) and [wgs84](https://github.com/mapbox/wgs84) included

## Installation


```r
install.packages("devtools")
devtools::install_github("ropenscilabs/geojsonrewind")
```


```r
library("geojsonrewind")
```

## Get ring area


```r
x <- '{
 "type":"Polygon",
 "coordinates":[
   [[100.0,0.0],[100.0,1.0],[101.0,1.0],[101.0,0.0],[100.0,0.0]]
 ]
}'
```

the value is __positive__ if ring is oriented counterclockwise


```r
x <- jsonlite::fromJSON(x, FALSE)
ring_area(x = x$coordinates[[1]])
#> [1] 12391399902
```

the value is __negative__ if ring is oriented counterclockwise


```r
ring_area(x = rev(x$coordinates[[1]]))
#> [1] -12391399902
```

## rewind

when `outer = TRUE`, clockwise


```r
rewind(x)
#> {"type":"Polygon","coordinates":[[[100,0],[101,0],[101,1],[100,1],[100,0]]]}
```

when `outer = FALSE`, counterclockwise


```r
rewind(x, outer = FALSE)
#> {"type":"Polygon","coordinates":[[[100,0],[100,1],[101,1],[101,0],[100,0]]]}
```

## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/geojsonrewind/issues).
* License: MIT
* Get citation information for `geojsonrewind` in R doing `citation(package = 'geojsonrewind')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![rofooter](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
