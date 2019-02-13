#####################################
#         Baseball Analytics        #
#   Class 1: Intro to Sabermetrics  #
#           Andy Andres             #
#                                   #
#####################################


# Remove all existing objects from your workspace
rm(list=ls())

# Load in necessary packages
if (!require(tidyverse)) install.packages('tidyverse')
library(tidyverse)

# Use your file system here to manage working directry
# The following is an example for a Mac System Drive
# setwd("/Users/Andy/Google Drive File Stream/My Drive/Baseball Research/Fielding AI")
getwd()
list.files()

# Always clear your Environment
# Always check your Working Directory
setwd("/Users/pausman/Desktop/sabermetrics")  # <- edit this for your computer


# Read in our data (luckily it is almost "Tidy")

Players.2000 <- read_csv("FanGraphs Leaderboard.csv")
summary(Players.2000)
glimpse(Players.2000)
head(Players.2000)






Players.2000 %>% 
  select(c(Season, Name, G, PA, AB, H, 1B, 2B, 3B, HR, R, RBI, SB, AVG))














Players.2000 %>% 
  select(c(Season, Name, G, PA, AB, H, HR), 8:10, c(HR, R, RBI, SB, AVG)) 



