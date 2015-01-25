# Read in data
census= read.csv("census.csv")
str(census)

# Logistic Regression Model
gbVote = glm(over50k ~ . , data=gerber, family=binomial)
summary(gbVote)
violator ~ .
9713/(3078+9713)



library(caTools)
set.seed(2000)
split = sample.split(census$over50k, SplitRatio = 0.6)

train = subset(census, split == TRUE)

test = subset(census, split == FALSE)
table(test$over50k) 
gbOver1 = glm(over50k ~ . , data=train, family=binomial)
summary(gbOver1)
str(train)

predictTest = predict(gbOver1, type="response", newdata=test)
table(test$over50k, predictTest > 0.5)
(9051+1888)/(9051+1888+1190+662)

library(ROCR)

# Prediction function
ROCRpred = prediction(predictTest, test$over50k)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred, "auc")@y.values)
auc

library(rpart)

library(rpart.plot)

CARTl = rpart(over50k ~., method = "class", data=test)
prp(CARTl)

PredictCART = predict(CARTl, newdata = test, type = "class")
table(test$over50k, PredictCART)
(9241+1604)/(9241+1604+1474+472)

# Install and load ROCR package
install.packages("ROCR")
library(ROCR)
ROCRpred = prediction(PredictCART , test$over50k)

# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")


