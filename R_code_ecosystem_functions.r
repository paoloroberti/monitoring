#R_code ecosystem functions and deforestation 

#R code to view biomass over world and calculate changes ine cosystem functions
#energy
#chemical cycling
#proxies

install.packages("rasterdiv")
install.packages("rasterVis")

library(rasterVis)
library(rasterdiv)

data(copNDVI)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)

#reduce the resolution with aggregate
copNDVI10 <- aggregate(copNDVI, fact=10)
levelplot(copNDVI10)

copNDVI100 <- aggregate(copNDVI, fact=100)
levelplot(copNDVI100)

######################################################
#Example of NDI plot with ggplot
library(ggplot2)

myPalette <- colorRampPalette(c('white','green','dark green'))
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))


ggR(copNDVI, geom_raster = TRUE) +
scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+
labs(x="Longitude",y="Latitude", fill="")+
#   theme(legend.position = "bottom") +
  NULL
# +
# ggtitle("NDVI")
#######################################################

#continue the lesson
setwd("C:/lab/")
library(raster)

defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

# plotRGB -> 3 componets Red Green Blue
#band1: NIR, defor1_.1
#band2: red, defor1_.2
#band3: Green

plotRGB(defor1, r=1, g=2, b=3, stretch='Lin')
plotRGB(defor2, r=1, g=2, b=3, stretch='Lin')

par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch='Lin')
plotRGB(defor2, r=1, g=2, b=3, stretch='Lin')

#calculate the DVI

 dvi1<- defor1$defor1_.1 - defor1$defor1_.2

 #band1: NIR, defor2_.1
 #band2: red, defor2_.2
 #band3: Green

 dvi2<- defor2$defor2_.1 - defor2$defor2_.2

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme

par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi <- dvi1 - dvi2

dev.off()
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld) #rappresentation of ecosystem services loss

hist(difdvi)
