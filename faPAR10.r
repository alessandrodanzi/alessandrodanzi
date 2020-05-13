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
