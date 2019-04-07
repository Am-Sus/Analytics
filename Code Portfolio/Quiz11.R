#QUIZ 11 ---------------------------INTRO CLUSTER
ab <- c(3,4,7,8)
ba <- c(5,7,7,6)
bm <- matrix(c(ab, ba), byrow = T, nrow = 2)
d1 <- abs(bm[1,1]-bm[1,4]) + abs(bm[2,1]-bm[2,4])
d1

dist(bm, method = "manhattan")

Ozone <- read.csv("US EPA data 2017.csv")
names(Ozone) <- make.names(names(Ozone))
length(Ozone)
nrow(Ozone)
ncol(Ozone)

mean(Ozone$Observation.Count)

library(tidyverse)
raw$track <- str_replace(raw$track, " \\(.*?\\)", "")
unique(Ozone$State.Name)

select(Ozone, State.Name) %>% 
  unique %>%
  count()


#Quiz 12------------------------CLUSTERING
install.packages("factoextra")
library(clustertend); library(NbClust); library(factoextra)
data <- USArrests
data <- na.omit(data)
data <- scale(data)
d <- dist(data, method = "euclidean")
hc1 <- hclust(d, method = "ward.D")
hc1
plot(hc1, cex =0.6, hang = -1)
rect.hclust(hc1, k = 3, border = 2:5)
hc2 <- agnes(data, method = "single")
hc2$ac
install.packages("NbClust")
?rect.hclust
cluster_data1 <- read.delim("cluster_1.txt", sep = " ", header = FALSE)
cluster_data2 <- read.delim("cluster_2.txt", sep = " ", header = FALSE)
cluster_data3 <- read.delim("cluster_3.txt", sep = " ", header = FALSE)

cluster <- cbind(cluster_data1, cluster_data2, cluster_data3)
cluster$V1 <- NULL
names(cluster) <- c("c1", "c2", "c3")
fviz_nbclust(cluster, kmeans, method = "gap_stat")+ theme_classic()

#Week13------------------------------------Principal Component Analysis
wines <- read.csv("wine.csv.csv")
str(wines)
