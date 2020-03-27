### Multipanel in R: the second lecture of monitoring ecosystems

install.packages("sp")

library(sp) #require(sp) will also do teh same job, telling R that we are going to use this package

data(meuse) #data means there is a dataset available named meuse

attach(meuse)

#exercise: see the names of the variables and plot cadmium versus zinc
plot(cadmium,zinc) #what I've done
names(meuse) #show the names
head(meuse)

plot(cadmium,zinc,pch=15,col="red",cex=3)

#exercise:make all possible pairwis plots of dataset
#use of plo() is not so good couse it's too long plot each pair

pairs(meuse)
