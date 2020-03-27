###Multipanel in R. The second lesson of monitoring ecosystem

install.packages("sp")
install.packages("GGally")
library(sp)  #require(sp) do also the same action
library(GGally)
data(meuse)  #there is a dataset available called meuse
attach(meuse)

#EXERCISE: see the name of the variables and plot cadmium and zinc
meuse
plot(cadmium,zinc)

#There are 2 ways to see the names of the variable
names(meuse)
head(meuse)
#To change the charcater
pch=a number

plot(cadmium,zinc,pch=15,col="red",cex=2)

#Exercise: make all the paiwise possible plotsof the dataset)
#plo(x,cadmium)
#plot(x,zinc)
#plot,...
#no, plot is not a good idea!


pairs(meuse)

#code to switch from the whole varaiable to the 4 variable
pairs(~ cadmium + copper + lead + zinc, data=meuse)

pairs(meuse[,3:6])

#Exercise:prettify the graph
pairs(meuse[,3:6], pch=11, col="green", cex=0.7)


#GGally package with prettyfied graph
ggpairs(meuse[,3:6])
