#R_code_snow.r

setwd("C:/lab/")

install.packages("ncdf4")

library(raster)
library(ncdf4)

snow_may <- raster("c_gls_SCE_202005260000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('dark blue','blue','light blue'))(100) #

plot(snow_may, col= cl)

setwd("C:/lab/snow/")
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

par(mfrow = c(2,3))
plot(snow2000, col=cl)
plot(snow2005, col=cl)
plot(snow2010, col=cl)
plot(snow2015, col=cl)
plot(snow2020, col=cl)

#do the same with few passages
rlist <- list.files(pattern="snow") # pattern regard the common part of the names
rlist

import <- lapply(rlist, raster) # lapply allow to apply a function to a list of object
snow.multitemp <- stack(import) # stack to put the images all together

plot(snow.multitemp, col=cl)


##let's make a prediction

source("prediction.r")
plot(predicted.snow.2025.norm, col= cl)

### day 2nd
library(raster)
setwd("C:/lab/snow/")

#import the images all together
rlist <- list.files(pattern="snow")
import <- lapply(rlist, raster)
snow.multitemp <- stack(import) # stack to put the images all together
plot(snow.multitemp, col=cl)

prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)

# 1:1 line
 plot(snow.multitemp$snow2010r, snow.multitemp$snow2020r)
 abline(0, 1, col="red") # most of the data are below the 1 to 1 curve.





## export the output
writeRaster(prediction, "final.tif") # use this function to export a raster image in the preferred format and create a data

final.stack <- stack(snow.multitemp, prediction) # to stack all the imaes together
plot(final.stack, col=cl)

# export the R graph as pdf
pdf("final_graph.pdf")
plot(final.stack, col=cl)
dev.off()

# export the R graph as png
png("final_graph.png")
plot(final.stack, col=cl)
dev.off()
