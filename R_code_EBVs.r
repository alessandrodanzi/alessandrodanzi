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
#################################################
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

##############
