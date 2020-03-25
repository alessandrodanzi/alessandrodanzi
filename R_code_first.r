install.packages("sp")

library(sp)

data(meuse)

#let's see how the dataset meuse is structured:
meuse

#lets's look at the first row of the set
head(meuse)

#let's plot two variables:
#let's see if the zinc is related to the one of the copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="green")
plot(zinc,copper,col="green",pch=19)
plot(zinc,copper,col="green",pch=19,cex=2)

