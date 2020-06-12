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
