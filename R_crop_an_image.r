##################################
setwd("/Users/alessandro/lab")
install.packages("ncdf4")
library(raster)
library(ncdf4)
snow <- raster("c_gls_SCE_202005280000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100)
#better version:using coordinates
ext <- c(0, 20, 35, 50)
zoom(snow, ext=ext)
 ####
#let's crop the image
snowitaly <- crop(snow, ext)
#you can also use drawextent
zoom(snow, ext=drawExtent())
 
