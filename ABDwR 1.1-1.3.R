#####################################
#         Baseball Analytics        #
#   Class 2: ABDwR - 1.1 - 1.3      #
#           Andy Andres             #
#            Problem 1              #
#       Edit by Pat Ausman          #
#            Feb 2019               3
#####################################



# Always clear your Environment
# Always check your Working Directory
rm(list=ls())
setwd("/Users/pausman/Desktop/sabermetrics/problem1")  # <- edit this for your computer

# Use your file system here to manage working directry
# The following is an example for a Mac System Drive
# setwd("/Users/Andy/Google Drive File Stream/My Drive/Baseball Research/Fielding AI")
getwd()
list.files()






# move this up
if (!require(tidyverse)) install.packages('tidyverse')
library(tidyverse)


# Load in necessary packages
if (!require(Lahman)) install.packages('Lahman')
library(Lahman)


head(Batting)
tail(Batting)

head(Master)

Master %>% head()







Master %>% head()
names(Master)

Master %>% select(playerID, nameFirst, nameLast) %>% filter(nameLast == "ruth")

# OOPS
Master %>% select(playerID, nameFirst, nameLast) %>% filter(nameLast == "Ruth")

head(Batting)
head(pitching)
# OOPS
head(Pitching)

Batting %>% filter(yearID == 2004)
Pitching %>% filter(yearID == 2004) %>% head()


# From text, 
# We already looked up primary Key for tile table
# The Lahman ID for Babe Ruth is 'ruthba01'
Batting %>% filter(playerID == 'ruthba01')
Pitching %>% filter(playerID == 'ruthba01')
Fielding %>% filter(playerID == 'ruthba01')












# Quick intro to Retrosheet Games Logs
GL.2013 = read_csv('GL2013.TXT')
# OOPS
GL.headers = read_csv('game_log_header.csv')
GL.2013 = read_csv('GL2013.TXT',
                   col_names = names(GL.headers))

names(GL.2013)
head(GL.2013)
tail(GL.2013)
summary(GL.2013)

GL.2013 %>% filter(HomeTeam == 'BOS') 
GL.2013 %>% 
  filter(HomeTeam == 'BOS') %>% 
  filter(Date == 20130420)

glimpse(GL.2013 %>% 
          filter(HomeTeam == 'BOS') %>% 
          filter(Date == 20130420))
