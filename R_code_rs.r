#R code for remote sensing

#raster
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
