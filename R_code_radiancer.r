#R_code_radiancer.r
#radiance is the radiant flux emitted, reflected, transmitted or received by a given surface

library(raster)

toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)

values(toy) <- c(1.13, 1.44, 1.55, 3.4)

plot(toy)
text(toy, digits=2)

#produce an image with a higer potential value.

toy2bits <- stretch(toy,minv=0,maxv=3) # 2^2=4 combinations
storage.mode(toy2bits[]) = "integer"

plot(toy2bits)
text(toy2bits, digits=2)



toy4bits <- stretch(toy,minv=0,maxv=15) #2^4=16 combinations
storage.mode(toy4bits[]) = "integer"

plot(toy4bits)
text(toy4bits, digits=2)

#with higer range the pixels tends to be more different

toy8bits <- stretch(toy,minv=0,maxv=255)  #2^8= 256
storage.mode(toy8bits[]) = "integer"

plot(toy8bits)
text(toy8bits, digits=2)

#plot all together
par(mfrow=c(1,4))

plot(toy)
text(toy, digits=2)

plot(toy2bits)
text(toy2bits, digits=2)

plot(toy4bits)
text(toy4bits, digits=2)

plot(toy8bits)
text(toy8bits, digits=2)
