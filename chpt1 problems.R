# 1.2.8
# What is the average number of homeruns per game recorded in each decade?
library(tidyverse)
library(Lahman)
data("Teams")

# is there any weird data in HR
summary(Teams$HR)

# create a new variable to hold the decade

  Teams %>%
  mutate(decade = yearID %/% 10) %>%
  # group by decade
  group_by(decade) %>%
  # sum by decade div by number of games 
  summarize(totalHRavg = mean(HR/G ))

Teams%>%
  
  filter(yearID > 1860, yearID < 1880) %>%
  summarize(totalhr = sum(G))

#rate of strikeouts 
Teams%>%
  #mutate(decade = yearID %/% 10) %>%
  # group by decade
  #group_by(decade) %>%
  group_by(yearID) %>%
  summarize(krate = sum(SO)/sum(G)) %>%
  arrange(desc(yearID))

#rate of strikeouts 
Teams%>%
  mutate(decade = yearID %/% 10) %>%
  # group by decade
  group_by(decade) %>%
  #group_by(yearID) %>%
  summarize(krate = sum(HR)/sum(G))

 

