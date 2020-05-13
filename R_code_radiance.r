#R_code_radiance.r

library(raster)

#we will invent the data so we are not setting the working directory

#in general when we play with these things we name the vector play
#we create a new raster with 2 columns and 2 rows
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
values(toy) <- c (1.08, 1.24, 1.23, 3.45)

#we can now plot(toy)
plot(toy)
text(toy, digits=2)
toy2bits <- stretch(toy,minv=0,maxv=3)
storage.mode(toy2bits[]) = "integer"
plot(toy2bits)
text(toy2bits, digits=2)

#with 4bits
toy4bits <- stretch(toy,minv=0,maxv=15)
storage.mode(toy4bits[]) = "integer"
plot(toy4bits)
text(toy4bits, digits=2)

#with8
toy8bits <- stretch(toy,minv=0,maxv=255)
storage.mode(toy8bits[]) = "integer"
plot(toy8bits)
text(toy8bits, digits=2)

#to plot all of them one after the other
par(mfrow=c(1, 4))
plot(toy)
text(toy, digits=2)

 

plot(toy2bits)
text(toy2bits, digits=2)

 

plot(toy4bits)
text(toy4bits, digits=2)

 

plot(toy8bits)
text(toy8bits, digits=2)
