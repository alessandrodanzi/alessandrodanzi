#Point Pattern Analysis: Density map

#install the library to develope this study
install.packages("spatstat")
library(spatstat)

attach(covid)
head(covid)

#covids= the name we gave to the covid spatial ppp=power point pattern, x=long(e-w), y=lat(n-s)
covids<- ppp(lon, lat, c(-180,180), c(-90,90))   #c(..) is needed to take all the numbers in account together

#let's associate d to the density of the covids data we just created
d<- density(covids)

#and create a plot of that density
plot(d)

#and we add the density to the plot, adding more to this function without closing the plot window (or we will delete the rest)
points(covids)
