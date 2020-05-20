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

###regression model between faPAR and NDVI: we look at the relation between the two variables.

#relation between erosion(kg/m2) and heavy metal (ppm) mobilized
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

plot(erosion, hm, col = "red", pch = 19, xlab = "erosion", ylab = "heavy metal")

# a linear model help to analyze the relation
mod1 <- lm(hm ~ erosion)
abline(mod1)

#faPAR vs NDVI model
setwd("C:/lab/")
faPAR10 <- raster("faPAR10.tif")

plot(faPAR10)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)#remove water from copernicus NDVI

 #select random points from the image
install.packages("sf")
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}

pts <- random.points(faPAR10, 1000)
 #extract the data
copNNDVIp <- extract(copNDVI, pts)
faPAR10p <- extract(faPAR10, pts)

#photosynthesys vs biomass

mod2 <- lm(faPAR10p ~ copNNDVIp)

plot(copNNDVIp, faPAR10p, col = "green", xlab = "biomass", ylab = "photosynthesystosysn")
abline(mod2)
