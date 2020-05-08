#how to look at chemical by satellite

setwd("/Users/alessandro/lab")
library(raster)
library(rasterVis)
library(rasterdiv)

#we also use copNDVI (copernicus NDVI) NDVI= works with layers of reflectance
#plats: high reflectance in NIR and low in RED
#no plants: lower NIR higher RED
plot(copNDVI)

copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)
#levelplot makes the average of the values on the orizontal and on the vertical line of pixelsand show it on the side of the graph
faPAR10 <- raster("faPAR10.tif")  #raster to import the data. 10 because used a factor of 10 to aggregate the pixels
levelplot(faPAR10)
#we have less values on the northern side rather than equator because now we are taking into account 

#save as pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()
