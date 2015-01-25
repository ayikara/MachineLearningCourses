An = read.csv("AnonymityPoll.csv")
str(An)
summary(An)
tsmp= subset(An,Smartphone == 1)
summary(tsmp)
str(tsmp)
tnosmp= subset(An,Smartphone == 0)
str(tnosmp)

tcens <-table(An$State, An$Region)
tcens
tius <-table(An$Internet.Use, An$Smartphone)
tius

tius2 <-table(An$Internet.Use, An$Smartphone,na.rm=TRUE)

limited = subset(An,Smartphone == 1 | Internet.Use==1)
str(limited)
summary(limited)

mean(An$Info.On.Internet)
mean(An$Info.On.Internet, na.rm=TRUE)
tI1= subset(An,Info.On.Internet == 0)
str(tI1)

tI2= subset(An,Info.On.Internet == 11)
str(tI2)

CPS = read.csv("CPSData.csv")
str(CPS)
summary(CPS)
sort(table(CPS$Region))
sort(table(CPS$State))
