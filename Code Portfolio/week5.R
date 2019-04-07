billboard <- read.csv("billboard.csv") #import data

options(stringsAsFactors = FALSE)

library("stringr")
library("reshape2")
library("plyr")

read.fwf2 <- function(path, cols) {
  raw_stations <- readLines(path)
  stations <- data.frame(matrix(ncol = 0, nrow = length(raw_stations)))
  
  for(i in 1:nrow(cols)) {
    field <- cols[i, ]
    stations[[field$name]] <- str_trim(str_sub(raw_stations, field$start, field$end))
  }
  stations[stations == ""] <- NA
  stations[] <- lapply(stations, type.convert, as.is = TRUE)
  
  stations
}

# Change defaults for xtable to be more attractive
# Inspired by: http://cameron.bracken.bz/sweave-xtable-booktabs
library("xtable")

xtable <- function(x, file = "", ..., rownames = FALSE) {
  table <- xtable::xtable(x, ...)
  print(table, floating = FALSE, hline.after = NULL, 
        add.to.row = list(pos = list(-1,0, nrow(x)), 
                          command = c('\\toprule\n ','\\midrule\n  ','\\bottomrule\n')),
        include.rownames = rownames, NA.string = "---",
        file = file, 
        comment = FALSE, timestamp = FALSE
  )
}


set.seed(1014)

preg <- matrix(c(NA, sample(20, 5)), ncol = 2, byrow = TRUE) #creat matrix 
preg
colnames(preg) <- paste0("treatment", c("a", "b")) #name columns
rownames(preg) <- c("John Smith", "Jane Doe", "Mary Johnson") #row names

xtable(preg, "preg-raw-1.tex", rownames = TRUE, align = "lrr")
xtable(t(preg), "preg-raw-2.tex", rownames = TRUE, align = "lrrr")

# Make tidy version

pregm <- melt(preg, id = "name") #create long format by melting by names
pregm

names(pregm) <- c("name", "trt", "result") #change default column names
pregm$trt <- gsub("treatment", "", pregm$trt) #use gsub extract aor b from trt column

xtable(pregm, "preg-tidy.tex") #save the new format

rm(preg, pregm)
