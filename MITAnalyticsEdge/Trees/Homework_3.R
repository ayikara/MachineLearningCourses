data(state)
statedata = data.frame(state.x77)
str(statedata)

# Linear Regression (all variables for Lif expectancy)
modLX1 = lm(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area, data=statedata)

summary(modLX1)

TempTest = predict(modLX1)
TempTest

# Compute R-squared
SSE = sum((statedata$Life.Exp - TempTest)^2)
SSE

modLX2 = lm(Life.Exp ~ Population + Murder + HS.Grad + Frost, data=statedata)

summary(modLX2)
TempTest2 = predict(modLX2)
SSE2 = sum((statedata$Life.Exp - TempTest2)^2)
SSE2

library(rpart)

library(rpart.plot)
CARTl = rpart(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area, data=statedata)
prp(CARTl)
PredictCART1 = predict(CARTl)
SSE3 = sum((statedata$Life.Exp - PredictCART1)^2)
SSE3
table(test$isB, PredictCARTb)
CART2 = rpart(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area, data=statedata, control=rpart.control(minbucket=5))
prp(CART2)

PredictCART2 = predict(CART2)
SSE4 = sum((statedata$Life.Exp - PredictCART2)^2)
SSE4

CART3 = rpart(Life.Exp ~  Area, data=statedata, control=rpart.control(minbucket=1))
prp(CART3)

PredictCART3 = predict(CART3)
SSE5 = sum((statedata$Life.Exp - PredictCART3)^2)
SSE5

library(caret)
library(e1071)
set.seed(111)

fitControl = trainControl( method = "cv", number = 10 )
cartGrid = expand.grid( .cp = (1:50)*0.01) 

train(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area, data = statedata, method = "rpart", trControl = fitControl, tuneGrid = cartGrid )

LifeExpTreeCV = rpart(Life.Exp ~ Population + Income + Illiteracy + Murder + HS.Grad + Frost+ Area,  data = statedata, control=rpart.control(cp = 0.12))
prp(LifeExpTreeCV)
lxTestrb = predict(LifeExpTreeCV)
SSEl1 = sum((statedata$Life.Exp - lxTestrb )^2)
SSEl1
set.seed(111)
CART3 = rpart(Life.Exp ~  Area, data=statedata)
prp(CART3)
51*exp(3)

