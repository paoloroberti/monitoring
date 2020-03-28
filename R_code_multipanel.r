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
