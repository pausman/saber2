rm(list=ls())
setwd("/Users/pausman/Desktop/sabermetrics")
# what is the current dir
getwd()
# do a directory
list.files()
# Load in necessar packages
# if it isnt intalled (see packages) install it
if (!require(tidyverse)) install.packages('tidyverse')
# load it up
library(tidyverse)
# load in the package
if (!require(Lahman)) install.packages("Lahman")
library (Lahman)
head(Batting)
tail(Batting)
head(Master)
# pipe it into the head function. Same as last line. tidyverse needed for pipe
Master %>% head()
# names columns name
names(Master)

Master %>% select(playerID, nameFirst, nameLast) %>% filter(nameLast == "Ruth")

head(pitching) #error it is Pitching 
head(Pitching)

Batting %>% filter(yearID == 2004)
Pitching %>% filter(yearID == 2004) %>% head()

Batting %>% filter(playerID == 'ruthba01')
Pitching %>% filter(playerID == 'ruthba01')
Fielding %>% filter(playerID == 'ruthba01')

# moving to retrosheet
GL.2018 = read_csv('GL2018.TXT')
# make a csv with the headers 
# GL.headers = read_csv('game_log_header.csv')
# now use header file to  to read it date
# GL.2013 = read_csv('GL2013.TXT, col_names = names(GL.headers))

# glimpse(GL.2013 %>%
#  filtger(HomeTeam == 'BOS') %>% 
#  filter(Date = 20130420))
# glimpse gives a quick look
