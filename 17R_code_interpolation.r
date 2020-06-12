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

