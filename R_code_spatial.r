# R code for spatial view of points


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

covid <- read.table("covid_agg.csv", head=T) #link an object to a function





