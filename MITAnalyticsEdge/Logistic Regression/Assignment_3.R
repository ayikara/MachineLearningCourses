parole= read.csv("parole.csv")
str(parole)
pv = subset(parole, violator == 1)
nrow(pv)
str(pv)
pv$crime = as.factor(pv$crime)
str(pv$state)
table(pv$state)
pv$state= as.factor(pv$state)
summary(pv$state)

parole$crime = as.factor(parole$crime)
parole$state= as.factor(parole$state)

#Split into test and train

set.seed(144)

library(caTools)

split = sample.split(parole$violator, SplitRatio = 0.7)

train = subset(parole, split == TRUE)

test = subset(parole, split == FALSE)

nrow(train)
nrow(test)
str(train)

parole1 =glm(violator ~ ., data=train, family=binomial)
summary(parole1)
e^1.6119919
exp(1.6119919)
log(1.6119919)

# Predictions on the test set
predictTest = predict(parole1, type="response", newdata=test)
summary(predictTest)
predictTest

table(test$violator, predictTest > 0.5)
nrow(test)
table(test$violator, predictTest > 0.7)
table(test$violator, predictTest > 0.2)

# Install and load ROCR package
#install.packages("ROCR")
library(ROCR)

# Prediction function
ROCRpred = prediction(predictTest, test$violator)
summary(ROCRpred)
# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
summary(ROCRperf)
str(ROCRperf)
plot(ROCRperf)
plot(ROCRperf, colorize=TRUE, print.cutoffs.at=seq(0,1,by=0.1), text.adj=c(-0.2,1.7))

auc = as.numeric(performance(ROCRpred, "auc")@y.values)
summary(auc)
auc




