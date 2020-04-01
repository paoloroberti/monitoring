# R code for spatial view of points


library(sp)

data(meuse)

head(meuse)#to see the top value

#make cooridnates
coordinates(meuse) = ~x+y #we are using these coordinates

plot(meuse)
spplot(meuse, "zinc")

#exercize: plot the spatial amount of copper
spplot(muse, "copper", main="copper concentration")

bubble(meuse, "zinc")
