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









