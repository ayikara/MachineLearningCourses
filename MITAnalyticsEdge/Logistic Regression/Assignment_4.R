loans= read.csv("loans.csv")
str(loans)
loannp =subset(loans, not.fully.paid ==1)
str(loannp)
nrow(loannp)/nrow(loans)

#

library(mice)
set.seed(144)

vars.for.imputation = setdiff(names(loans), "not.fully.paid")

imputed = complete(mice(loans[vars.for.imputation]))

loans[vars.for.imputation] = imputed

set.seed(144)

library(caTools)

split = sample.split(loans$not.fully.paid, SplitRatio = 0.7)

train = subset(loans, split == TRUE)

test = subset(loans, split == FALSE)

notpaid1 =glm(not.fully.paid ~ ., data=train, family=binomial)
summary(notpaid1)

# Predictions on the test set
predictTest = predict(notpaid1, type="response", newdata=test)
summary(predictTest)

table(test$not.fully.paid, predictTest > 0.5)

# Prediction function
ROCRpred = prediction(predictTest, test$not.fully.paid)
summary(ROCRpred)
# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred, "auc")@y.values)
summary(auc)
auc

bivar =glm(not.fully.paid ~ int.rate, data=train, family=binomial)

predictBiVar = predict(bivar , type="response", newdata=test)
summary(predictBiVar)

table(test$not.fully.paid, predictBiVar> 0.5)


ROCRpred2 = prediction(predictBiVar, test$not.fully.paid)
summary(ROCRpred)
# Performance function
ROCRperf2 = performance(ROCRpred2, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred2, "auc")@y.values)
summary(auc)
auc
test$profit = exp(test$int.rate*3) - 1

test$profit[test$not.fully.paid == 1] = -1tab

testHigh = subset(test, int.rate>=.15)

 testHnotpaid = subset(testHigh, not.fully.paid ==1)
nrow(testHigh)
nrow(testHnotpaid)


