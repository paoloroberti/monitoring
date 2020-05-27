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

##PCA (principal component analysis) analysis of the component the better represent the sample
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

### FOCAL on Cladonia

setwd("C:/lab/")

library(raster)

#raster function import one layer per time while brick import more than one layer
clad <- brick("cladonia_stellaris_calaita.JPG")
plotRGB(clad, 1,2,3, stretch="lin")

#measure variability and selection of the PC
#first we select the extection of the window to pass on top of the image
window <- matrix(1, nrow = 3, ncol = 3)
window

#PCA analysis
library(RStoolbox) #for PCA

cladpca <- rasterPCA(clad)
cladpca

summary(cladpca$model) #98% of image info is conatined in the first component

plotRGB(cladpca$map, 1, 2, 3, stretch='Lin')


#focal function applied to PC1 to identify the standard deviation
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)

PC1_agg <- aggregate(cladpca$map$PC1, fact=10) #to acelerate the calculation
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)

cl <- colorRampPalette(c('yellow','violet','black'))(100)
par(mfrow = c(1, 2))
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

# plot the calculation
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)
