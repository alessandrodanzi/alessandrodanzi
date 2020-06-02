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
