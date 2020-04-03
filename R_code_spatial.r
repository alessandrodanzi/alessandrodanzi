#R Code for spatial view of points

library(sp)       #because we already installed it last lesson.


data(meuse)       #is the data in this sp library.

head(meuse)     #to see the first 5 rows.

#coordinates
coordinates(meuse) = ~x+y      #to say to R that in the dataset meuse the coordinates are x and y

plot(meuse)

spplot(meuse, "zinc")    #to relate just to 1 variable and his legenda.

#Exercise: plot the spatial amount of copper
spplot(meuse, "copper")

#to change the title:
spplot(meuse, "copper", main="copper concentration")

#to change the size of the points instead of having different colors. 
bubble(meuse, "zinc")
bubble(meuse, "zinc", main="Zinc concentration")

###Exercise: bubble copper in red
bubble(meuse, "copper", col="red", main= "Copper concentration")


####Importing new data

#download file covid_agg.csv from our teaching site and put it into folder lab (no capital letters)

#setting the working directory (where data is coming from and going to)
#mac
setwd("/Users/alessandro/lab")

covid <- read.table("covid_agg.csv", head=T)  #where head=T or head=TRUE is when we have a first row with no numbers
head(covid)  #to show the first 5 rows

attach(covid)
plot(country, cases)  #where country is x and cases is y

#in case we dont do attach(covid) we need to write: plot(covid$country, covid$cases)

#we cannot see all the countries so we need to change the orientation inverting x and y
plot(country, cases, las=0)  #parallel labels
plot(country, cases, las=1)  #all the labels horizontal
plot(country, cases, las=2)  #perpendicular labels
plot(country, cases, las=3)  #vertical labels

#we want to reduce the size of the x axis labels
plot(country, cases, las=3, cex.axis=0.5)

#ggplot2 package
install.packages("ggplot2")
library(ggplot2)  #require(ggplot2) in both cases to make use of the package

#save the .RData under the menu file
###############MAC??########


#Load the previously data with double click on the file
#setting always the working directory (where data is coming from and going to)
#mac
setwd("/Users/alessandro/lab")

#load the previous RData
load("covid_workspace.RData")
ls()  #to see which files are uploaded

###Using ggplo2###
library(ggplot2) #require(ggplot2)

data(mpg)
head(mpg)
#key components: data, aes, geometry
#data in this case is mpg, we close both the () after x and y cuz the geometry is apart
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_line()
ggplot(mpg, aes(x=displ, y=hwy)) + geom_polygon()

#let's look at the covid data that we already have uploaded
head(covid)
#we will exagerate the size by the number of cases
ggplot(covid, aes(x=lon,y=lat, size=cases)) + geom_point()
