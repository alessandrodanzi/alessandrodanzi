# R_code_exam.r

Indices
1. R_code_first (24)
2. R_code_multipanel (53)
3. R_code_spatial (104)
4. R_code_multivariate (192)
5. R_code_remote_sensing (235)
6. densitymap_point_pattern_analysis (407)
7.  R_code_ecosystem_functioning (478)
8.  R_code_PCA_remote_sensing (583)
9.  R_code_faPAR  (666)
10. R_code_radiance (701)
11. R_code_faPAR10 (752)
12. R_code_EBVs (817)
13. R_code_snow (914)
14. R_code_no2 (1068)
15. R_crop_an_image (1128)
16. notes_for_project (1145)
17. R_code_temp_interpolation (1172)
18. R_species_distribution_modelling (1252)


#1_R_code_first.r##################################################################################
####################################################################################
#the function install.packages is used to install something from outside (present in the CRAN) with the use of " "
install.packages("sp")
#sp is a package for spatial data
#library is to start using the data present in the package
library(sp)
#meuse is a dataset comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
data(meuse)

#let's see how the dataset meuse is structured, calling the name we can have the infos in r
meuse

#lets's look at the first rows of the set with the function head( )
head(meuse)

#let's plot two variables:
#let's see if the zinc is related to the one of the copper
#the function attach () connects the dataset to the r search path, so calling the name of an element we can have the infos
attach(meuse)
#the function plot( ) is the most generic and used function for plotting dataset
plot(zinc,copper)
#col is used to change the colour
plot(zinc,copper,col="green")
#pch is used to change the symbol
plot(zinc,copper,col="green",pch=19)
#cex is used to change the size of the symbol
plot(zinc,copper,col="green",pch=19,cex=2)

#2_R_code_multipanel.r##################################################################################
####################################################################################
###Multipanel in R. The second lesson of monitoring ecosystem
#sp is a package for spatial data
install.packages("sp")
#GGally is a package that extends 'ggplot2' by adding several functions to reduce the complexity of combining geometric objects with transformed data.
install.packages("GGally")
#library( ) function is to be able to start using the functions (install.packages is like buying a book, library is like taking the book out from the bookshelf to start reading it
library(sp)  #require(sp) do also the same action
library(GGally)
#meuse is provided by package sp. is a data set comprising of four heavy metals measured in the top soil in a flood plain along the river Meuse
#data( ) allow users to load datasets from packages for use it in the workspace
data(meuse)
#attach( ) is to connect the dataset to the r search path
attach(meuse)

#EXERCISE: see the name of the variables and plot cadmium and zinc
meuse
plot(cadmium,zinc)

#There are 2 ways to see the names of the variable
#names( ) is used to see the names of the different variables
names(meuse)
#head( ) is used to see the first rows of the dataset
head(meuse)
#pch=a number, to change the character
#col to change the colour
#cex to change the size of the character
plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise: make all the paiwise possible plots of the dataset)
#plo(x,cadmium)
#plot(x,zinc)
#plot,...
#no, plot is not a good idea!

#the function pairs( ) is used to produce a matrix of scatterplots
pairs(meuse)

#code to switch from the whole varaiable to the 4 variable
pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6])

#Exercise:prettify the graph changing the character, colour and size
pairs(meuse[,3:6], pch=11, col="green", cex=0.7)


#ggpairs( ) is a GGally package with prettyfied graph
ggpairs(meuse[,3:6])

#3_R_code_spatial.r##################################################################################
####################################################################################
#R Code for spatial view of points
#we don't need to install the package because we've already precedently done it, we just need to open it through the function library( )
library(sp)    

data(meuse)       #is the data in this sp library.

head(meuse)     #to see the first 5 rows.

#coordinates
#the function coordinates( ) is to say to R that in the dataset meuse the coordinates are x and y
coordinates(meuse) = ~x+y      
plot(meuse)
#spplot() is within lattice (trellis) plot methods for spatial data with attributes
spplot(meuse, "zinc")    #to relate just to 1 variable and his legenda.

#Exercise: plot the spatial amount of copper
spplot(meuse, "copper")

#to change the title we use the function "main":
spplot(meuse, "copper", main="copper concentration")

#the function bubble() results in a change in the size of the points (bigger for higher values) instead of having different colors. 
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")

###Exercise: bubble copper in red
bubble(meuse, "copper", col="red", main= "Copper concentration")


####Importing new data

#download file covid_agg.csv from our teaching site and put it into folder lab (no capital letters)

#setting the working directory (where data is coming from and going to)
#for mac setwd("/Users/yourname/lab")
setwd("/Users/alessandro/lab")
#the function read.table("covid_agg.csv", head=T) is to open and read the file, with "" because importing from outside
#<- is to assign to a vector
covid <- read.table("covid_agg.csv", head=T)  #where head=T or head=TRUE is when we have a first row with no numbers
#head of our new vector indicates the first 5 rows of the file
head(covid)  #to show the first 5 rows
#attach is once again used to access objects in the database by simply giving their names
attach(covid)
#in case we dont do attach(covid) we need to write: plot(covid$country, covid$cases)
plot(country, cases)  #where country is x and cases is y

#we cannot see all the countries so we need to change the orientation inverting x and y
plot(country, cases, las=0)  #parallel labels
plot(country, cases, las=1)  #all the labels horizontal
plot(country, cases, las=2)  #perpendicular labels
plot(country, cases, las=3)  #vertical labels

#we want to reduce the size of the x axis labels using cex.axis and assignin a value lower than 1
plot(country, cases, las=3, cex.axis=0.5)

#ggplot2 package
install.packages("ggplot2")
library(ggplot2)  #or function require(ggplot2). in both cases we start to make use of the package

#####save theworkspace as .RData under the menu file#####

#####Load the previously data with double click on the file in the lab folder
#OR
#Open r and set (ALWAYS) the working directory (where data is coming from and going to)
setwd("/Users/alessandro/lab") #mac
#load the previous RData
load("covid_workspace.RData")
#ls() is the function to check which files are uploaded
ls() 

###Using ggplo2###
library(ggplot2) #requireto have already install.packages("ggplot2")
#mpg is a dataset that contains a subset of the fuel economy data that the EPA
data(mpg) #to access to it
head(mpg) #to see the first 5 lines
#key components: data, aes, geometry
#data in this case is mpg, we close both the () after x and y cuz the geometry is by itself apart
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we already have uploaded
head(covid)
#we will exagerate the size by the number of cases
ggplot(covid, aes(x=lon,y=lat, size=cases)) + geom_point()

#4_R_code_multivariate##################################################################################
####################################################################################
###R code for multivariate analysis###

#Open R#
#set the working directory
setwd("/Users/alessandro/lab")  #mac
#The vegan package contains all common ordination methods: Principal component analysis, correspondence analysis, detrended correspondence analysis (decorana) and a wrapper for nonmetric multidimensional scaling (metaMDS)
#install the package
install.packages("vegan")
#access to the package
library(vegan)

#biomes is the name that we give(the vector assigned by the symbol <-), read.table is to analyze the data, "biomes.csv" is the name of the file, head=T because the first row is words, sep="," is the separator between the names of the words in the row (that the Professor used to create columns)
biomes<-read.table("biomes.csv",head=T,sep=",")

#to look at the dataset: head(biomes)or view(biomes)
head(biomes)

#multivariate analysis: decorana=detrended correspondence analysis
multivar<- decorana(biomes)

#we can then make the plot of the multivariate analysis
plot(multivar)

#we are now seeing the graph from 1 point of view, but we can see it from other (Dali' example)
#if we just put multivar, we see the analysis that happened
multivar
#eigenvalues= the percentage of data that we are able to see from this prospective
#we got DCA1=0.5117 DCA2=0.3036,  51%+30%=81%

#let's use other data to then sum up the same biomes
biomes_types <- read.table("biomes_types.csv", header=T, sep=",")
head(biomes_types)
attach(biomes_types)

#we make an ordiellipse that connects all the data. Multivar is the first name we gave.
ordiellipse(multivar,type, col=1:4, kind="ehull", lwd=3)
#we can put the color like this or col=c("green","orange","red","blue")

#to see the 'disk' of the biomes
ordispider(multivar, type, col=1:4, label = T)

#5_r_code_remote_sensing.r##################################################################################
####################################################################################
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

#6_densitymap_point_pattern_analysis.r##################################################################################
####################################################################################
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

#7_R_code_ecosystem_functioning##################################################################################
####################################################################################
#R code to view biomass over the world and calculate changes in ecosystem functioning

#energy
#chemical cycling
#proxies

#rasterdiv() function is useful to calculate indices of diversity on numerical matrices based on information theory.
install.packages("rasterdiv")
#rasterVis() function comprehend methods for enhanced visualization and interaction with raster data
install.packages("rasterVis")
#import the libraries
library(rasterVis)
library(rasterdiv)
#the input dataset is the Copernicus Long-term (1999-2017) average Normalise Difference Vegetation Index (copNDVI)
data(copNDVI)
plot(copNDVI)

#reclassify is a function that (re)classifies groups of values to other values
#cbind is to remove some data from the library that is not useful for us
#we assign it to the vector copNDVI through <- symbol
copNDVI<- reclassify(copNDVI, cbind(253:255,NA), right=TRUE)

#impressive function to impress your supervisor
levelplot(copNDVI)
#highlights the mean biomass over the last 20 years

#fact=10 (factor of 10) is aggregating 10 pixels in 1, so the new image has much visible boundaries beetween colours
#the number of pixel has to be select in relation to what we are trying to see, if it is possible to have less pixels with the same analysis results is better (the file will be smaller in size)
copNDVI10<- aggregate (copNDVI,fact=10)
levelplot(copNDVI10)

#let's try 100x100 pixels in one
copNDVI100<- aggregate (copNDVI,fact=100)
levelplot(copNDVI100)


##########################statistics: code for making plots from maps###########################
library(ggplot2)
library(RStoolbox)
 
#colorRampPalette contains functions that are useful for converting hand-designed `sequential' or `diverging' color schemes into continous color ramps eg for image and filled contour plots.
myPalette <- colorRampPalette(c('white','green','dark green'))
#scale_colour_gradientn is used to smooth colour gradient between n colours
sc <- scale_colour_gradientn(colours = myPalette(100), limits=c(1, 8))

 

ggR(copNDVI, geom_raster = TRUE) + scale_fill_gradientn(name = "NDVI", colours = myPalette(100))+ labs(x="Longitude",y="Latitude", fill="")+ theme(legend.position = "bottom") + NULL
#impressive function to impress your supervisor
#impressive function to impress your supervisor

##################################################################################

#working on images about the deforestation in the Amazon forest
setwd("/Users/alessandro/lab")  #mac
library(raster)
#uploading the two different images, brick() function to create a RasterBrick (multiple layers)
defor1 <- brick("defor1_.jpg")
defor2 <- brick("defor2_.jpg")

#band1: NIR
#band2: red
#band3: green
#making the plot of the two images separately, selecting the bands, stretch to make a better passage between colours
plotRGB(defor1, r=1, g=2,b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#to see the two images one next to the other we use the par() function with multiframe by rows (1 line, 2 columns)
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#if you write defor1 on R you look at the names that correspond to the 3 bands
#names: defor1_.1,  defor1_.2,  defor1_.3

#band1: NIR    defor1_.1
#band2: red    defor1_.2
#dvi=difference vegetation index. 
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2
 
 
 #same for defor2
 #names      : defor2_.1, defor2_.2, defor2_.3 
 #band1: NIR    defor2_.1
 #band2: red     defor2_.2
 
 dvi2 <- defor2$defor2_.1 - defor2$defor2_.2

#we create the palette with the colours that we think more useful to highlight our data
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
#to see the two images one next to the other we use the par() function with multiframe by rows (1 line, 2 columns) 
par(mfrow=c(1,2))
plot(dvi1, col=cl)
plot(dvi2, col=cl)

difdvi<- dvi1 - dvi2

dev.off() #to close what we opened before
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)
#hist() function computes a histogram of the given data values
hist(difdvi)

#8_r_code_pca_remote_sensing.R.##################################################################################
####################################################################################
setwd("/Users/alessandro/lab") #mac

#install.packages("RStoolbox") if not previously done
#library to open the necessary ones already installed
library(raster)
library(RStoolbox)
library(ggplot2)

# brick to import images
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#we use plotRGB
#b1 blue
#b2 green
#b3 red
#b4 NIR
#b5 SWIR (short wave infrared)
#infrared has 3 parts: one close to red, one in other place, one as thermal infrared.
#b6 thermal infrar
#b7 SWIR
#b8 panchromatic

#RGB:
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 
#ggRGB calculates RGB color composite raster for plotting with ggplot2
ggRGB(p224r63_2011,5,4,3)

#same for 1988
p224r63_1988 <- brick("p224r63_1988_masked.grd")
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") 

#to have it all together in one image with 1 row and 2 columns we use par() multiframe
par(mfrow=c(1,2))
plotRGB(p224r63_1988, r=5, g=4, b=3, stretch="Lin") 
plotRGB(p224r63_2011, r=5, g=4, b=3, stretch="Lin") 
#pink part increased due to loss of forest consequent to increasing in agriculture

#how to plot all the bands to see all the information together?
names(p224r63_2011)   #to know the names of the images in that file
#we are going, through $, to correlate the bands to the image
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre)

#p224r63_2011    #gives us the number of data that is 4 million, we need to decrease the size of the file, it's too heavy!
#dimensions : 1499, 2967, 4447533, 7  (nrow, ncol, ncell, nlayers)

#decrease the resolution to 10 times smaller. res=resempling the resolution, fact=10 because we are decreasing it by a factor of 10
p224r63_2011_res <- aggregate(p224r63_2011, fact=10)

#library(RStoolbox) is now needed...
#rasterPCA function calculates R-mode PCA (Principal Component Analysis) for RasterBricks or RasterStacks and returns a RasterBrick with multiple layers of PCA scores
#PCA is useful to uncover relationships among many variables (as found in a set of raster maps in a map list) and to reduce the amount of data needed to define the relationships
p224r63_2011_pca <- rasterPCA(p224r63_2011_res)

#we want to plot the map
plot(p224r63_2011_pca$map)

#we set our colour palette and plot with the map from 2011
cl <- colorRampPalette(c('dark grey','grey','light grey'))(100) # 
plot(p224r63_2011_pca$map, col=cl)

summary(p224r63_2011_pca$map, col=cl)

pairs(p224r63_2011)

plotRGB(p224r63_2011_pca$map, r=1, g=2, b=3, stretch="Lin")

#we do the same for 1988
p224r63_1988_res <- aggregate(p224r63_1988, fact=10)
p224r63_1988_pca <- rasterPCA(p224r63_1988_res) 
plot(p224r63_1988_pca$map, col=cl)
summary(p224r63_1988_pca$model)
pairs(p224r63_1988)

#operating then the difference to highlight the changes
difpca <- p224r63_2011_pca$map - p224r63_1988_pca$map
plot(difpca)

#final plot (impressive!)
cldif <- colorRampPalette(c('blue','black','yellow'))(100) # 
plot(difpca$PC1, col=cldif)

#9_R_code_faPAR.r##################################################################################
####################################################################################
#how to look at chemical things by satellite images

setwd("/Users/alessandro/lab") #mac
#not needed to install packages because previously used, just open it with library() function
library(raster)
library(rasterVis)
library(rasterdiv)

#we also use copNDVI (copernicus NDVI) NDVI= works with layers of reflectance
#plants: high reflectance in NIR and low in RED
#no plants: lower NIR higher RED
#let's have a look to the Copernicus image by plotting it
plot(copNDVI)
#reclassify() function (re)classifies groups of values to other values
#cbind() function combines vector, matrix or data frame by columns
#we assign it to the vector copNDVI
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
levelplot(copNDVI)
#levelplot makes the average of the values on the orizontal and on the vertical line of pixels and shows it as graph on the side of the graph
#faPAR is the Fraction of Absorbed Photosynthetically Active Radiation ( = fraction of the solar radiation absorbed by live leaves for the photosynthesis activity)
faPAR10 <- raster("faPAR10.tif")  #raster to import the data. 10 because used a factor of 10 to aggregate the pixels
levelplot(faPAR10)
#we have less values on the northern side rather than equator because now we are taking into account the photosynthetic activity

#save as pdf
pdf("copNDVI.pdf")
levelplot(copNDVI)
dev.off()

pdf("faPAR10.pdf")
levelplot(faPAR10)
dev.off()

#10_R_code_radiance.r#################################################################################
####################################################################################
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

#11_faPAR10.r#################################################################################
####################################################################################
#set working directory
setwd("/Users/alessandro/lab") #mac

#the original faPAR from Copernicus is 2 GB, let's see how smaller is the file faPAR10
load("faPAR.RData")
#ls() function to list the datasets we have
ls()
#as usual we open the libraries
library (raster)
library (rasterdiv)

#we use writeRaster() function to write a file
#.tif file is an image saved in a high-quality graphics format. It is often used for storing images with many colors, typically digital photos, and includes support for layers and multiple pages
writeRaster(copNDVI, "copNDVI.tif")

###exercise###
library(rasterVis)
#faPAR:levelplot this set
levelplot(faPAR10)

###regression model between faPAR and NDVI###
#we start with 2 variables: erosion of soil (kg / m2) and heavy metals (ppm)
erosion <- c(12, 14, 16, 24, 26, 40, 55, 67)
hm <- c(30, 100, 150, 200, 260, 340, 460, 600)

#let's plot the two variables. pch (point character)= is the simbol, depends on the number we assign it (lists online)
plot(erosion, hm, col="red", pch=19, xlab="erosion", ylab="heavy metals", cex=2)
#we assign to the vector model1 the linear model of the relation between the two variables through the function lm()
model1 <- lm(hm ~ erosion) 
summary(model1)
#y=bx+a, intercept in summary means a, y is hm, x is erosion, b is the slope)
#R-squared is higher when the relation between the variables is higher (far from being random)
#p-values means how many times is a random situation. p<0.01 means that there's a probability lower than one over hundred times that it is a random situation
#abline() function can be used to add vertical, horizontal or regression lines to a graph
abline (model1)
##########################################################################
setwd("/Users/alessandro/lab")
library(raster)
library(rasterVis)
faPAR10 <- raster("/Users/alessandro/lab/faPAR10.tif")
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

#12R_code_EBVs.r#################################################################################
####################################################################################
### diversity measurement
setwd("/Users/alessandro/lab") #mac
install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA
#PCA analysis
sntpca <- rasterPCA(snt)

#to import the image we use the brick() function and we assign it at the vector snt
snt <- brick("snt_r10.tif")

plot(snt)
#B1 blue
#B2 green
#B3 red
#B4 NIR

#R3 G2 B1
#to make it as human eye see it
plotRGB(snt,3,2,1, stretch="lin")

#let's use the near infra red on top of red component
plotRGB(snt,4,3,2, stretch="lin")
#since vegetation is reflecting, we have the vegetation coloured in red

#pairs() function produce a matrix of scatterplots
pairs(snt)
summary(sntpca$model) #Summary (or descriptive) statistics are the first figures used to represent nearly every dataset
plot(sntpca$map)

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

#matrix() function creates a matrix from the given set of values
#window is the vector associated to the matrix
window <- matrix(1, nrow = 5, ncol = 5)
#focal() function uses values in a neighborhood of cells around a focal cell, and computes a value that is stored in the focal cell of the output RasterLayer (in this case the standard deviation)
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)
#we can then show the two plots in 1 line 2 columns on the same graphic image through:
par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin")
plot(sd_snt, col=cl)
#################################################

##############day 2:cladonia###########
setwd("/Users/alessandro/lab")
#with the raster library we have two function to import images: raster (1 layer) and brick (several layers)
#in this case we use the brick function because we already have in the file more than one layer
library(raster)
clad <- brick("cladonia_stellaris_calaita.JPG")
#to see our image in R as the human eye see it:
plotRGB(clad, 1,2,3, stretch="lin")
#window to select one window, calculate the SD and report the SD in one pixel, then the whole window shifts and report the SD in the pixel next to the other and so on
#number 1 is an arbitriry value.
window <- matrix(1, nrow = 3, ncol = 3)
window
#selected the size of the window, we do the calculation
#we use focal function that calculate the values of several local cells
#the clads are related (one line connect them) 
pairs(clad)

#we use the PCA
#PCA = Principal component analysis (PCA) is a technique for reducing the dimensionality of such datasets, increasing interpretability but at the same time minimizing information loss. It does so by creating new uncorrelated variables that successively maximize variance
#open the library
library(RStoolbox)
#the function to do PCA is raster PCA of clad
cladpca <- rasterPCA(clad)
#we can use cladpca as vector
summary(cladpca$model)

#inside cladpca there's $map with PC1, PC2, PC3
plotRGB(cladpca$map, 1, 2, 3, stretch="lin")
#window(w) is the window we defined, while the function is standard deviation
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
#we aggregate to reduce the size of the layer PC1 to accelerate the calculation of the standard deviation
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)
#we try now to make it more evident
#par is to make saveral graphs (in this case 2)
#col to change colours, total colours (100)
#we plot both the diversity on top of the original one, and the diversity on the aggregated pc1
#we obtaing a figure with one row and 2 columns with the 2 plots (aggregated and not)
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

#in this way we can instead see the plot of the variation in structure and the original image
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plotRGB(clad, 1,2,3, stretch="lin")
plot(sd_clad, col=cl)
# plot(sd_clad_agg, col=cl)

#13_R_code_snow.r#################################################################################
####################################################################################
# R_code_snow.r
#1st set the working directory to the folder snow in the folder lab instead of the usual setwd("/Users/alessandro/lab")
#we create a folder within the folder lab because we will use the function lapply() to search files that comprehend the name within the folder.
#in this case we don't have other files named snow but it's better to know this
setwd("/Users/alessandro/lab/snow")

#we will use raster library and ncdf4(interface with netcdf data, some sort of .tif). Since most of the copernicus are based on nCDF we need to import this library (sometimes is comprehended in raster).
#once installed we can launch the libraries in R
install.packages("ncdf4")

library(ncdf4)
library(raster)
#we import our file and associate it to snowmay vector
snowmay <-raster("c_gls_SCE_202005280000_NHEMI_VIIRS_V1.0.1.nc")
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 


#### Exercise: plot snow cover with the cl palette ####
plot(snowmay,col=cl)

#one simple but slow manner to import the set is: raster("snow2000r.tif") and associate it to the vector snow2000 and so on for every year
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
#this is one of the ways to import the graphs but implies many lines of code!
#(20 lines to do the job)
#the next function is a quicker way to import all the images

# lapply() is useful to apply a function to a list of vectors
#first of all we need to make the list of files that we want to use
#the function is list.files, it will only make the list of all the files with a certain pattern in a certain place
#in our case our files all include snow20 in the name
rlist <- list.files(pattern="snow20")
#rlist to see the files within it
#we can now make the stack function to connect the images on layers
import <- lapply(rlist,raster)
snow.multitemp <- stack(import)
#launch snow.multitemp to see the object
#at this point we can plot the whole vector snow.multitemp with the col=cl
plot(snow.multitemp, col=cl)
 

##save raster into list
##with lappy
# list_rast=lapply(rlist, raster)
# EN <- stack(list_rast)
# plot(EN)

rlist <- list.files(pattern="snow20")
rlist 

#we can now operate applying a linear regression to see the tendency of the reduction of snow during the years and predict the value for 2025


############# prediction #############
require(raster)
require(rgdal)

# define the extent: 180=extent of data, 90=extent of latitude
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

##########################Day 2#######################
setwd("/Users/alessandro/lab/snow")  #mac
#Exercise: import all of the snow cover images all together
library(ncdf4)
library(raster)
rlist <- list.files(pattern="snow20")
#lapply once again applies a certain function to a list
import <- lapply(rlist,raster)
#stack() function connect several images together in one single image
snow.multitemp <- stack(import)
snow.multitemp  #to see the result
cl <- colorRampPalette(c('darkblue','blue','light blue'))(100) 
plot(snow.multitemp, col=cl)

#we can now use the heavy image of the prediction for 2025 calculated last time 
#load("predicted.2025.norm.tif")
#or import from IOL
#we import the image with raster(). if we needed to import more bands we would have used brick() function
raster("predicted.2025.norm.tif")
prediction <- raster("predicted.2025.norm.tif")
plot(prediction, col=cl)
#how to export the prediction output?
#writeRaster() function is writing the entire raster object to a file that we choose (creating a new data)
#the final output will be named final.tif
writeRaster(prediction, "final.tif")
#i can also make a pdf of the graph
#final stack (=sum of all the images/inputs)
#snow.multitemp was already a stack
final.stack<- stack(snow.multitemp,prediction)
plot(final.stack, col=cl)
#export now the R graph for the thesis
pdf("my_final_exciting_graph.pdf")
plot(final.stack, col=cl)
dev.off()
#export as png
png("my_final_exciting_graph.png")
plot(final.stack, col=cl)
dev.off()
#we can even choose the resolution by the dimension or the number of pixels

#14_R_code_no2.r#################################################################################
####################################################################################
#R_code_no2.r
#exercise on the reduction of no2 because of the lockdown due to covid19
#set the working directory within lab/no2
setwd("/Users/alessandro/lab/no2") #mac
#we can import through the lapply() function that applies a certain function to a list of files
#we need to create a list
rlist <- list.files(pattern="EN_00")
#rlist to see the files within it
#we can now make the stack function to connect the images on layers
#to do that we need the library(raster)
library(raster)
import <- lapply(rlist,raster)
EN <- stack(import)

cl <- colorRampPalette(c('blue','salmon','light green'))(100)
plot(EN, col=cl)
#the data comes from ESA sentinel


par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#let's try to make use of RGB
#B1 blue
#B2 green
#B3 red
#B4 NIR
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
#if we have red values we have high values in the first image
#if we have blue values we have high values in the last image (13)
#if we have gren values we have high values in the mid period
#yellow in italy is a sum.. we had presence during the whole time

# close the window

#difference map (last vs first)
#last and first aren't always the best to compare, but interesting
dif<- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cld)


#let's see the boxplot() function
#produce box and whisker (the lines) of a given data
boxplot(EN)
boxplot(EN, outline=F)
boxplot(EN,horizontal=T,outline=F)
#final boxplot
boxplot(EN,horizontal=T,axes=T,outline=F)

#we can plot the data of first and last image
#if i put first image(january) in the x and last (march) in the y i should highlit a decreasing
#most of the high values should be under the line 1:1 (diagonal from origin, or y=x)
plot(EN$EN_0001, EN$EN_0013)
#we can make the abline (y=x)
abline(0,1, col="red")

#15_R_crop_an_image.r#################################################################################
####################################################################################
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

#16_notes_for_project#################################################################################
####################################################################################
#Copernicus dataset
#4 main areas
#sentinel2: satellite with resolution of 10m
#VEGETATION
#LAI=leaf area index. the higher it is the higher is the photosynthesis
#FCOVER is related. An idea for the exam is to see the correlation of the variables during the same day
#FAPAR: how much of the radiation from the sun is retained by plants to do photosynthesis
#NDVI: different vegetation index (NIR reflecting and red absorbing. normalized index is difference between them)
#VCI= vegetation condition, if you have temporal changes. 
#VPI=vegetation productivity index. how much vegetation is producing (agricultual power), both biomass and fruits
#Dry matter: biomass without the water. idea of how much the vegetation is growing
#burnt area: both human related and natural.
#soil water index: measures the moisture of soil. 
#surface soil moisture: only in the very first part of soil horizon, important for first new colonization
#3 variables for ENERGY: albedo, reflectance, soil temperature
#WATER CYCLE: 
#surface water temperature, 
#water quality (amount of nutrients, clorophyll, ...) 
#water bodies (inland water) max and min extent, seasonal dynamics
#water level (hight of the water respect to sealevel)
#CRYOSPHERE:
#lake ice extent
#snow cover
#snow water equivalent

#17R_code_interpolation.r#################################################################################
####################################################################################
#interpolation: using data that we measured in the field (Martina Viti bachelor' thesis)
setwd("/Users/alessandro/lab") #mac
install.packages("spatstat")
## Interpolation: spatstat library
# library(dbmss)
library(spatstat)

#we are going to import the data. it is just a table (no raster, no brick)
#; is for the semi-column, each column has an header so is TRUE
inp <- read.table("dati_plot55_LAST3.csv", sep=";", head=T)

#let's proceed estimating the rest of the canopy cover where there's no data
#attach is to start working with the dataset
attach(inp)
plot(X,Y)

#to know minimum and maximum of X and Y
summary(inp)
#ppp() function we are going to assign what are X, Y and the range
inppp <- ppp(x=X,y=Y,c(716000,718000),c(4859000,4861000))

#we can proceed using it to estimate the canopy cover, but we first use marks() function to lable the single point with the data we want
#we put into the inppp the canopy cover (how is it called? function names(inp) to know it)
names(inp)
marks(inppp) <- Canopy.cov
#we don't need to use $ to select the column because we attached the file
#Smooth() function is from library(spatstat). Allows us to interpolate data where we don't have it.
#it calculates the values in between two given points and then the one between the one created and the one given and so on.
canopy <- Smooth(inppp)
plot(canopy)
points(inppp, col="green")

#we can measure the lichens on the tree and see how much they are covering them
marks(inppp) <- cop.lich.mean
lichs <- Smooth(inppp)
plot(lichs)
points(inppp)

#we make use of the par function to show our plots in one image
par(mfrow=c(1,3))
plot(canopy)
points(inppp)
plot(lichs)
points(inppp)

#we can also make a final plot
plot(Canopy.cov, cop.lich.mean, col="red", pch=19, cex=2)
########################################################

# Data psammophilus species Giacomo
#psammophilus means that are adapted to arid environments (sand dunes)
#as before we have a file that is just a table (no need to use raster or brick)
inp.psam <- read.table("dati_psammofile.csv", sep=";", head=T)

attach(inp.psam)
#have a look to the dataset
head(inp.psam)
summary(inp.psam)
#C.org is the amount of carbon. the higher it is the higher the amount of organisms

#let's see the point in space through the function 
plot(E,N)
#spatstat doesn't work well with spaces between different groups of data (if some sampling are far from each other)

#the range of different points x=east and y=north.
#to know the range summary(inp.psam). we use a bit of a larger area
inp.psam.ppp <- ppp(x=E,y=N,c(356450,372240),c(5059800,5064150))
#second step is to explain the variable we are going to use.
#C.org is the amount of carbon. the higher it is the higher the amount of organisms
#marks() function to lable the single point with the data we want
marks(inp.psam.ppp) <- C_org
#once again Smooth() function to calculate the means between points
C <- Smooth(inp.psam.ppp)
plot(C)
points(inp.psam.ppp)

#this is the idea to implement measured data to other parts not sampled

#18R_species_distribution_modelling.r#################################################################################
####################################################################################
install.packages("sdm")
library(sdm)
library(raster) #prediction
library(rgdal) #species

# species
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)

species
species$Occurrence
plot(species)

#occurrence=1 we only have the presence
plot(species[species$Occurrence == 1,],col='blue',pch=16)
#occurrence=0 is the absence
points(species[species$Occurrence == 0,],col='red',pch=16)

#predictors
# environmental variables
path <- system.file("external", package="sdm") 
#path because assigned as vector, pattern to recall something shared from the files (asc is an extention)
#lst=list
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst
#we can make a stack (connecting different files in one
preds <- stack(lst)

cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

plot(preds$elevation, col=cl)
#occurrence=1 we only have the presence
points(species[species$Occurrence == 1,], pch=16)
#occurrence=0 is the absence
points(species[species$Occurrence == 0,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# model

d <- sdmData(train=species, predictors=preds)
d

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=d, methods='glm') 
p1 <- predict(m1, newdata=preds)

plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)
