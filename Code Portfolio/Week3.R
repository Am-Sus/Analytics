Ozone <- read.csv("US EPA data 2017.csv", header = T)
colSums(is.na(Ozone))

data("mtcars")
mean(mtcars$mpg)
IQR(mtcars$mpg)
mad(mtcars$mpg)
sd(mtcars$mpg)
class(mpg$hwy)
install.packages("matrixStats")
library(matrixStats)

mean(mtcars$mpg, trim = 0.1)
median(mtcars$mpg)
weighted.mean(mtcars$mpg, w=mtcars$wt)
weightedMean(mtcars$mpg, w=mtcars$wt)
weightedMedian(mtcars$mpg, w=mtcars$wt)

library(tidyverse)

ggplot(mpg, aes(x=displ, y=hwy))+
  geom_point(shape=24, colour="black", fill="red", size=3)

data=iris
iris %>%
  filter(Petal.Length>4.5) %>%
  group_by(Species)%>%
  summarise(mean(Sepal.Length), sd(Sepal.Width), max(Petal.Length))
  
mean(x$Sepal.Length)

y <- x[15:63,]

mean(y$Sepal.Length)
sd(y$Sepal.Width)
max(y$Petal.Length)
y
flights
library(nycflights13)
flights %>%
  filter(flights$month ==6)
28243+27004

data("diamonds")
library(data.table)

diamonds %>%
  group_by(color) %>%
  summarise(count=n())

data("faithful")
x <- quantile(faithful$eruptions, p=c(.05, .25, .5, .75, .95))
round(x,2)

data("who")
who

