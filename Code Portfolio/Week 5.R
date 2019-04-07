#Create dataframe ####
#Using vectors to create a dataframe
Sale <- data.frame(name = c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"),
                    color = c("black", "green", "pink", "blue", "blue", 
                              "green", "green", "yellow", "black", "black"),
                    age = c(143, 53, 356, 23, 647, 24, 532, 43, 66, 86),
                    price = c(53, 87, 54, 66, 264, 32, 532, 58, 99, 132),
                    cost = c(52, 80, 20, 100, 189, 12, 520, 68, 80, 100),
                    stringsAsFactors = FALSE)   # Don't convert strings to factors!


#Explore the data ####
head(Sale)    #Show first few rows
str(Sale)     #Structure of data
View(Sale)    #Open data as table in new window
names(Sale)   #show names of columns
nrow(Sale)    #How many rows
ncol(Sale)    #How many columns

#Minor manipulations ####
Sale[3]
Sale[3,]
Sale[1:3]
Sale[1,3]
Sale[[3]]


#Create a List ####
ex_list <- list(
  a = c(1:4),
  b = TRUE,
  c = "Hello!",
  d = function(arg = 42){print("Hello World!")},
  e <- diag(5)
)

#Calling elements from the list ####
View(ex_list)
ex_list[1]
ex_list$b
ex_list[[1]]
ex_list[1]

# Creating a matrix ####
matrix(c(35, 30, 27, 24, 19), nrow = 5, ncol = 3)  #ncol & nrow specifies no of rows and columns


##Chapter 8 Excercise ####
Pirates <- data.frame(
  name = c("Astrid", "Lea", "Sarina", "Remon", "Letizia", "Babice", "Jonas", "Wendy", "Niveditha", "Gioia"),
  Sex = c("F", "F", "F", "M", "F", "F", "M", "F", "F", "F"),
  Age = c(30,25,25,29,22,22,35,19,32,21), 
  Superhero = c("Batman", "Superman", "Batman", "Spiderman", "Batman", "Antman", "Batman", "Superman", "Maggott", "Superman"),
  Tattoo = c(11,15,12,5,65,3,9,13,900,0), 
  stringsAsFactors = FALSE)

#Q.2
median(Pirates$Age) #Median of age

#Q3
tapply(Pirates$Age, Pirates$Sex, median) #mean of F & M separetely #Mean of age

#Q4
mode(Pirates$Tattoo) #Mode of Tattoo

#Q5
(length(which(Pirates$Age<32))/10)*100 #percent of pirates under 32

group_by(Pirates, Sex) %>% transmute(Age<32, percent = count(count(Age<32))/count(Age))

group_by(df, group) %>% transmute(subgroup, percent = value/sum(value))


#Q6

mean(Pirates$Age)


paste(letters)
paste0(letters)





