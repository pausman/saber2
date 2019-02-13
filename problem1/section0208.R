library(tidyverse)
library(Lahman)
data("Pitching")
















### 1.9.1.a - Walk rate by team-season






Pitching %>% group_by(yearID, teamID) %>% summarize(BBrate=sum(BB) / sum(IPouts) * 27) %>% arrange(desc(BBrate))


















### 1.9.1.b - Percentage of games that end in shutouts 




setwd("~/baseballdata/retrosheet/gamelogs/")
system("ls")

games <- read_csv("game_log_header.csv")
games <- read_csv("GL1968.TXT", col_names=names(games))

for (year in 1980:2018) {
  tmp = read_csv(paste0("GL", year, ".TXT"), col_names = names(games))
  games <- bind_rows(mutate_all(games, as.character), mutate_all(tmp, as.character))
}

games %>% summarize(sum(VisitorRunsScored == 0 | HomeRunsScore == 0)/n())


### 1.3.6






# Home Runs By Month Since 1980







example.games <- games %>%
  mutate(Year = as.numeric(substring(Date, 1, 4)), Month = as.numeric(substring(Date, 5, 6)),
         HomeHR = as.numeric(HomeHR), VisitorHR = as.numeric(VisitorHR)) %>% 
         select(Date, Year, Month, HomeTeam, VisitingTeam, HomeHR, VisitorHR) 








games %>%
  mutate(Year = as.numeric(substring(Date, 1, 4)), Month = as.numeric(substring(Date, 5, 6)),
         HomeHR = as.numeric(HomeHR), VisitorHR = as.numeric(VisitorHR)) %>%
  filter(Year >= 1980) %>%
  group_by(Month) %>%
  summarize(HRrate=mean(HomeHR + VisitorHR))

HRrate.by.park <- games %>%
  mutate(Year = as.numeric(substring(Date, 1, 4)), Month = as.numeric(substring(Date, 5, 6)),
         HomeHR = as.numeric(HomeHR), VisitorHR = as.numeric(VisitorHR)) %>%
  filter(Year >= 1980) %>%
  group_by(ParkID) %>%
  summarize(HRrate=mean(HomeHR + VisitorHR)) %>% 
  arrange(desc(HRrate))

parks <- read_csv("parkcodes.txt")

HRrate.by.park <- inner_join(HRrate.by.park, parks, c("ParkID" = "PARKID")) %>% select(NAME, HRrate)


head(HRrate.by.park)
tail(HRrate.by.park)














# Runs by Umpire

umps.over.400 <- games %>%
  mutate(Year = substring(Date, 1,4)) %>%
  filter(Year >= 1980) %>%
  group_by(UmpireHID, UmpireHName) %>%
  summarize(games=n()) %>%
  filter(games >= 400) %>%
  select(UmpireHID)

runs.by.ump <- games %>%
  mutate(Year = substring(Date, 1,4)) %>%
  filter(Year >= 1980) %>%
  inner_join(umps.over.400, by="UmpireHID") %>%
  group_by(UmpireHID, UmpireHName) %>%
  mutate(HomeRunsScore=as.numeric(HomeRunsScore), VisitorRunsScored=as.numeric(VisitorRunsScored)) %>%
  summarize(RunsPerGame=mean(HomeRunsScore + VisitorRunsScored)) %>%
  arrange(desc(run))














# Attendance on weekdays and weekends:




  





games %>%
  mutate(Year = substring(Date, 1,4)) %>%
  filter(Year >= 1980 & Year <= 2011) %>%
  mutate(Weekend = DayOfWeek %in% c("Sat", "Sun")) %>%
  select(DayOfWeek, Weekend, Attendance) %>%
  filter(!is.na(Attendance)) %>%
  group_by(Weekend) %>%
  summarize(Attendance = mean(as.numeric(Attendance)))


Batting %>% inner_join(Pitching, by=c("playerID",  "yearID"))
