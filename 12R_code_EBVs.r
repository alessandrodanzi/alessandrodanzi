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


###check from here###
sd_sntr <- focal(snt_r10$snt_r10.4, w=window, fun=sd)
sd_sntr <- focal(clad, w=window, fun=sd) 
clad
sd_sntr <- focal(clad[,1], w=window, fun=sd) 
sd_sntr <- focal(clad$cladonia_stellaris_calaita.1, w=window, fun=sd) 
plot(sd_sntr) 
cl <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(sd_sntr,col=cl) 
cl <- colorRampPalette(c('yellow','orange','violet'))(100) # 
plot(sd_sntr,col=cl) 
cl <- colorRampPalette(c('yellow','violet','black'))(100) # 
plot(sd_sntr,col=cl) 
clado <- stack(clad, sd_sntr)
plot(clado)
plot(clado,col=cl)
par(mfrow=c(1,2)) 
plotRGB(clad,3,2,1,stretch="lin")
plot(sd_sntr,col=cl) 
pdf("clad_enhancement.png")
par(mfrow=c(1,2)) 
plotRGB(clad,3,2,1,stretch="lin")
plot(sd_sntr,col=cl) 
dev.off()
q()

#####################
