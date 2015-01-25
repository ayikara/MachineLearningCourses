install.packages("zoo")
library(zoo)
FluTest =read.csv("FluTest.csv")
FluTrain =read.csv("FluTrain.csv")

ILILag2 = lag(zoo(FluTrain$ILI), -2, na.pad=TRUE)
FluTrain$ILILag2 = coredata(ILILag2)
summary(ILILag2)

plot(log(FluTrain$ILI),FluTrain$ILILag2)
plot(FluTrain$ILILag2,log(FluTrain$ILI))
str(FluTrain)
FluTrend2 = lm(log(ILI) ~ Queries + log(ILILag2), data=FluTrain)
summary(FluTrend2)

ILILag2 = lag(zoo(FluTest$ILI), -2, na.pad=TRUE)
FluTest$ILILag2 = coredata(ILILag2)
summary(FluTest)
