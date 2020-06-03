#R_code_radiance.r
#raster is one of the libraries that we used the most and so we don't need to install it but just to open the library
library(raster)

#we will invent the data so we don't need to set the working directory this time

#in general when we play with these things we name the vector toy
#we create a new raster with 2 columns and 2 rows
toy <- raster(ncol=2, nrow=2, xmn=1, xmx=2, ymn=1, ymx=2)
#values(toy) contains the data that we created, the c function in to insert more then one number
values(toy) <- c (1.08, 1.24, 1.23, 3.45)

#we can now plot(toy)
plot(toy)
#text() function is to make a title, digits() function is to indicate how many significant digits of numeric values to show
text(toy, digits=2)
#stretch() function provide the desired output range
toy2bits <- stretch(toy,minv=0,maxv=3)
#Both mode and storage.mode return a character string giving the (storage) mode of the object
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
