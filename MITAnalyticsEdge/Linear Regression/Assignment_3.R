PTest =read.csv("pisa2009test.csv")
PTrain =read.csv("pisa2009train.csv")
str(PTrain)

tapply(PTrain$readingScore,PTrain$male, mean)

pisaTrain = na.omit(PTrain)
pisaTest = na.omit(PTest)
str(pisaTrain)
str(pisaTest)


pisaTrain$raceeth = relevel(pisaTrain$raceeth, "White")
pisaTest$raceeth = relevel(pisaTest$raceeth, "White")

lmScore= lm(readingScore ~ ., data=pisaTrain)

# Compute SSE and RMSE again
SSE = sum(lmScore$residuals^2)
SSE
RMSE = sqrt(SSE/nrow(pisaTrain))
RMSE


# Make test set predictions
predTest = predict(lmScore, newdata=pisaTest)
summary(predTest)

SSE = sum((pisaTest$readingScore - predTest)^2)
RMSEt = sqrt(SSE/nrow(pisaTest))
RMSEt

SST = sum((pisaTest$readingScore - mean(pisaTrain$readingScore ))^2)
1 - SSE/SST

summary(pisaTest)

# Compute R-squared
SSE = sum((wineTest$Price - predictTest)^2)