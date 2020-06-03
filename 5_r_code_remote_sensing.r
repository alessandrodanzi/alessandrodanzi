###R code for remote sensing analysis##
#set the working directory
setwd("/Users/alessandro/lab")

#raster is useful for reading, writing, manipulating, analyzing and modeling of gridded spatial data (the format with pixels), name derives from rastrum=aratro
install.packages("raster")
#RStoolbox is a package for remote sensing image processing and analysis, such as calculating spectral indices, principal component transformation, unsupervised and supervised classification or fractional cover analyses.
install.packages("RStoolbox")
#make use of the library
library(raster)
#the satelite makes orbits called "paths" and covers the whole earth in 14-17 days.
#moreover, the "rows" that are parallel to the equator defines the points in the space

#to import images, the function is brick (to import a package of bands with different reflectance of pixels)
# the file.grd = grid, network of images
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#we use the function plot to make the plot of the image uploaded, we set the colours with the vector cl and make the final plot with those colors
plot(p224r63_2011)
cl <- colorRampPalette(c('black','grey','light grey'))(100) 
plot(p224r63_2011, col=cl)
 
#Bands of landsat
#B1: blue
#B2:green
#B3:red
#B4:NIR  #infrared

#multiframe of different plots
#par function is used to put multiple graphs in a single plot
#mfrow stays for multiframe rows
par(mfrow=c(2,2))
#2,2 means that we will have 4 plots in total divided in 2 rows and 2 columns.
#we do this because we will make a graph with the 4 colour bands

##for each colour band we set the colour palette with different shades and we plot the band (B1,B2,B3,B4) with those colours
#to do that and select the right band within the picture we use ‘$’ that refers and link to a specific column relative to a specific data frame.
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)                       

#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)

#exercise: make a graph with 4 plots on one column
#4,1 stays for 4 lines 1 column
#for the rest the exercise is the same as before
par(mfrow=c(4,1))
#B1:blue
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011$B1_sre, col=clb)                        #the $ is used to link

#B2: with but with green (B2) 
clg <- colorRampPalette(c('dark green','green','light green'))(100) 
plot(p224r63_2011$B2_sre, col=clg)

#B3: with but with red (B3) 
clr <- colorRampPalette(c('dark red','red','salmon'))(100) 
plot(p224r63_2011$B3_sre, col=clr)

#B4: with but with NIR (B4) 
cln <- colorRampPalette(c('red','orange','yellow'))(100) 
plot(p224r63_2011$B4_sre, col=cln)



#to plot the 3 bands together and see it how the human eye sees
#RGB (red green blue): B1: blue; B2:green; B3:red.
#stretch="Lin" stretch linear= to make a continuous between the colours
#every pixel is 30 km
#r=3, g=2, b=1 because from before
#Bands of landsat
#B1: blue
#B2:green
#B3:red
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#if we want to use the NIR we have anyway to use 3 components and so we need to shift the components
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#vegetation is becoming red, the pink part is more related to agricultural fields, white parts are open areas (deforestation)

#exercise NIR on top on g component of the RGB
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#now the vegetation is in green, dark green is the water in the forest/humidity while pink is the bear soil (agriculture)

#exercise NIR on top on b component of the RGB
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
#this time the agricultural area is in yellow (really visible in this way)
#############save workspace##################



##############Second day##################
#open saved workspace#

setwd("/Users/alessandro/lab") #mac
#ls() is the list function to see which packages we have already
ls()
#library to use the package (nice metaphor: "open the book that we want to read that we have on our bookshelf of packages installed")
library(raster)
#brick () function to create a multi-layer raster object. Image within brackets because importing it from the outside. We assign it to the vector
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plot(p224r63_1988)

#Exercise: plot in visible RGB 321 both images
#PlotRGB
#Bands of landsat
#B1: blue
#B2:green
#B3:red
#B4:NIR  #infrared

par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")

#Exercise false color RGB 432
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#How to see the noise(due to evapotraspiration, humidity and clouds)present in the image?
#Stretching more the colours and so enhancing the noise
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#PlotRGB
#Bands of landsat
#B1: blue
#B2:green
#B3:red:B3_sre
#B4:NIR  #infrared:B4_sre
#dvi=difference vegetation index
dvi2011<- p224r63_2011$B4_sre - p224r63_2011$B3_sre
#colors() to see the colours
cl <- colorRampPalette(c('firebrick4','tomato2','olivedrab4'))(100) 
plot(dvi2011, col=cl)

#Exercise dvi 1988
dvi1988<- p224r63_1988$B4_sre - p224r63_1988$B3_sre
#colors() to see the colours
cl <- colorRampPalette(c('firebrick4','lightsalmon1','darkolivegreen'))(100) 
plot(dvi1988, col=cl)

#Difference in time
diff <- dvi2011 - dvi1988
plot(diff)

#changing the grain(pixels)!
#when you change the dimension of the pixels you talk about resempling (res)
#fact=10 means that we are increasing 10 times the pixels
p224r63_2011res10<-aggregate(p224r63_2011, fact=10)
p224r63_2011res100<-aggregate(p224r63_2011, fact=100)

#Exercise same image, original, x10, x100
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res10, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011res100, r=4, g=3, b=2, stretch="Lin")
 
 
 
