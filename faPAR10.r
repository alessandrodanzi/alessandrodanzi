#set working directory
setwd("/Users/alessandro/lab")

#the original faPAR from Copernicus is 2 GB, let's see faPAR10
load("faPAR.RData")
ls()
library (raster)
library (rasterdiv)

#to write a file
writeRaster(copNDVI, "copNDVI.tif")

#exercise###
library(rasterVis)
#faPAR:levelplot this set
levelplot(faPAR10)

###regression model between faPAR and NDVI###
#we start with 2 variables: erosion of soil (kg / m2) and heavy metals (ppm)
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

#let's plot the two cariables. pch (point character)= is the simbol, depends on the number
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals", cex=2)
model1 <- lm(hm ~ erosion) 
summary(model1)
#y=bx+a, intercept in summary means a, y is hm, x is erosion, b is the slope)
#R-squared is higher when the relation between the variables is higher (far from being random
#p-values means how many times is a random situation. p<0.01 there's a lower probability that once over hundred times is a random situation
abline (model1)

setwd("/Users/alessandro/lab")
library(raster)
library(rasterVis)
faPAR10 <- raster("~/lab/faPAR10.tif")
plot(faPAR10)
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA), right=TRUE)
library(sf) # to call st_* functions
random.points <- function(x,n)
{
lin <- rasterToContour(is.na(x))
pol <- as(st_union(st_polygonize(st_as_sf(lin))), 'Spatial') # st_union to dissolve geometries
pts <- spsample(pol[1,], n, type = 'random')
}
pts <- random.points(faPAR10,1000)

copNDVIp <- extract(copNDVI,pts)
faPAR10p <- extract(faPAR10,pts)

#photosynthesys vs biomass
model2 <- lm(faPAR10p ~ copNDVIp)

plot(copNDVIp, faPAR10p, col="green", xlab="biomass", ylab="photosynthesis")
abline(model2, col="red")
plot(copNDVIp,faPAR10p)
