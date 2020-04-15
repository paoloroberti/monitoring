# R code for multivariate analysis

setwd("C:/lab/")

library(vegan)

biomes<- read.table('biomes.csv', head=T, sep=',' )

head(biomes)

#DEtrended CORrespondence ANAlysis (decorana)--> put the data in two dimension
multivar<- decorana (biomes)
plot(multivar)

head(biomes_types)

attach(biomes_types)
ordiellipse(multivar, type, col=1:4, kind="ehull", lwd=3)

ordispider(multivar, type, col=1:4, label=T)
