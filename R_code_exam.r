# R_code_exam.r
1.R code first
2.R code multipanel
3.R code spatial
4.R code multivariete analysis 
5.R code for remote sensing
6.R code ecosystem functions and deforestation 
7.R code for multivariate analysis
8.R code radiancer, how to code ecosystems' reflectance
9.R code faPAR
10.R code EBVs
11.R code focal on cladonia
12.R code NO2
13.R code snow cover
14.R code interpolation
15.R code for cropping
16.R code species distribution modelling
17.R code exam

#############################################################################
#############################################################################
#############################################################################

1.R code first
install.packages("sp")

library(sp)
data(meuse)

# let's see how the meuse dataset is structured:
meuse

# let's look at the first row of the set
head(meuse)

#let's plot two variables
#let's see if the zin concentration is related to that of copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="green")
plot(zinc,copper,col="green",pch=19)
plot(zinc,copper,col="green",pch=19,cex=2)


#############################################################################
#############################################################################
#############################################################################

### Multipanel in R: the second lecture of monitoring ecosystems

install.packages("sp")
install.packages("GGally",dependencies=T) #intallation of new packages
install.packages("hms")  #installed since in was required by ggpairs function

library(sp) #require(sp) will also do teh same job, telling R that we are going to use this package
library("GGally")
data(meuse) #data means there is a dataset available named meuse

attach(meuse)

#exercise: see the names of the variables and plot cadmium versus zinc
plot(cadmium,zinc) #what I've done
names(meuse) #show the names
head(meuse)

plot(cadmium,zinc,pch=15,col="red",cex=3)

#exercise:make all possible pairwis plots of dataset
#use of plot() is not so good couse it's too long plot each pair

pairs(meuse) # you can plot all the variables together

#prettify the plot, reduce variables
pairs(~cadmium+copper+lead+zinc,data=meuse)

pairs(meuse[,3:6]) # [] subset of a dataset, comma means "start from". this produce the same result of the prevoius function

#exercise: prettify this graph
pairs(meuse[,3:6],pch=13,col="green")
pairs(meuse[,3:6],pch=18,col="green",cex=1.5)

#after this point something goes wrong--> install and library of GGally

ggpairs(meuse[,3:6])#function after install and library of GGally

#############################################################################
#############################################################################
#############################################################################

# 3. R code for spatial view of points


library(sp)

data(meuse)

head(meuse)#to see the top value

#make cooridnates
coordinates(meuse) = ~x+y #we are using these coordinates

plot(meuse)
spplot(meuse, "zinc")

#exercize: plot the spatial amount of copper
spplot(muse, "copper", main="Copper concentration")

bubble(meuse, "zinc")
bubble(meuse, "copper", main="Zinc concentration")

#make it red coll=red

###importing new data

#download covi_agg.csv and put the fil into folder lab in C

#setting the working directory: lab
#windows
setwd("C:/lab/")

covid <- read.table("covid_agg.csv", head=T) #link an object to a function #head=TRUE means that we don't want the label
head(covid) #we open the dataset

attach(covid)#attach the dataset
plot(country,cases) #if i don't attach the database i should write plot(covid$country,covid$cases)

plot(country,cases, las=0) #las is lable. with zero parallel label
plot(country,cases, las=1) #horizontal labels
plot(country,cases, las=2) #perpendicular labels
plot(country,cases, las=3) #vertical labels

plot(country,cases, las=3, cex.axis=0.5)
plot(country,cases, las=3, cex.axis=0.7)


##produce a ggplot. Are needed: data, aesthetic mapping between variable and geometrical components for the graph
install.packages("ggplot2")
library(ggplot2) #we want to use the package. #you can also use require(ggplot2)


#save the .RData under File
#start of the new lecture

setwd("C:/lab/")  #we set the previous working directory
load(".RData") #we load the previous data set

ls() #ls list of objects
#ggplot2 has 3 key components: data, aes(aesthetic), geometry
#we want to represent covid data with ggplot2

library(ggplot2) #require(ggplot2)

data(mpg) #upload the package
head(mpg) #to see the first line

ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() #data si mpg,aes is related to the variables

#let's change the geometry
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

head(covid)
ggplot(covid, aes(x=lon, y=lat, size=cases)) + geom_point()

#############################################################################
#############################################################################
#############################################################################
# 4.R code for multivariate analysis

setwd("C:/lab/")

library(vegan)

biomes<- read.table('biomes.csv', head=T, sep=',' )

head(biomes)

#DEtrended CORrespondence ANAlysis (decorana)--> put the data in two dimension
multivar<- decorana (biomes)
plot(multivar)

head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=1:4, kind="ehull", lwd=3)

ordispider(multivar, type, col=1:4, label=T)

#############################################################################
#############################################################################
#############################################################################

#5.R code for remote sensing

install.packages("raster")
install.packages("RStoolbox")

setwd("C:/lab/")
library(raster)

p224r63_2011<- brick("p224r63_2011_masked.grd") #importnig a compact set of diffetent bends(reflectance of different pixels in different wavelength)
plot(p224r63_2011) #B4 is the nir

#change the color ramp palette.
cl <- colorRampPalette(c('black','grey','light grey'))(100)

plot(p224r63_2011, col=cl)

#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: nir

# multiframe of different plots
par(mfrow=c(2,2)) #4 plots in the page

#B1: blue
clb<- colorRampPalette(c('dark blue', 'blue', 'light blue'))(100)
plot(p224r63_2011$B1_sre, col=clb)

#B3: green
clg<- colorRampPalette(c('dark green', 'green', 'light green'))(100)
plot(p224r63_2011$B2_sre, col=clg)

#B3 red
clr<- colorRampPalette(c('dark red', 'red', 'pink'))(100)
plot(p224r63_2011$B3_sre, col=clr)

#B4 nir
cln<- colorRampPalette(c('red', 'orange', 'yellow'))(100)
plot(p224r63_2011$B4_sre, col=cln)

#change the multiframe
par(mfrow=c(4,1))
# copy all the bands

#plotRGB

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch='Lin')

#we include NIR which better represent the leaves but we have to remove the blue
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch='Lin')

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch='Lin') #nir against the green component

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch='Lin')

################
setwd("C:/lab/")
load("remote_sensing.RData")
ls()

library(raster)
p224r63_1988<- brick("p224r63_1988_masked.grd") #importnig a compact set of diffetent bends(reflectance of different pixels in different wavelength)
plot(p224r63_1988)

#bands of Landsat
#B1: blue
#B2: green
#B3: red
#B4: NIR

#Exercize: plot in visible RGB 321 both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch='Lin')
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch='Lin')

#Exercize: show the same plot in fals color with 432 RGB both images
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch='Lin')
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch='Lin')

#enhance the noise!
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch='hist')
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch='hist')

#DVI= NIR - RED. Difference vegetation index
#bands of Landsat
#B1: blue
#B2: green
#B3: red: B3_sre
#B4: NIR: B4_sre

dvi2011 <- p224r63_2011$B4_sre - p224r63_2011$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100)
plot(dvi2011,col=cl)

#Exercize: dvi for 1988
dvi1988 <- p224r63_1988$B4_sre - p224r63_1988$B3_sre
cl <- colorRampPalette(c('darkorchid3','light blue','lightpink4'))(100)
plot(dvi1988,col=cl)

Difference between teh two year
diff<- dvi2011 - dvi1988
plot(diff)

#changing the grain (the resolution basically) with aggregate
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #fact is the amount of time we want to increase the dimesion of the pixel
p224r63_2011res100 <- aggregate(p224r63_2011, fact=100) 

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch='Lin')
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch='Lin')
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch='Lin')

#############################################################################
#############################################################################
#############################################################################
#6.R_code ecosystem functions and deforestation 

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

#############################################################################
#############################################################################
#############################################################################

#7. R code for multivariate analysis

setwd("C:/lab/")

library(vegan)

biomes<- read.table('biomes.csv', head=T, sep=',' )

head(biomes)

#DEtrended CORrespondence ANAlysis (decorana)--> put the data in two dimension
multivar<- decorana (biomes)
plot(multivar)

head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=1:4, kind="ehull", lwd=3)

ordispider(multivar, type, col=1:4, label=T)

#############################################################################
#############################################################################
#############################################################################

#8.R_code_radiancer.r
#radiance is the radiant flux emitted, reflected, transmitted or received by a given surface

library(raster)

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)

values(toy) <- c(1.13, 1.44, 1.55, 3.4)

plot(toy)
text(toy, digits=2)

#produce an image with a higer potential value.

toy2bits <- stretch(toy,minv=0,maxv=3) # 2^2=4 combinations
storage.mode(toy2bits[]) = "integer"

plot(toy2bits)
text(toy2bits, digits=2)


toy4bits <- stretch(toy,minv=0,maxv=15) #2^4=16 combinations
storage.mode(toy4bits[]) = "integer"

plot(toy4bits)
text(toy4bits, digits=2)

#with higer range the pixels tends to be more different

toy8bits <- stretch(toy,minv=0,maxv=255)  #2^8= 256
storage.mode(toy8bits[]) = "integer"

plot(toy8bits)
text(toy8bits, digits=2)

#plot all together
par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)

#############################################################################
#############################################################################
#############################################################################

#9.R_code_faPAR.r
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

#############################################################################
#############################################################################
#############################################################################

#10.R_code_EBVs

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

#############################################################################
#############################################################################
#############################################################################

###11.FOCAL on Cladonia

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

#############################################################################
#############################################################################
#############################################################################

#12.R_code.no2
library(raster)
setwd("C:/lab/NO2/")

rlist <- list.files(pattern="EN")

import <- lapply(rlist, raster)

EN <- stack(import)

cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN, col=cl)

# january and march
par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

dev.off()
plotRGB(EN, r=1, g=7, b=13, stretch="lin") # plotRGB

dif <- EN$EN_0013 - EN$EN_0001 # difference map
cld <- colorRampPalette(c('blue','white','red'))(100) #
plot(dif, col=cld)

dev.off()
boxplot(EN,outline=F, horizontal=T, axes=T) # quanitative estimation
# the maximum value have reduced

#############################################################################
#############################################################################
#############################################################################

#13.R_code_snow.r

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

#############################################################################
#############################################################################
#############################################################################

#14.R_code_interpolation
# interpolation of the data to obtain information were there are no samples

#beech forest
setwd("C:/lab/")

library(spatstat)
imp <- read.table("dati_plot55_LAST3.csv", sep=";", head= T)

head(imp)
# beech forest with a high canopy cover

attach(imp) # we don't have to use the dollar in this way

plot(X,Y)

# ppp= planar point pattern, explain what are the coordinates and their range
summary(imp) # to see min and max value of variables
inpp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

# marks function allow to give the name to the point, in this case the canopy cover
marks(inpp) <- Canopy.cov

canopy <- Smooth(inpp) # smooth is for interpolation

plot(canopy)
points(inpp, col="green")

## compare the canopy density with the lichens Cover

marks(inpp) <- cop.lich.mean
lichs <- Smooth(inpp)
plot(lichs)
points(inpp)

par(mfrow=c(1,3))
plot(canopy)
points(inpp)
plot(lichs)
points(inpp)
plot(Canopy.cov, cop.lich.mean, col= "red", pch= 19, cex= 2)


#sammophilous Vegetation
setwd("C:/lab/")

library(spatstat)
imp.psam <- read.table("dati_psammofile.csv", sep=";", head= T)

attach(imp.psam)

head(imp.psam)
plot(E, N)

inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
marks(inp.psam.ppp) <- C_org

C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)

#############################################################################
#############################################################################
#############################################################################
#15.R code for cropping
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

#############################################################################
#############################################################################
#############################################################################

#16.R code species distribution modelling
# SDM (species distribution modelling) to model the probability of occurence
# of a species in a given environment looking at the main environmental parameters

install.packages("sdm")
library(sdm)
library(raster)
library(rgdal)

#import the species data (presence/absence)
file <- system.file("external/species.shp", package="sdm")
species <- shapefile(file) # converti the file

plot(species)

# plot presence and absence
plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)

path <- system.file("external", package="sdm") # path towards the folder we will use

lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

preds <- stack(lst) # the variable we will use to make the prevision
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$temperature == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$precipitation == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$vegetation == 1,], pch=16)


# model
d <- sdmData(train=species, predictors=preds)

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + precipitation, data=d, methods= "glm" )

p1 <- predict(m1, newdata=preds)
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

s1 <- stack(preds,p1)
plot(s1, col=cl)

#############################################################################
#############################################################################
#############################################################################

16.R code for exam
