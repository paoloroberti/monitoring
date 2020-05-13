#R_code_faPAR.r
#how to look at chemical cycling by satellites
#faPAR is the part of the radiation used for photosynthesys
library( raster)
library( rasterVis)
library( rasterdiv)


plot(copNDVI) #the NvDI over earth
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))

levelplot(copNDVI) # show the NVDI sum on latitude and longitude.

setwd("C:/lab/")

faPAR10<- raster("faPAR10.tif") #10 since the aggregation is 10

levelplot(faPAR10) #the equator is much more evidenced respect NVDI since we are looking
#at the chemical cycling, carbon fixation and at the equator almost all the
#light is used by the different plant at all level of forest vertical structure.

pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf('faPAR.pdf')
levelplot(faPAR10)
dev.off()

#day 2
library(raster)
library(rasterdiv)
setwd("C:/lab/")
load("faPAR.RData")

#the original faPAR in copernicus is 2GB
#let's see how much space is needed for an 8-bit set

writeRaster(copNDVI, "copNDVI.tif")
# the new file weight 5.3MB, low space is needed
