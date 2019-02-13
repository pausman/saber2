rm(list=ls())
#install.packages("Lahman")
library("Lahman")
setwd("/Users/pausman/Desktop/sabermetrics/baseballdatabank-master/core")

masterall <- read_csv("people.csv")
hofall <- read_csv("halloffame.csv")
teamsall <- read_csv("teams.csv")

spahn <- read_csv("spahn.csv")
spahn %>% slice(1:10) %>% select(Age,W,L,ERA)
spahn %>% summarize(LO = min(ERA))
spahn %>% filter(ERA == min(ERA) | ERA == max(ERA))
spahn %>% mutate(FIP = (13*HR + 3*BB -2*SO)/IP) -> spahn1
spahn1 %>% arrange(FIP) %>% select(Year, Age, W, L, ERA, FIP) %>% head()
spahn %>% filter(Tm == "BSN" | Tm == "MLN") -> spahn2
spahn3 <- spahn2 %>% mutate(Tm = factor (Tm, levels = c("BSN", "MLN")))
spahn2 %>% 
  group_by(Tm) %>%
  summarize(mean_WL = mean(W-L, na.rm=TRUE))
NLbatting <- read_csv("data/NLbatting.csv")
ALbatting <- read_csv("data/ALbatting.csv")
## append two data frames verically with bind_rows append rows
batting <- bind_rows(NLbatting,ALbatting)

#  get pitching data and do a join to batting for complete team data
NLpitching <- read_csv("data/NLpitching.csv")
NL <- inner_join(NLbatting, NLpitching, by = "Tm")

# get a subset of the records
NLbatting %>% filter(HR>150) -> NL_150

W <- c(8, 21, 15, 21, 21, 22, 14)
L <- c(5, 10, 12, 14, 17, 14, 19)

L
# create a new vector based on W and L vectors
Win.Pct <- 100 * W / (W + L)
Win.Pct
 
# seq function seq(from = start,to = end)
test <- seq(from = 5, to = 15)
test
Year <- seq(from=1946, to= 1952)
Year
## also could have done Year <- 1946 : 1952 

# create a vector Age from Year vector. He was born in 1921
Age <- Year - 1921
Age

# create a plot of age (x) vs win.pct
plot(Age, Win.Pct)

# man vector functions
# find mean of Win.Pct
mean(Win.Pct)

# calculate create winning percentage by summing W and L and
100 * sum(W) / (sum(W) + sum(L))

# sort the W vector
sort(W)

#cumsum will interate and sum through a vector. 8+14= 29m + 15=44 ...
cumsum(W
       )

# statistics with summary
summary(Win.Pct
        )

# extract from vector with another vector inside [ ]. Show 1st, 2nd and 5th itmes in W vector

W[c(1,2,5)]

W

# extract a series with x:y
W[1:4]

# remove entries from a vector with -. Remove 1st and 6th entries
W[-c(1,6)]

# logical operations
Win.Pct > 60

# Win pct > 60 and more than 20 wins
Win.Pct > 60 & W > 20

#i when was the highest win.pct
Win.Pct == max(Win.Pct)


# what year was that. use last logical vector to query Uear
Year[Win.Pct == max(Win.Pct)]

# what years were there more than 30  decisions
Year[W+L > 30]

# 2.6 Objects and containers in R
# 2.6.1 Character data and data_frames
Year <- 2008:2017
NL <- c("PHI","PHI","SFN","SLN","SFN","SLN",
        "SFN","NYN","CHN","LAN")
AL <- c("TBA","NYA","TEX","TEX","DET","BOS","KCA","KCA","CLE","HOU")
Winner <- c("NL","AL","NL","NL","NL","AL","NL","AL","NL","AL")
N_Games <-c(5,6,5,7,4,7,7,5,7,7)

# create a data_frame of Year, NL, AL, Winner, N_Games
WS_results <- tibble(Year=Year,NL_Team=NL,AL_Team=AL,N_Games=N_Games,Winner=Winner)
WS_results

# Find teams from NY that played in the world series
grep("NY", c(AL,NL), value=TRUE)

# how many times has each league won
# group by winner(AL or NL) and summerize the number of wins. 
# count the number of rows for each winner (AL or NL). Store in df WS
WS <-WS_results %>% 
  group_by(Winner) %>%
  summarize(N=n())

# make a bar graph of results (WS)
# ggplot([df], aes(x=[vector name],y=[vector name])+geom_col())
# geom_col : function to graph each frequecy value with a column
ggplot(WS,aes(x=Winner, y=N))+geom_col()

# geom_bar is designed to make it easy to create bar charts that show
# counts (or sums of weights)
g <- ggplot(WS_results, aes(x=Winner))
# Number of wins for each league. It does the groupby and summerize
g + geom_bar()

# 2.6.2 Factors
# a factor is a special way to represent character data

# number of time each team appeared in the WS
WS_results %>%
  group_by(NL_Team) %>%
  summarize(N=n())

# redefine the NL_Team variable with mutate and factor
# this will set up a default order for listing
WS_results <- WS_results %>%
  mutate(NL_TEAM = factor(NL_Team,levels=c("NYN","PHI","CHN","SLN","LAN","SFN")))

# run again using NL_TEAM (vs NL_Team) for new sort 
WS_results %>%
  group_by(NL_TEAM) %>%
  summarize(N=n())

# 2.6.3 LIsts
# a vector - group of like kind objects
# a data_frame is group of vectors with the same length. vectors can be of different kinds
# lists = group of vectors but can be any length (data_frame is a special list)
# example
world_series <- list(Winner=Winner,Number.Games=N_Games,Seasons="2018 to 2017")
world_series
world_series$Number.Games
# or same thing is
world_series[[2]]
# pluck extracts items for a list
pluck(world_series,"Number.Games")
# or single [] with name of compenet in quotes
world_series["Number.Games"] # this returns a list

# dataframes are lists so these work for df also
WS_results$NL_Team
WS_results[[2]]
pluck(WS_results,"NL_Team")
WS_results["NL_Team"]  # this returns a df 
