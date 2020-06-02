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
