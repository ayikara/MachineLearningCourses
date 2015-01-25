library(rpart)

library(rpart.plot)

#CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
#prp(CARTmodel)
train.testrb <-train.batch
test.testrb <-test.batch
train.testrb$pop = as.factor(train.testrb$pop)
str(train.testrb)
test.testrb$pop = as.factor(test.testrb$pop)
#fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small
fol <- formula(pop~ fsc_small + fsc_perp + fsc_big + pe + chl_big + chl_small)
rpart1 <- rpart(fol, data = train.testrb, method = "class")
prp(rpart1)
print(rpart1)
str(PredictCART2)
PredictCART2 = predict(rpart1)
table(test.testrb$pop, PredictCART2)
summary(PredictCART2)
table(train.testrb, PredictCART2)
PredictCARTb = predict(rpart1, newdata = test.testrb, type = "class")
table(test.testrb$pop, PredictCARTb)
accracy = (5022+9634+9054+7290)/nrow(test.testrb)
