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

