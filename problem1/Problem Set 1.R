#####################################
#         Baseball Analytics        #           
#            Problem Set 1          #
#           Pat Ausman              #
#            Feb 2019               #
#####################################

# clean up, set the environment
rm(list=ls())
setwd("/Users/pausman/Desktop/sabermetrics/problem1")  

# check working directory just to make sure
getwd()
list.files()

# make sure tidyverse is loaded
if (!require(tidyverse)) install.packages('tidyverse')
library(tidyverse)

# setup the Lahman database which is built into R
if (!require(Lahman)) install.packages('Lahman')
library(Lahman)

#
# part a
#

# question 1 How many players with the last name “Saltalamacchia” have played MLB?
who_to_look_for = "Saltalamacchia"
Salty <- Master %>% select(nameLast) %>% filter(nameLast == who_to_look_for)
Salty
# output the number
cat("The number of players with a last name of",who_to_look_for,"is",count(Salty)[[1]])

# question 2 How many players with the first name “Jarrod” have played MLB?
who_to_look_for = "Jarrod"
Salty <- Master %>% select(nameFirst) %>% filter(nameFirst == who_to_look_for)
Salty
# output the number
cat("The number of players with a first name of",who_to_look_for,"is",count(Salty)[[1]])

# question 3 What is the name of the player with the playerID “parkeja01” 
who_to_look_for = "parkeja01"
results <- Master %>% select(playerID, nameFirst, nameLast) %>% filter(playerID == who_to_look_for)
results
# output the number - assuming there is only one record
  cat("The name of the player with a playerID of",who_to_look_for,"is",results[[2]],results[[3]])

  
#
# part b
#
  
# cleanup and reinitialize
  rm(list=ls())
  setwd("/Users/pausman/Desktop/sabermetrics/problem1")  
  
  # check working directory just to make sure
  getwd()
  list.files()
  
  # make sure tidyverse is loaded - this is probably still loaded
  if (!require(tidyverse)) install.packages('tidyverse')
  library(tidyverse)

  # downloaded the game log from 2015. Use the headers for input since they are much clearer
  GL.headers = read_csv('game_log_header.csv')
  GL.2015 = read_csv('GL2015.TXT',
                     col_names = names(GL.headers))
  names(GL.2015)
  head(GL.2015)
  tail(GL.2015)
  summary(GL.2015)
  
  GL.2015 %>% filter(HomeTeam == 'BOS') 
  GL.2015 %>% 
    filter(HomeTeam == 'BOS') %>% 
    # look at patriots day game in 2015
    filter(Date == 20150420)
  
  glimpse(GL.2015 %>% 
            filter(HomeTeam == 'BOS') %>% 
            filter(Date == 20150420))
  
  #
  # part c - back to Lahman 
  #Cut and paste this R code into your script in RStudio: 
  Master %>% inner_join(Batting) %>% filter(playerID=="aaronha01") %>% select(playerID, yearID, stint, nameFirst, nameLast, HR)
  
  #
  # part d - what does inner_join do?
  # part of dplyr library which is in rstudio
  #
  cat ("Inner_join combines the two data_files based on a common key between the two data_files.")
  cat ("Since no key was specified files are joined by any/all common fields in this case PlayerID")
  cat ("Only data that exists in both tables are selected.")


  #
  # part e 
  #  Add a line of code to yoru script that joins together the Batting and Pitching tables 
  #  with Batting %>% inner_join(Pitching, by=c("playerID", "yearID")) and adds filters to 
  #  find a player who recorded more than 100 outs as a pitcher and had over 100 at-bats 
  #  as a hitter in a season.  
  #  How many players have done this?  
  

  Combo <- Batting %>% inner_join(Pitching, by=c("playerID", "yearID")) %>%
    filter(IPouts > 100 & AB > 100)
  
  #  How many players have done this?  
  cat ("The number of players that have had 100 outs as a pitcher and 100 AB as a hitter is",count(Combo)[[1]])
  
  #  How many players have done this since the year 1990?
  Combo2 <- Combo %>% 
    filter(yearID >= 1900)
  cat ("The number of players that have had 100 outs as a pitcher and 100 AB as a hitter since 1900 is",
       count(Combo2)[[1]])

  # part f
  # BONUS: Join the Master table to your answer from e) 
  # and select the first and last names of the players returned.
  # only records in Combo2 are matched in Master by playerID 
  whoarethey <-inner_join(Combo2,Master) %>% select(nameFirst, nameLast)
  head(whoarethey)
  #
  # What kinds of questions might the Lahman database help you answer? 
  # Give an example of a hypothesis one could test using data from the Lahman database
  # I started with one question but it lead to more questions
  # question 1: who is in the master table but was not a player
  
  a <- anti_join(Master,Batting)
  cat("The number of people in the master table that are not players",count(a)[[1]])
  cat("Looking at the data there is at least one player that has no batting but did appear in the post season Matt Kiger")
  
  # lets try to find all the records in Masters that have 99 in the id
  f <- filter(Master,grepl('99', playerID))
  cat("The number of people in the master table have 99 in their player ID is",count(f)[[1]])
  
  # okay what records are in a but not in f and who are they
  f <- filter(a,!grepl('99', playerID)) %>% select (playerID,nameFirst,nameLast)
f
#    playerID nameFirst nameLast
#1 crossjo01       Joe    Crossk - batter in 1 game in 1888
#2 kigerma01      Mark    Kiger - only batted in the post season
#3 sulliwi01   William Sullivan - picher 1 game in 1988 - not in pitching

  
 
  
  