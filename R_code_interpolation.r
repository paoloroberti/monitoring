# R_code_interpolation
# interpolation of the data to obtain information were there are no samples

#beech forest
setwd("C:/lab/")

library(spatstat)
imp <- read.table("dati_plot55_LAST3.csv", sep=";", head= T)

head(imp)
# beech forest with a high canopy cover

attach(imp) # we don't have to use the dollar in this way

plot(X,Y)

# ppp= planar point pattern, explain what are the coordinates and their range
summary(imp) # to see min and max value of variables
inpp <- ppp(x=X, y=Y, c(716000,718000),c(4859000,4861000))

# marks function allow to give the name to the point, in this case the canopy cover
marks(inpp) <- Canopy.cov

canopy <- Smooth(inpp) # smooth is for interpolation

plot(canopy)
points(inpp, col="green")

## compare the canopy density with the lichens Cover

marks(inpp) <- cop.lich.mean
lichs <- Smooth(inpp)
plot(lichs)
points(inpp)

par(mfrow=c(1,3))
plot(canopy)
points(inpp)
plot(lichs)
points(inpp)
plot(Canopy.cov, cop.lich.mean, col= "red", pch= 19, cex= 2)


#sammophilous Vegetation
setwd("C:/lab/")

library(spatstat)
imp.psam <- read.table("dati_psammofile.csv", sep=";", head= T)

attach(imp.psam)

head(imp.psam)
plot(E, N)

inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
marks(inp.psam.ppp) <- C_org

C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)
