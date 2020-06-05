#R_code_no2.r
#exercise on the reduction of no2 because of the lockdown due to covid19
#set the working directory within lab/no2
setwd("/Users/alessandro/lab/no2") #mac
#we can import through the lapply() function that applies a certain function to a list of files
#we need to create a list
rlist <- list.files(pattern="EN_00")
#rlist to see the files within it
#we can now make the stack function to connect the images on layers
#to do that we need the library(raster)
library(raster)
import <- lapply(rlist,raster)
EN <- stack(import)

cl <- colorRampPalette(c('blue','salmon','light green'))(100)
plot(EN, col=cl)
#the data comes from ESA sentinel


par(mfrow=c(1,2))
plot(EN$EN_0001, col=cl)
plot(EN$EN_0013, col=cl)

#let's try to make use of RGB
#B1 blue
#B2 green
#B3 red
#B4 NIR
plotRGB(EN, r=1, g=7, b=13, stretch="lin")
#if we have red values we have high values in the first image
#if we have blue values we have high values in the last image (13)
#if we have gren values we have high values in the mid period
#yellow in italy is a sum.. we had presence during the whole time

# close the window

#difference map (last vs first)
#last and first aren't always the best to compare, but interesting
dif<- EN$EN_0013 - EN$EN_0001
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cld)


#let's see the boxplot() function
#produce box and whisker (the lines) of a given data
boxplot(EN)
boxplot(EN, outline=F)
boxplot(EN,horizontal=T,outline=F)
#final boxplot
boxplot(EN,horizontal=T,axes=T,outline=F)

#we can plot the data of first and last image
#if i put first image(january) in the x and last (march) in the y i should highlit a decreasing
#most of the high values should be under the line 1:1 (diagonal from origin, or y=x)
plot(EN$EN_0001, EN$EN_0013)
#we can make the abline (y=x)
abline(0,1, col="red")

