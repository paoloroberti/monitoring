
setwd("C:/lab/")

library(raster)
library(ncdf4)

snow <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
plot(snow, col=cl)

ext <- c(0, 20, 35, 50)
zoom(snow, ext=ext)

snowitaly <- crop(snow, ext)
plot(snowitaly, col=cl)

zoom(snow, ext=drawExtent()) #allow to draw a rectangle to zoom on a certain image
