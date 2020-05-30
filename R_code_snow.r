# R_code_snow.r

setwd("/Users/alessandro/lab")
# setwd("/Users/utente/lab") #mac
# setwd("C:/lab/") # windows

install.packages("ncdf4")
#we will use raster library and ncdf4(interface with netcdf data, some sort of .tif).Since most of the copernicus are based on nCDF we need to import this library (sometimes is comprehended in raster).
#once installed we can launch the libraries in R
library(ncdf4)
library(raster)
#we import our file and associate it to snowmay vector
snowmay <-raster("c_gls_SCE_202005280000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 

# Exercise: plot snow cover with the cl palette
plot(snowmay,col=cl)

#Slow manners to import the set
#1st set the working directory to the folder snow in the folder lab
setwd("/Users/alessandro/lab/snow")
#one simple manner to import is: raster("snow2000r.tif") and associate it to the vector snow2000
snow2000 <- raster("snow2000r.tif")
snow2005 <- raster("snow2005r.tif")
snow2010 <- raster("snow2010r.tif")
snow2015 <- raster("snow2015r.tif")
snow2020 <- raster("snow2020r.tif")

#we can at this point put the PAR
#par(mfrow=c(1,2).. means that we are going to make 1 row with 2 graphs.mf=multy frame
par(mfrow=c(2,3)) #we cannot do 1,5 because it's too many in one row)
plot(snow2000,col=cl)
plot(snow2005,col=cl)
plot(snow2010,col=cl)
plot(snow2015,col=cl)
plot(snow2020,col=cl)
#this is one of the ways to import the graphs but implies many lines!
#(20 lines to do the job)
#the next function is a quicker way to import all the images

# lapply() is useful to apply a function to a list of vectors
#first of all we need to make the list of files that we want to use
#the function is list.files, it will only make the list of all the files with a certain pattern in a certain place
#in our case our files all include snow20 in the name
rlist <- list.files(pattern="snow20")
#rlist to see the files within it
import <- lapply(rlist, raster)
#we can now make the stack function to connect the images on layers
import <- lapply(rlist,raster)
snow.multitemp <- stack(import)
#snow.multitemp to see the object
#at this point we can plot the whole vector snow.multitemp with the col=cl
plot(snow.multitemp, col=cl)
 

##save raster into list
##con lappy
# list_rast=lapply(rlist, raster)
# EN <- stack(list_rast)
# plot(EN)

rlist <- list.files(pattern="snow20")
rlist 

#we can now operate applying a linear regression to see the tendency of the reduction of snow during the years and predict the value for 2025
############# prediction #############

require(raster)
require(rgdal)

# define the extent 180:extent of data, 90:extent of latitude
ext <- c(-180, 180, -90, 90)
extension <- crop(snow.multitemp, ext)
    
# make a time variable (to be used in regression)
time <- 1:nlayers(snow.multitemp)

# run the regression
fun <- function(x) {if (is.na(x[1])){ NA } else {lm(x ~ time)$coefficients[2] }} 
predicted.snow.2025 <- calc(extension, fun) # time consuming: make a pause!
predicted.snow.2025.norm <- predicted.snow.2025*255/53.90828
#255 because 8bit means 2 elevated8
###############################################
#we take all the precedent prediction saving the file prediction.r in the folder snow within the folder laband launching the code source("prediction.r")
source("prediction.r")

#save raster into list
#con lappy
list_rast <- lapply(rlist, raster)
snow.multitemp <- stack(list_rast)
plot(snow.multitemp,col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl)
plot(snow.multitemp$snow2020r, col=cl)

par(mfrow=c(1,2))
plot(snow.multitemp$snow2000r, col=cl, zlim=c(0,250))
plot(snow.multitemp$snow2020r, col=cl, zlim=c(0,250))

difsnow = snow.multitemp$snow2020r - snow.multitemp$snow2000r
cldiff <- colorRampPalette(c('blue','white','red'))(100) 
plot(difsnow, col=cldiff)

# prediction
# go to IOL and downloand prediction.r into the folder snow
# source("prediction.r")
# plot(predicted.snow.2025.norm, col=cl)
# since the code needs time, you can ddownload predicted.snow.2025.norm.tif from iol in the Data

predicted.snow.2025.norm <- raster("predicted.snow.2025.norm.tif")
plot(predicted.snow.2025.norm, col=cl)
