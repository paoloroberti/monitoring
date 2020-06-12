# R_code.no2
library(raster)
setwd("C:/lab/NO2/")

rlist <- list.files(pattern="EN")

import <- lapply(rlist, raster)

EN <- stack(import)

cl <- colorRampPalette(c('red','orange','yellow'))(100) #
plot(EN, col=cl)


par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

dev.off()
plotRGB(EN, r=1, g=7, b=13, stretch="lin")

dif <- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100) #
plot(dif, col=cld)

dev.off()
boxplot(EN,outline=F, horizontal=T, axes=T)
