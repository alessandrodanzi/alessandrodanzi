#Point Pattern Analysis: Density map

#install the library for analysing Spatial Point Patterns to develope this study
install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

#covids= the name we gave to the covid spatial ppp=power point pattern, x=long(east-weast), y=lat(north-south)
covids<- ppp(lon, lat, c(-180,180), c(-90,90))   #c(..) is needed to take all the numbers in account together

#let's associate to the vector d the density of the covids data we just created
d<- density(covids)

#and create a plot of that density
plot(d)

#and we add the density to the plot, adding more to this function without closing the plot window (or we will delete the rest)
points(covids)


setwd("/Users/alessandro/lab") #mac
load("point_pattern.RData")
ls("point_pattern.RData")  #to check what's in there
#covids:point pattern
#d: density map

library(spatstat)

plot(d)

#we can put on this map the points of the covid
points(covids)

#download coastlines .zip file from IOL and copy all the files into lab folder
#rgdal package provides bindings to the 'Geospatial' Data Abstraction Library 
install.packages("rgdal")
library(rgdal)

#let's input vector lines (x0y0,x1y1,x2y2,...)
#read0GR within rgdal is a function that reads an OGR data source and layer into a suitable Spatial vector object
coastlines<-readOGR("ne_10m_coastline.shp")

plot(d)
points(covids)
plot(coastlines, add=T)  #we put add because it will not erase the precedent results

#change the colours and make the graph beautiful#
#100 means that there's 100 colours from yellow to red
cl<-colorRampPalette(c("yellow","orange","red"))(100)  
plot(d,col=cl)
points(covids)
plot(coastlines, add=T)

#another try
clr<-colorRampPalette(c("light green","yellow", "orange","pink"))(100)  
plot(d,col=clr, main="Covid19 distribution")
points(covids)
plot(coastlines, add=T)

#to export it
pdf("covid_density.pdf")
clr<-colorRampPalette(c("light green","yellow", "orange","pink"))(100)  
plot(d,col=clr, main="Covid19 density")
points(covids)
plot(coastlines, add=T)
dev.off()
