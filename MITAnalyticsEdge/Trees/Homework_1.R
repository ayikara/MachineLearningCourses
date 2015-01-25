# Read in data
gerber= read.csv("gerber.csv")
str(gerber)
#Count of rows with Voting =1
sum(gerber$voting==1)
sum(gerber$voting==0)
108696 + 235388
108696/344084 
sum(gerber$voting==1)
sum(gerber$voting==1 & gerber$hawthorne)
sum(gerber$voting==1 & gerber$civicduty)
sum(gerber$voting==1 & gerber$neighbors)
sum(gerber$voting==1 & gerber$self)

# Logistic Regression Model
gbVote = glm(voting ~ hawthorne+ civicduty+neighbors+self, data=gerber, family=binomial)
summary(gbVote)

# Make predictions on training set
predictV = predict(gbVote , type="response")

# Confusion matrix for threshold of 0.3, 0.5
table(gerber$voting, predictV> 0.3)
accr = (134513+51966)/(134513+51966+56730+100875)
table(gerber$voting, predictV> 0.5)
 235388/(235388+108696)

library(ROCR)

# Prediction function
ROCRpred = prediction(predictV, gerber$voting)
summary(ROCRpred)
# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred, "auc")@y.values)
summary(auc)
auc

library(rpart)

library(rpart.plot)

CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

PredictCART2 = predict(CARTmodel2)
table(gerber$voting, PredictCART2)

CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)

modelCtrl = rpart(voting ~ control, data=gerber, cp=0.0)
modelCtrlSx = rpart(voting ~ control+sex, data=gerber, cp=0.0)
prdCtrl = predict(modelCtrl)
prdCtrlSx = predict(modelCtrlSx)
abs(modelCtrl- modelCtrlSx)
sum(abs(prdCtrl - prdCtrlSx))
prp(prdCtrl)




