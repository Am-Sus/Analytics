#Multiple variables stored in one column: TB dataset####
library(stringr)
# Load data
raw <- read.csv("tb.csv", na.strings = "") #read data
raw$new_sp <- NULL #creat new column with no values
raw <- subset(raw, year == 2000)#subset where year is 2000
names(raw)[1] <- "country" #rename column1 

names(raw) <- str_replace(names(raw), "new_sp_", "")#remove argument from column name
raw$m04 <- NULL
raw$m514 <- NULL
raw$f04 <- NULL
raw$f514 <- NULL#remove these columns with NA values

xtable(raw[1:10, 1:11], file = "tb-raw.tex") #save this new data

# Melt -----------------------------------------------------------------------
library(reshape2)
library(dplyr)

clean <- melt(raw, id = c("country", "year"), na.rm = TRUE) #convert to long data by named columns from reshape2 package
names(clean)[3] <- "column" #name column3
names(clean)[4] <- "cases" #name column4
clean[1:10,]

clean <- arrange(clean, country, column, year) #arrange in this order from dplyr
xtable(clean[1:15, ], file = "tb-clean-1.tex")#save output

# Break up variable in to sex and age ----------------------------------------
clean$sex <- str_sub(clean$column, 1, 1)#extract first letter of column to be input in new columnsex

ages <- c(`04` = "0--4", `514` = "5--14", `014` = "0--14", `1524` = "15--24", `2534` = "25--34", 
          `3544` = "35--44", `4554` = "45--54", `5564` = "55--64", `65` = "65+", u = NA)#create vector age

clean$age <- factor(ages[str_sub(clean$column, 2)], levels = ages) #assign age to clean as factor using 2nd letter of column as cue

#Billboard dataset----------------------------------------------------------------------------------
library("lubridate")#package for cleaning date data

raw <- read.csv("billboard.csv")

raw <- raw[, c("year", "artist.inverted", "track", "time", "date.entered", "x1st.week", 
               "x2nd.week", "x3rd.week", "x4th.week", "x5th.week", "x6th.week", "x7th.week", 
               "x8th.week", "x9th.week", "x10th.week", "x11th.week", "x12th.week", "x13th.week", 
               "x14th.week", "x15th.week", "x16th.week", "x17th.week", "x18th.week", "x19th.week", 
               "x20th.week", "x21st.week", "x22nd.week", "x23rd.week", "x24th.week", "x25th.week", 
               "x26th.week", "x27th.week", "x28th.week", "x29th.week", "x30th.week", "x31st.week", 
               "x32nd.week", "x33rd.week", "x34th.week", "x35th.week", "x36th.week", "x37th.week", 
               "x38th.week", "x39th.week", "x40th.week", "x41st.week", "x42nd.week", "x43rd.week", 
               "x44th.week", "x45th.week", "x46th.week", "x47th.week", "x48th.week", "x49th.week", 
               "x50th.week", "x51st.week", "x52nd.week", "x53rd.week", "x54th.week", "x55th.week", 
               "x56th.week", "x57th.week", "x58th.week", "x59th.week", "x60th.week", "x61st.week", 
               "x62nd.week", "x63rd.week", "x64th.week", "x65th.week", "x66th.week", "x67th.week", 
               "x68th.week", "x69th.week", "x70th.week", "x71st.week", "x72nd.week", "x73rd.week", 
               "x74th.week", "x75th.week", "x76th.week")]

names(raw)[2] <- "artist"#namne column 2 "artist

raw$artist <- iconv(raw$artist, "MAC", "ASCII//translit") #convert from "MAC" to "ASCII/translit" format

raw$track <- str_replace(raw$track, " \\(.*?\\)", "") #replace these signs with second argument(nothing)

names(raw)[-(1:5)] <- str_c("wk", 1:76) #except 1:5 name column wk 1:76

raw <- arrange(raw, year, artist, track) #arrange raw by year, artist and track
raw[1:10, 1:10]

library(stringr)
long_name <- nchar(raw$track) > 20 #find characters more than 20 letters
raw$track[long_name] <- paste0(substr(raw$track[long_name], 0, 20), "...")#if track namae is longer than 20 characters, extract 0-20 and if there are more letters, continue with ...

clean <- melt(raw, id = 1:5, na.rm = TRUE) #convert to long format
clean[1:10,]

clean$week <- as.integer(str_replace_all(clean$variable, "[^0-9]+", "")) #replace column variable: with the argument and return column as factor
clean$variable <- NULL #remove column variable 
library(lubridate)

clean$date.entered <- ymd(clean$date.entered) #convert column:date to ymd format

clean$date <- clean$date.entered + weeks(clean$week - 1) #add (weeks-1) in days to date.entered

clean$date.entered <- NULL #remove column date.entered

clean <- rename(clean, c(value = "rank")) #this code doesnt seem to work
names(clean) <- sub("^value$", "rank", names(clean)) #so tried this which worked
clean_out[1:10,]

clean <- arrange(clean, year, artist, track, time, week) #arrange variables in this order
clean <- clean[c("year", "artist", "time", "track", "date", "week", "rank")] #arrange columns in this order

clean_out <- mutate(clean, date = as.character(date))#create new tibble formatting date column as character
xtable(clean_out[1:15, ], "billboard-clean.tex")

# Normalization --------------------------------------------------------------
library(plyr)
song <- unrowname(unique(clean[c("artist", "track", "time")]))#remove 
song[1:10,]
song$id <- 1:nrow(song)

narrow <- song[1:15, c("id", "artist", "track", "time")]
narrow
xtable(narrow, "billboard-song.tex")

rank <- join(clean, song, match = "first")

rank <- rank[c("id", "date", "rank")]

rank$date <- as.character(rank$date)
??xtable
xtable(rank[1:15, ], "billboard-rank.tex")
clean <- clean[c("country", "year", "sex", "age", "cases")] #arrange clean in this manner or form clean by these vectors

xtable(clean[1:15, ], file = "tb-clean-2.tex") #save this output

clean[1:10,]

#Deaths dataset  ----------------------------------------------------------
library("ggplot2")
library("MASS")

deaths <- readRDS("deaths.rds")

ok <- subset(deaths, yod == 2008 & mod != 0 & dod != 0) # use "!" to mean "not"

codes <- read.csv("icd-main.csv")
codes$disease <- sapply(codes$disease, function(x) str_c(strwrap(x, width = 30), 
                                                         collapse = "\n"))
names(codes)[1] <- "cod"
codes <- codes[!duplicated(codes$cod), ]

# Display overall hourly deaths
hod_all <- subset(count(deaths, "hod"), !is.na(hod))

#using ggplot
qplot(hod, freq, data = hod_all, geom = "line") + 
  scale_y_continuous("Number of deaths", 
                     labels = function(x) format(x, big.mark = ",")) + 
  xlab("Hour of day")

# Count deaths per hour, per disease
hod2 <- count(deaths, c("cod", "hod"))
hod2 <- subset(hod2, !is.na(hod))
hod2 <- join(hod2, codes)
hod2 <- ddply(hod2, "cod", transform, prop = freq/sum(freq)) #using dplyr 


# Compare to overall abundance
overall <- ddply(hod2, "hod", summarise, freq_all = sum(freq))
overall <- mutate(overall, prop_all = freq_all/sum(freq_all))

hod2 <- join(overall, hod2, by = "hod")

# Pick better subset of rows to show
cods <- join(arrange(count(deaths, "cod"), desc(freq)), codes)
mutate(tail(subset(cods, freq > 100), 30), disease = str_sub(disease, 1, 30))

hod3 <- subset(hod2, cod %in% c("I21", "N18", "E84", "B16") & hod >= 8 & hod <= 12)[1:15, 
                                                                                    c("hod", "cod", "disease", "freq", "prop", "freq_all", "prop_all")]

xtable(hod3[c("hod", "cod", "freq")], "counts.tex")
xtable(hod3[c("disease")], "counts-disease.tex")
xtable(hod3[5], "counts-prop.tex")
xtable(hod3[6:7], "counts-all.tex")

devi <- ddply(hod2, "cod", summarise, n = sum(freq), dist = mean((prop - prop_all)^2))
devi <- subset(devi, n > 50)

# Find outliers
xlog10 <- scale_x_log10(breaks = c(100, 1000, 10000), labels = c(100, 1000, 10000), 
                        minor_breaks = log10(outer(1:9, 10^(1:5), "*")))
ylog10 <- scale_y_log10(breaks = 10^-c(3, 4, 5), labels = c("0.001", "0.0001", "0.00001"), 
                        minor_breaks = log10(outer(1:9, 10^-(3:6), "*")))

qplot(n, dist, data = devi)
ggsave("n-dist-raw.pdf", width = 6, height = 6)
qplot(n, dist, data = devi) + 
  geom_smooth(method = "rlm", se = FALSE) + 
  xlog10 + ylog10

ggsave("n-dist-log.pdf", width = 6, height = 6)

devi$resid <- resid(rlm(log(dist) ~ log(n), data = devi))
coef(rlm(log(dist) ~ log(n), data = devi))

ggplot(devi, aes(n, resid)) + 
  geom_hline(yintercept = 1.5, colour = "grey50") + 
  geom_point() + 
  xlog10
ggsave("n-dist-resid.pdf", width = 6, height = 6)

unusual <- subset(devi, resid > 1.5)
hod_unusual_big <- match_df(hod2, subset(unusual, n > 350))
hod_unusual_sml <- match_df(hod2, subset(unusual, n <= 350))

# Visualize unusual causes of death
ggplot(hod_unusual_big, aes(hod, prop)) + 
  geom_line(aes(y = prop_all), data = overall,
            colour = "grey50") + geom_line() + 
  facet_wrap(~disease, ncol = 3) #

ggsave("unusual-big.pdf", width = 8, height = 6)
last_plot() %+% hod_unusual_sml
ggsave("unusual-sml.pdf", width = 8, height = 4) 