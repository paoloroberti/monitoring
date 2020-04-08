#Point pattern Analysis: Density map

install.packages("spatstat")
library(spatstat)

setwd("C:/lab/")
covid <- read.table("covid_agg.csv", head=T) #link an object to a function #head=TRUE means that we don't want the label
head(covid) #we open the dataset

attach(covid)
head(covid)
covids<- ppp(lon, lat, c(-180,180), c(-90,90)) #with c() we put the limits of lon and lat

#without attaching the covid set: covids<- ppp(codiv$lon, covid$lat, c(-180,180), c(-90,90))

d<- density(covids)

plot(d)

points(covids) #we put points on the previuous graph

#new lesson
setwd("C:/lab/")
load("pointpatternanalysis")

#covids: point pointpattern
#d:Density

 library(spatstat)

 plot(d)
 points(covids)   #we have the density graph with points.

 #we are importing the coast line, dawnload of coastline data from iol

install.packages("rgdal")
library(rgdal)

plot(d)
points(covids)

#let's input vector lines (x0y0, x1y1, x2y2, ...)
coastline<- readOGR("ne_10m_coastline.shp")

plot(coastline, add=T)

#change the color
cl<- colorRampPalette(c("yellow", "orange", "red"))(100)  #destity scale of color. 100 is numebr of color from yellow to red
plot(d, col=cl)
points(covids)
plot(coastline, add=T)

#exercize-->maka a new colorRampPalette
cl<- colorRampPalette(c("light blue", "purple", "red"))(200)  #destity scale of color. 100 is numebr of color from yellow to red
plot(d, col=cl, main="densities of covid-19") #with main you can chnage the title
points(covids)
plot(coastline, add=T)

#export
pdf("covid_density.pdf")
cl<- colorRampPalette(c("light blue", "purple", "red"))(200)  #destity scale of color. 100 is numebr of color from yellow to red
plot(d, col=cl, main="densities of covid-19") #with main you can chnage the title
points(covids)
plot(coastline, add=T)

#copy all the functions that we used to plot

dev.off() #close teh device
