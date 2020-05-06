#
setwd("C:/lab/")

library(raster)
library(RStoolbox)

p224r63_2011<- brick("p224r63_2011_masked.grd")

#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: nir
#B5: SWIR (short-wave infrared)
#B6: thermal infrared
#B7: SWIR
#B8: panchromatic

 plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") #the main forest become Green

 #plot with ggplot
 library (ggplot2)
 ggRGB(p224r63_2011, 5, 4, 3)

 #do the same with the 1988 image
 p224r63_1988<- brick("p224r63_1988_masked.grd")
 plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") #the main forest become Green

 par(mfrow=c(1,2))
 plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") #the main forest become Green
 plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") #the main forest become Green

devoff()

names(p224r63_2011)
#"B1_sre" "B2_sre" "B3_sre" "B4_sre" "B5_sre" "B6_bt"  "B7_sre"
plot(p224r63_2011$B1_sre, p224r63_2011$B3_sre)

#PCA! decrease the resolution
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

cl <- colorRampPalette(c('dark grey','grey','light grey'))(100)
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$model)#PC1 represent the 99% of the variation
pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch='Lin')

#1988
p224r63_1988_res <- aggregate(p224r63_1988, fact=10) #decrease the amount of data
p224r63_1988_pca <- rasterPCA(p224r63_1988_res)
plot(p224r63_1988_pca$map, col=cl)

summary(p224r63_1988_pca$model) #99.56% by PC1
pairs(p224r63_1988)

#defferences between the two images.
diffpca <- p224r63_2011_pca$map-p224r63_1988_pca$map
plot(diffpca)

cldif <- colorRampPalette(c('blue','black','yellow'))(100)
plot(diffpca$PC1, col=cldif)
