letters = read.csv("letters_ABPR.csv")
letters$isB = as.factor(letters$letter == "B")
str(letters)
library(caTools)
set.seed(3000)
split = sample.split(letters$isB, SplitRatio = 0.5)
train = subset(letters, split==TRUE)
test = subset(letters, split==FALSE)
str(train)
sum(train$isB=="TRUE")
1-(383/1558)
sum(test$isB=="FALSE")
1175/1558

CARTb = rpart(isB ~ . - letter, data=train, method="class")
PredictCARTb = predict(CARTb, newdata = test, type = "class")

table(test$isB, PredictCARTb)
(1118+331)/(1118+331+57+52)

library(randomForest)
set.seed(1000)
# Build random forest model
cartbForest = randomForest(isB ~ . - letter, data = train)

# Make predictions
cartbPredict= predict(cartbForest, newdata = test)
table(test$isB, cartbPredict)
(1172+370)/(1172+370+16)

#04-07-2014
letters$letter = as.factor( letters$letter )
set.seed(1000)
split = sample.split(letters$letter, SplitRatio = 0.5)
trainL = subset(letters, split==TRUE)
testL = subset(letters, split==FALSE)
table(testL$letter)
401/(395+383+401+379)
library(rpart)

library(rpart.plot)
CARTbl = rpart(letter ~ . - isB, data=trainL, method="class")

PredictCARTb1 = predict(CARTbl, newdata = testL, type = "class")

table(testL$letter, PredictCARTb1)
(86+89+106+115)/(86 + 104 + 98+ 116 +99 + 89 + 89 +106 +94 + 85+ 106 +102+94 + 91 + 84+ 115)
(350+314+366+338)/1558
set.seed(1000)
cartbForestL = randomForest(letter ~ . - isB, data = trainL)
cartbPredictL= predict(cartbForestL, newdata = testL)
table(testL$letter, cartbPredictL)
(395+374+396+363)/1558

