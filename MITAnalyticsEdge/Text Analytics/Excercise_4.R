#wordCount = rowSums(as.matrix(dtm))
library(slam)

wordCount = rollup(dtm, 2, FUN=sum)$v
hist(wordCount)
hist(log(wordCount))

str(emailsSparse)
emailsSparse$logWordCount = log(wordCount)
boxplot(emailsSparse$logWordCount,emailsSparse$spam)

train2 = subset(emailsSparse, spl == TRUE)
test2 = subset(emailsSparse, spl == FALSE)

#CART Model Make prediction
spam2CART= rpart(spam ~., data=train2, method="class")
pred2CART = predict(spam2CART,newdata = test2)
pred2CART.prob = pred2CART[,2]
table(test2$spam, pred2CART.prob >= 0.5)
acc =(1214+384)/(1214+384+94+26)
acc
predROCRT21 = prediction(pred2CART.prob, test2$spam)
auc = as.numeric(performance(predROCRT21, "auc")@y.values)
auc
# Build random forest model # Make predictions
set.seed(123)
spam2RF = randomForest(spam ~., data = train2)
PredictForest2T = predict(spam2RF, newdata = test2,type="prob")
PredictForest2T.prob = PredictForest2T[,2]
table(test2$spam, PredictForest2T.prob >= 0.5)
(1298+397)/(1298+397+41)
#ROCR plot and AUC
predROCR2T = prediction(PredictForest2T.prob, test2$spam)
auc = as.numeric(performance(predROCR2T, "auc")@y.values)
auc

#Excerscise #7
install.packages("RTextTools")
library(RTextTools)
dtm2gram = create_matrix(as.character(corpusEmail), ngramLength=2)
str(dtm2gram)

spdtm2gram = removeSparseTerms(dtm2gram, 0.95)
str(spdtm2gram)

# Convert to a data frame
emailsSparse2gram = as.data.frame(as.matrix(spdtm2gram))
# Make all variable names R-friendly
colnames(emailsSparse2gram) = make.names(colnames(emailsSparse2gram))
emailsCombined = cbind(emailsSparse, emailsSparse2gram)


trainCombined = subset(emailsCombined, spl == TRUE)
testCombined= subset(emailsCombined, spl == FALSE)

#Build CART model
spamCARTcombined = rpart(spam ~., data=trainCombined, method="class")

prp(spamCARTcombined,varlen=0)

predCARTComb = predict(spamCARTcombined,newdata = testCombined)
predCARTComb.prob = predCARTComb[,2]
table(testCombined$spam, predCARTComb.prob >= 0.5)
(1233+374)/(1233+374+75+36)

predROCRTComb = prediction(predCARTComb.prob, testCombined$spam)
auc = as.numeric(performance(predROCRTComb, "auc")@y.values)
auc


#Build Random Forset
set.seed(123)
spamRFcombined = randomForest(spam ~., data = trainCombined)

PredictForestComb = predict(spamRFcombined, newdata = testCombined,type="prob")
PredictForestComb.prob = PredictForestComb[,2]
table(testCombined$spam, PredictForestComb.prob >= 0.5)
(1296+386)/(1296+386+36)

predROCRFComb = prediction(PredictForestComb.prob, testCombined$spam)
auc = as.numeric(performance(predROCRFComb, "auc")@y.values)
auc





