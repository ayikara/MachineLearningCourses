baseball= read.csv("baseball.csv")
str(baseball)

#Fnding combination of team year
unique(baseball[c("Team","Year")])

ucomb = unique(baseball[c("Team","Year")])
str(ucomb)

tyr <- table(baseball$Year)
nrow(tyr)

# Create training and testing sets
baseball = subset(baseball, Playoffs == 1)
nrow(baseball)

ucomb = unique(baseball[c("Team","Year")])
str(ucomb)
poff11 = subset(ucomb, Year == 2011)
poff11
ucomb = unique(baseball[c("Team")])

table(ucomb$Year)


PlayoffTable = table(baseball$Year)
str(PlayoffTable)
names(PlayoffTable)

PlayoffTable[c("1990","2001")]

baseball$NumCompetitors = PlayoffTable[as.character(baseball$Year)

baseball[100]
str(baseball)

PlayoffTable1 = table(PlayoffTable$Year,)

str(baseball)
pf8 = subset(
, NumCompetitors == 8)
nrow(pf8)

baseball$WorldSeries = as.numeric(baseball$RankPlayoffs == 1)
pf9 = subset(baseball, WorldSeries == 0)
nrow(pf9)

#create a model by removing 1 variable
str(baseball)
ModRS = glm(WorldSeries ~ RS, data=baseball, family=binomial)
summary(ModRS)
ModRS = glm(WorldSeries ~ RS, data=baseball, family=binomial)
cor(baseball$Year,baseball$RA,baseball$RankSeason,baseball$NumCompetitors)
cor(baseball$Year,baseball$RA)
cor(baseball$Year,baseball$RankSeason)
cor(baseball$Year,baseball$NumCompetitors)
cor(baseball$NumCompetitors,baseball$RankSeason)

Mod2 = glm(WorldSeries ~ Year+RA, data=baseball, family=binomial)
Mod2$AIC
summary(Mod2)
Mod2 = glm(WorldSeries ~ RankSeason+NumCompetitors, data=baseball, family=binomial)
summary(Mod2)
exp(-1.7006288)
exp(1.7006288)
1/(6.47739)




