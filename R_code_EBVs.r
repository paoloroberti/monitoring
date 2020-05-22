###R_code_EBVs

setwd("C:/lab/")

library(raster) #to import the image
library(RStoolbox) #for PCA

snt <- brick("snt_r10.tif") #snt is for sentinel
plot(snt)

#B1: blue
#B2: green
#B3: red
#B4: NIR

#R3 G2 B1
plotRGB(snt, 3, 2, 1, stretch = "lin" )

plotRGB(snt, 4, 3, 2, stretch = "lin" ) #NIR on top of red band. vegetaion is red

###measure standard deviation, only one layer
pairs(snt) #to look at the relation between the bends
#PC1 is ok to measure standard deviation

##PCA analysis
sntpca <- rasterPCA(snt)
sntpca

summary(sntpca$model) #70% of image info is conatined in the first component

plot(sntpca$map)

plotRGB(sntpca$map, 1, 2, 3, stretch='Lin')

# set the moving window
window <- matrix(1, nrow = 5, ncol = 5)
window

sd_snt <- focal(sntpca$map$PC1, w= window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) #
plot(sd_snt, col=cl)
 # low variability in the forest while in the cultivated area high variability
par(mfrow=c(1,2))
plotRGB(snt, 4, 3, 2, stretch = "lin", main ="original imagine" ) #NIR on top of red band. vegetaion is red
plot(sd_snt, col=cl, main= "diversity")
