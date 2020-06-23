###DOWNLOAD FROM: https://glovis.usgs.gov/app, https://data.gov.au/dataset (for the .shp file)

###install.packages() if not already done
#install.packages("raster")
#install.packages("rgdal")
#install.packages("sp")

###make use of the library
library(raster)
library(sp)
library(rgdal)
#set the working directory in the general folder to extract the shape file that I'll use for every dataset

setwd("/Users/alessandro/lab/bushfire/kangarooisland") #mac
shp <- shapefile("LANDSCAPE_Biophysical_L3LandZones_GDA2020")

################################FIRE SEASON 2019/2020##################################
######################################################################################

#####(1) 08.12.19######################################################################
KI08122019_b <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_B2.TIF")
KI08122019_g <- raster("LC08_L1TP_098085_20191208_20191217_01_T1_B3.TIF")
KI08122019_r <- raster("LC08_L1TP_098085_20191208_20191217_01_T1_B4.TIF")
KI08122019_nir <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_B5.TIF")
KI08122019_swir <- raster("LC08_L1TP_098085_20191208_20191217_01_T1_B6.TIF")
KI08122019_panchrom <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_B8.TIF")
KI08122019_cir <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_B9.TIF")
KI08122019_tirs <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_B10.TIF")
KI08122019_bqa <-raster("LC08_L1TP_098085_20191208_20191217_01_T1_BQA.TIF")

#KI08122019_7bands<- stack(c(KI08122019_b, KI08122019_g, KI08122019_r, KI08122019_nir, KI08122019_swir, KI08122019_panchrom, KI08122019_tirs))
#i cannot do it because KI08122019_panchrom and KI08122019_tirs have different extent from the rest (they all have 30m, panchrom 15m and tirs 100m)

KI08122019_panchrom <- resample(KI08122019_panchrom, KI08122019_swir)
KI08122019_tirs <- resample(KI08122019_tirs, KI08122019_swir)

KI08122019_7bands<- stack(c(KI08122019_b, KI08122019_g, KI08122019_r, KI08122019_nir, KI08122019_swir, KI08122019_panchrom, KI08122019_tirs))
#now it works#

#because of the problem of the clouds I tried to import all the bands to make use of cirrus and quality image. I then realised that I was trying to solve something that was way to complicated for our knowledge.
#I decided to maintain the bands B2, B3, B4, B5, B6, B10 and I was able to import them with the lapply function (no problems of resampling)

rlist1 <- list.files(pattern="LC08_L1TP_098085_20191208_20191217_01_T1_B")
import1 <- lapply(rlist1,raster)
KI08122019 <- stack(import1)

proj4string(KI08122019)
proj4string(shp)

shp1 <- spTransform(shp, proj4string(KI08122019)) 

plot(KI08122019)
  plot(shp1, add=T)

KI08122019 <- mask(crop(KI08122019, extent(shp1)), shp1)  

plot(KI08122019)
  plot(shp1, add=T)


#B1 TIRS
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI08122019,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI08122019,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI08122019,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####

par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI08122019,4,3,2, stretch="lin")
plotRGB(KI08122019,1,4,2, stretch="lin")
plotRGB(KI08122019,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi1 <- (KI08122019$LC08_L1TP_098085_20191208_20191217_01_T1_B5 - KI08122019$LC08_L1TP_098085_20191208_20191217_01_T1_B4) / (KI08122019$LC08_L1TP_098085_20191208_20191217_01_T1_B5 + KI08122019$LC08_L1TP_098085_20191208_20191217_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi1)
proj4string(shp1)

shp1 <- spTransform(shp1, proj4string(ndvi1)) 

plot(ndvi1)
  plot(shp1, add=T)

ndvi1 <- mask(crop(ndvi1, extent(shp1)), shp1)  

plot(ndvi1)
  plot(shp1, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi1, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi1, maxpixels = ncell(ndvi1))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi1, breaks=breaks, col=palette)
#################################

#####(2) 09.01.20######################################################################

rlist2 <- list.files(pattern="LC08_L1TP_098085_20200109_20200114_01_T1_B")
import2 <- lapply(rlist2,raster)
KI09012020 <- stack(import2)

proj4string(KI09012020)

shp2 <- spTransform(shp, proj4string(KI09012020)) 

plot(KI09012020)
  plot(shp2, add=T)

KI09012020 <- mask(crop(KI09012020, extent(shp2)), shp2)  

plot(KI09012020)
  plot(shp2, add=T)
  
  
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI09012020,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI09012020,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI09012020,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI09012020,4,3,2, stretch="lin")
plotRGB(KI09012020,1,4,2, stretch="lin")
plotRGB(KI09012020,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared (B5)
ndvi2 <- (KI09012020$LC08_L1TP_098085_20200109_20200114_01_T1_B5 - KI09012020$LC08_L1TP_098085_20200109_20200114_01_T1_B4) / (KI09012020$LC08_L1TP_098085_20200109_20200114_01_T1_B5 + KI09012020$LC08_L1TP_098085_20200109_20200114_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi2)
proj4string(shp2)

shp2 <- spTransform(shp2, proj4string(ndvi2)) 

plot(ndvi2)
  plot(shp2, add=T)

ndvi2 <- mask(crop(ndvi2, extent(shp2)), shp2)  

plot(ndvi2)
  plot(shp2, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi2, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi2, maxpixels = ncell(ndvi2))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi2, breaks=breaks, col=palette)
#################################


#####(3) 10.02.20######################################################################

rlist3 <- list.files(pattern="LC08_L1TP_098085_20200210_20200224_01_T1_B")
import3 <- lapply(rlist3,raster)
KI10022020 <- stack(import3)


proj4string(KI10022020)


shp3 <- spTransform(shp, proj4string(KI10022020)) 

plot(KI10022020)
  plot(shp3, add=T)

KI10022020 <- mask(crop(KI10022020, extent(shp3)), shp3)  

plot(KI10022020)
  plot(shp3, add=T)
  
  
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI10022020,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI10022020,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI10022020,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI10022020,4,3,2, stretch="lin")
plotRGB(KI10022020,1,4,2, stretch="lin")
plotRGB(KI10022020,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi3 <- (KI10022020$LC08_L1TP_098085_20200210_20200224_01_T1_B5 - KI10022020$LC08_L1TP_098085_20200210_20200224_01_T1_B4) / (KI10022020$LC08_L1TP_098085_20200210_20200224_01_T1_B5 + KI10022020$LC08_L1TP_098085_20200210_20200224_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi3)
proj4string(shp3)

shp3 <- spTransform(shp3, proj4string(ndvi3)) 

plot(ndvi3)
  plot(shp3, add=T)

ndvi3 <- mask(crop(ndvi3, extent(shp3)), shp3)  

plot(ndvi3)
  plot(shp3, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi3, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi3, maxpixels = ncell(ndvi3))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi3, breaks=breaks, col=palette)
#################################

#####(4) 14.04.20######################################################################

rlist4 <- list.files(pattern="LC08_L1TP_098085_20200414_20200422_01_T1_B")
import4 <- lapply(rlist4,raster)
KI14042020 <- stack(import4)


proj4string(KI14042020)

shp4 <- spTransform(shp, proj4string(KI14042020)) 

plot(KI14042020)
  plot(shp4, add=T)

KI14042020 <- mask(crop(KI14042020, extent(shp4)), shp4)  

plot(KI14042020)
  plot(shp4, add=T)
  
  
#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI14042020,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI14042020,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI14042020,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI14042020,4,3,2, stretch="lin")
plotRGB(KI14042020,1,4,2, stretch="lin")
plotRGB(KI14042020,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi4 <- (KI14042020$LC08_L1TP_098085_20200414_20200422_01_T1_B5 - KI14042020$LC08_L1TP_098085_20200414_20200422_01_T1_B4) / (KI14042020$LC08_L1TP_098085_20200414_20200422_01_T1_B5 + KI14042020$LC08_L1TP_098085_20200414_20200422_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi4)
proj4string(shp4)

shp4 <- spTransform(shp4, proj4string(ndvi4)) 

plot(ndvi4)
  plot(shp4, add=T)

ndvi4 <- mask(crop(ndvi4, extent(shp4)), shp4)  

plot(ndvi4)
  plot(shp4, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi4, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi4, maxpixels = ncell(ndvi4))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi4, breaks=breaks, col=palette)
#################################

#####(5) 16.05.20######################################################################

rlist5 <- list.files(pattern="LC08_L1TP_098085_20200516_20200527_01_T1_B")
import5 <- lapply(rlist5,raster)
KI16052020 <- stack(import5)


proj4string(KI16052020)

shp5 <- spTransform(shp, proj4string(KI16052020)) 

plot(KI16052020)
  plot(shp4, add=T)

KI16052020 <- mask(crop(KI16052020, extent(shp5)), shp5)  

plot(KI16052020)
  plot(shp5, add=T)
  
  
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI16052020,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI16052020,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI16052020,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI16052020,4,3,2, stretch="lin")
plotRGB(KI16052020,1,4,2, stretch="lin")
plotRGB(KI16052020,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi5 <- (KI16052020$LC08_L1TP_098085_20200516_20200527_01_T1_B5 - KI16052020$LC08_L1TP_098085_20200516_20200527_01_T1_B4) / (KI16052020$LC08_L1TP_098085_20200516_20200527_01_T1_B5 + KI16052020$LC08_L1TP_098085_20200516_20200527_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi5)
proj4string(shp5)

shp5 <- spTransform(shp5, proj4string(ndvi5)) 

plot(ndvi5)
  plot(shp5, add=T)

ndvi5 <- mask(crop(ndvi5, extent(shp5)), shp5)  

plot(ndvi5)
  plot(shp5, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi5, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi5, maxpixels = ncell(ndvi5))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi5, breaks=breaks, col=palette)

##############################################
############################################
###############################################
##############SUMMARY 2019/2020###############

#summary 2019/2020 as the human eye see it
par(mfrow=c(3,2))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 

plotRGB(KI08122019,4,3,2, stretch="lin")
plotRGB(KI09012020,4,3,2, stretch="lin")
plotRGB(KI10022020,4,3,2, stretch="lin")
plotRGB(KI14042020,4,3,2, stretch="lin")
plotRGB(KI16052020,4,3,2, stretch="lin")

#summary 2019/2020 highlighting hot soil temperature in red (TIRS,r,b)
par(mfrow=c(3,2))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 

plotRGB(KI08122019,1,4,2, stretch="lin")
plotRGB(KI09012020,1,4,2, stretch="lin")
plotRGB(KI10022020,1,4,2, stretch="lin")
plotRGB(KI14042020,1,4,2, stretch="lin")
plotRGB(KI16052020,1,4,2, stretch="lin")

#summary 2019/2020 highlighting the burnt area (SWIR-NIR-red)
par(mfrow=c(3,2))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 

plotRGB(KI08122019,6,5,4, stretch="lin")
plotRGB(KI09012020,6,5,4, stretch="lin")
plotRGB(KI10022020,6,5,4, stretch="lin")
plotRGB(KI14042020,6,5,4, stretch="lin")
plotRGB(KI16052020,6,5,4, stretch="lin")

#summary 2019/2020 NDVI changes
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
par(mfrow=c(3,2))
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi1, col=palette)
plot(ndvi2, col=palette)
plot(ndvi3, col=palette)
plot(ndvi4, col=palette)
plot(ndvi5, col=palette)

#summary 2019/2020 NDVI changes enhanced
par(mfrow=c(3,2))
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi1, breaks=breaks, col=palette)
plot(ndvi2, breaks=breaks, col=palette)
plot(ndvi3, breaks=breaks, col=palette)
plot(ndvi4, breaks=breaks, col=palette)
plot(ndvi5, breaks=breaks, col=palette)

######################################################################################
######################################################################################
####################################FIRE SEASON 2018/2019#############################

#####(6) 05.12.18######################################################################

rlist6 <- list.files(pattern="LC08_L1TP_098085_20181205_20181211_01_T1_B")
import6 <- lapply(rlist6,raster)
KI05122018 <- stack(import6)


proj4string(KI05122018)

shp6 <- spTransform(shp, proj4string(KI05122018)) 

plot(KI05122018)
  plot(shp6, add=T)

KI05122018 <- mask(crop(KI05122018, extent(shp6)), shp6)  

plot(KI05122018)
  plot(shp6, add=T)
  
  
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI05122018,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI05122018,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI05122018,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI05122018,4,3,2, stretch="lin")
plotRGB(KI05122018,1,4,2, stretch="lin")
plotRGB(KI05122018,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi6 <- (KI05122018$LC08_L1TP_098085_20181205_20181211_01_T1_B5 - KI05122018$LC08_L1TP_098085_20181205_20181211_01_T1_B4) / (KI05122018$LC08_L1TP_098085_20181205_20181211_01_T1_B5 + KI05122018$LC08_L1TP_098085_20181205_20181211_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi6)
proj4string(shp6)

shp6 <- spTransform(shp6, proj4string(ndvi6)) 

plot(ndvi6)
  plot(shp6, add=T)

ndvi6 <- mask(crop(ndvi6, extent(shp6)), shp6)  

plot(ndvi6)
  plot(shp6, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi6, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi6, maxpixels = ncell(ndvi1))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi6, breaks=breaks, col=palette)
#################################

#####(7) 06.01.19######################################################################

rlist7 <- list.files(pattern="LC08_L1TP_098085_20190106_20190130_01_T1_B")
import7 <- lapply(rlist6,raster)
KI06012019 <- stack(import7)




proj4string(KI06012019)

shp7 <- spTransform(shp, proj4string(KI06012019)) 

plot(KI06012019)
  plot(shp7, add=T)

KI06012019 <- mask(crop(KI06012019, extent(shp7)), shp7)  

plot(KI06012019)
  plot(shp7, add=T)
  
  

#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI06012019,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI06012019,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI06012019,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI06012019,4,3,2, stretch="lin")
plotRGB(KI06012019,1,4,2, stretch="lin")
plotRGB(KI06012019,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi7 <- (KI06012019$LC08_L1TP_098085_20190106_20190130_01_T1_B5 - KI06012019$LC08_L1TP_098085_20190106_20190130_01_T1_B4) / (KI06012019$LC08_L1TP_098085_20190106_20190130_01_T1_B5 + KI06012019$LC08_L1TP_098085_20190106_20190130_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi7)
proj4string(shp7)

shp7 <- spTransform(shp7, proj4string(ndvi7)) 

plot(ndvi7)
  plot(shp7, add=T)

ndvi7 <- mask(crop(ndvi7, extent(shp7)), shp7)  

plot(ndvi7)
  plot(shp7, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi7, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi7, maxpixels = ncell(ndvi1))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi7, breaks=breaks, col=palette)
#################################

#####(8) 12.04.19######################################################################

rlist8 <- list.files(pattern="LC08_L1TP_098085_20190412_20190422_01_T1_B")
import8 <- lapply(rlist8,raster)
KI12042019 <- stack(import8)



proj4string(KI12042019)

shp8 <- spTransform(shp, proj4string(KI12042019)) 

plot(KI12042019)
  plot(shp8, add=T)

KI12042019 <- mask(crop(KI12042019, extent(shp8)), shp8)  

plot(KI12042019)
  plot(shp8, add=T)
  
  
#B1 blue
#B2 green
#B3 red
#B4 NIR
#B5 SWIR
#B6 panchromatic
#B7 TIRS

#as the human eye see it (red-green-blue)
plotRGB(KI12042019,4,3,2, stretch="lin")

#highlighting hot soil temperature in red (TIRS,r,b)
plotRGB(KI12042019,1,4,2, stretch="lin")

#highlight the burnt area (SWIR-NIR-red)
plotRGB(KI12042019,6,5,4, stretch="lin")

#####three plots highlighting different things (human eye, vegetation, burnt area) with Kangaroo Island isolated from the rest of the map####
par(mfrow=c(3,1))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI12042019,4,3,2, stretch="lin")
plotRGB(KI12042019,1,4,2, stretch="lin")
plotRGB(KI12042019,6,5,4, stretch="lin")


######NDVI#######
# Perform raster algebra to calculate a raster of NDVI values
#ndvi <- (infrared - red) / (infrared + red)  #I use NIR instead of infrared
ndvi8 <- (KI12042019$LC08_L1TP_098085_20190412_20190422_01_T1_B5 - KI12042019$LC08_L1TP_098085_20190412_20190422_01_T1_B4) / (KI12042019$LC08_L1TP_098085_20190412_20190422_01_T1_B5 + KI12042019$LC08_L1TP_098085_20190412_20190422_01_T1_B4)


#and once again I want to select only the island area
proj4string(ndvi8)
proj4string(shp8)

shp8 <- spTransform(shp8, proj4string(ndvi8)) 

plot(ndvi8)
  plot(shp8, add=T)

ndvi8 <- mask(crop(ndvi8, extent(shp8)), shp8)  

plot(ndvi8)
  plot(shp8, add=T)
  
# Plot the NDVI as a false-color image
palette = colorRampPalette(c("blue", "white", "red"))(256)
plot(ndvi8, col=palette)

#NDVI range is between -1 and +1
#hist(ndvi8, maxpixels = ncell(ndvi1))
#i see where to focus the range of colours to better enhance it
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi8, breaks=breaks, col=palette)
#################################
#################################

####################################################################################################################################
##############################################FINAL PLOTS##############################################
##########################################################################################################################################

#PLOT difference between years as human eye see it (red-green-blue)#
par(mfrow=c(3,3))
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plotRGB(KI08122019,4,3,2, stretch="lin")
plotRGB(KI09012020,4,3,2, stretch="lin")
plotRGB(KI14042020,4,3,2, stretch="lin")
plotRGB(KI05122018,4,3,2, stretch="lin")
plotRGB(KI06012019,4,3,2, stretch="lin")
plotRGB(KI12042019,4,3,2, stretch="lin")




#PLOT difference between years for temperature soil (TIRS,r,b)#
par(mfrow=c(3,3))
cl <- colorRampPalette(c('black','grey','light grey'))(100)
plotRGB(KI08122019,1,4,2, stretch="lin")
plotRGB(KI09012020,1,4,2, stretch="lin")
plotRGB(KI14042020,1,4,2, stretch="lin")
plotRGB(KI05122018,1,4,2, stretch="lin")
plotRGB(KI06012019,1,4,2, stretch="lin")
plotRGB(KI12042019,1,4,2, stretch="lin")


#PLOT difference between years to highlight burnt area (SWIR-NIR-red)#
par(mfrow=c(3,3))
cl <- colorRampPalette(c('black','grey','light grey'))(100)
plotRGB(KI08122019,6,5,4, stretch="lin")
plotRGB(KI09012020,6,5,4, stretch="lin")
plotRGB(KI14042020,6,5,4, stretch="lin")
plotRGB(KI05122018,6,5,4, stretch="lin")
plotRGB(KI06012019,6,5,4, stretch="lin")
plotRGB(KI12042019,6,5,4, stretch="lin")


#PLOT difference between years NDVI#
par(mfrow=c(3,3))
breaks <- seq(-0.4, 0.4, 0.1)
palette <- colorRampPalette(c("blue", "white", "red"))(8)
plot(ndvi1, breaks=breaks, col=palette)
plot(ndvi2, breaks=breaks, col=palette)
plot(ndvi4, breaks=breaks, col=palette)
plot(ndvi6, breaks=breaks, col=palette)
plot(ndvi7, breaks=breaks, col=palette)
plot(ndvi8, breaks=breaks, col=palette)


