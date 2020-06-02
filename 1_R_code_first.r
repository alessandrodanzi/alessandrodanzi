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

