### diversity measurement
setwd("/Users/alessandro/lab")
#to import the image#
snt <- brick("snt_r10.tif")

plot(snt)
#B1 blue
#B2 green
#B3 red
#B4 NIR

#R3 G2 B1
plotRGB(snt,3,2,1, stretch="lin")
#as human eye see it
#let's use the near infra red on top of red component
plotRGB(snt,4,3,2, stretch="lin")
#since vegetation is reflecting, we have the vegetation coloured in red

plotRGB(snt,3,2,1, stretch="lin")
plotRGB(snt,4,3,2, stretch="lin")

pairs(snt)
summary(sntpca$model)
plot(sntpca$map)

install.packages("RStoolbox")
library(raster)
library(RStoolbox) # this is for PCA
#PCA analysis
sntpca <- rasterPCA(snt)

plotRGB(sntpca$map, 1, 2, 3, stretch="lin")

window <- matrix(1, nrow = 5, ncol = 5)
sd_snt <- focal(sntpca$map$PC1, w=window, fun=sd)
cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(sd_snt, col=cl)

par(mfrow=c(1,2))
plotRGB(snt,4,3,2, stretch="lin")
plot(sd_snt, col=cl)
##################check from here###############################
# plot(std_snt8bit, col=cl)


std_sntr1 <- focal(snt_r$prova5_.1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(std_sntr1, col=cl)

### PCA related sd
library(RStoolbox)
sntrpca <- rasterPCA(snt_r)

summary(sntrpca$model) 



clp <- colorRampPalette(c('dark grey','grey','light gray'))(100) # 
plot(sntrpca$map,col=clp)

plotRGB(sntrpca$map,1,2,3,stretch="lin")

std_sntrpca <- focal(sntrpca$map$PC1, w=window, fun=sd)

cl <- colorRampPalette(c('dark blue','green','orange','red'))(100) # 
plot(std_sntrpca, col=cl)

##############day 2:cladonia########
setwd("/Users/alessandro/lab")
#with the raster library we have two function to import images: raster (1 layer) and brick (several layers)
#in this case we use the brick function because we already have in the file more than one layer
library(raster)
clad <- brick("cladonia_stellaris_calaita.JPG")
#to see our image in R:
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
#rename the library
library(RStoolbox)
#the function to do PCA is raster PCA of clad
cladpca <- rasterPCA(clad)
#we can use cladpca 
summary(cladpca$model)

plotRGB(cladpca$map, 1, 2, 3, stretch="lin")
#inside cladpca there's $map with PC1, PC2, PC3
#window(w) is the window we defined, while the function is standard deviation
sd_clad <- focal(cladpca$map$PC1, w=window, fun=sd)
#we aggregate to reduce the size of the layer PC1 to accelerate the calculation of the standard deviation
PC1_agg <- aggregate(cladpca$map$PC1, fact=10)
sd_clad_agg <- focal(PC1_agg, w=window, fun=sd)
#we try now to make it more evident
#par makes saveral graphs (in this case 2)
#col to change colours, total colours 100)
#we plot both the diversity on top of the original one, and the diversity on the aggregated pc1
par(mfrow=c(1,2))
cl <- colorRampPalette(c('yellow','violet','black'))(100) #
plot(sd_clad, col=cl)
plot(sd_clad_agg, col=cl)

#in this way we can see the plot of the variation in structure and the original image
# plot the calculation
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
