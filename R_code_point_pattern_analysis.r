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
