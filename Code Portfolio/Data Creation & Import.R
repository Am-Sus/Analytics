#DATA TYPES ==================== creating data types ####
#Numeric
x <- 10.5
class(x)

x<- 2
class(x)
is.integer(x) #all numbers are created as numeric unless expressly told

#Integer
x <- as.integer(3)
x
class(x)

#Affix L to a number to make it an integer
x <- 3L
class(x)
is.integer(x)

#All number types can be parsed for integer but character cannot
as.integer(3.79)
as.integer("3.99")

as.integer("Ama")

#Complex numbers
x <- 1+ 2i
class(x)

#Logical
x<- 2
y <- 3

z <- x>y
class(z)

#Character
x <- as.character(3.14)
class(x)
x

x <- "ama"
x
class(x)

#other forms of creating variables
sep()
rep()

#other forms of constructing strings
paste()
sprintf()
substr()
sub()

#VECRTORS: sequence of Data elements of same type ========== ####
x <- c(1,2,3) #composed of numeric

y<- c("aa", "bb", "cc") #character strings

x <- c(TRUE, FALSE, TRUE) #logical 

length(x)
length(c("aa", "bb", "cc"))

c(x,y) #coerces numeric to character

#VECTOR ARITHMETIC ============ ####
x <- c(1,2,3)

y <- c(4,5,6)

#addition 
y-x

#subtraction
x+y

#multilple
x*y

#division
y/x

#VECTOR INDEX ============== ####
y[3] #retrieve third element in y

y[-1] #removes first element and returns all others

y[5] #out of range returns NA


#QUIZ ================ 
#Q2
mean(Ozone$Observation.Count) #mean of coloumn Observation.count

#Q3
Ozone <- read.csv("US EPA data 2017.csv", header = T) #Q.3
ncol(Ozone)
nrow(Ozone)


#Q6
head(Ozone, 10)

#Q9
class(Ozone$Datum)

#Q10
library(tidyverse) #load library
names(Ozone) <- make.names(names(Ozone)) #### convert name format to x.x

unique(Ozone$State.Name) #check unique observations of a variable

#Little manipulation
ranking <- group_by(Ozone, State.Name, County.Name) %>% #group_by to sort by specific column names
  summarise(Ozone= mean(Ozone$Observation.Count)) %>% #summarise by means
  as.data.frame() %>% #present result as dataframe
  arrange(desc(Ozone))  #arrange in descending order



