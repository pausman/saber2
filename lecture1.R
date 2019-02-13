#### comment

### remove all existing objects -variables- from your workspace
rm(list=ls())

# Load in necessar packages
# if it isnt intalled (see packages) install it
if (!require(tidyverse)) install.packages('tidyverse')
# load it up
library(tidyverse)

# what is the current dir
getwd()
# do a directory
list.files()

# set the directory
setwd("/Users/pausman/Desktop/sabermetrics")

# Read in our data
Players.2000 <- read_csv("FanGraphs Leaderboard.csv")
summary(Players.2000)
glimpse(Players.2000)
head(Players.2000)

# %>% is pipe take big dataset pipe into select statement
Players.2000 %>%
  # c means combine. 8:10 means columns 8 10 cause variables started with number ...
  select(c(Season, Name, G, PA, H, HR), 8:10, c(HR, R, RBI, SB, AVG)) %>%
  filter(Name == "Mookie Betts") %>%
  arrange(Season)

# filter for mookie betts