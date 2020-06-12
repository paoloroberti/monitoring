### SDM (species distribution modelling) to model the probability of occurence
### of a species in a given environment looking at the main environmental parameters

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
