parole = read.csv("parole.csv")
parole2 = read.csv("parole.csv")
str(parole)
parole$male = as.factor(parole$male)

parole$state = as.factor(parole$state)

parole$crime = as.factor(parole$crime)

nrow(subset(parole,  parole$violator==1 ))
nrow(subset(parole,  parole$violator==1 & parole$male==0 ))


nrow(parole)
130/675
14/78

ckenty = subset(parole,  parole$state==2)
table(ckenty$crime)
ckenty2 = subset(parole2,  parole2$state=="kentucky")

table(ckenty2$crime)
summary(parole2)

ckentyA = subset(parole,  parole$state==2 & parole$crime==1)
ckentyB = subset(parole,  parole$state==2 & parole$crime==2)
ckentyC = subset(parole,  parole$state==2 & parole$crime==3)
ckentyD = subset(parole,  parole$state==2 & parole$crime==4)
nrow(ckentyA)
nrow(ckentyB)
nrow(ckentyC)
nrow(ckentyD)
nrow(ckenty)
parole$state

ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5)

#separate for each var type in facet grid
ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(male ~ .)

ggplot(data = parole, aes(x = age)) + geom_histogram(binwidth = 5) + facet_grid(.~male)

ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(binwidth = 5)

#Overlay
ggplot(data = parole, aes(x = age, fill = male)) + geom_histogram(position="identity",alpha=0.5,binwidth = 5)

ggplot(data = parole, aes(x =  time.served)) + geom_histogram(binwidth = 1)

#overlay, alpha is transparency
ggplot(data = parole, aes(x =  time.served)) + geom_histogram(binwidth = .1)


ggplot(data = parole, aes(x =  time.served)) + geom_histogram(binwidth = 1)+ facet_grid(crime ~ .)

ggplot(data = parole, aes(x =  time.served,fill = crime)) + geom_histogram(position="identity",alpha=0.5,binwidth = 1) #+ facet_grid(crime ~ .)





