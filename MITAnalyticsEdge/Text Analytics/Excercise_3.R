emails = read.csv("emails.csv", stringsAsFactors=FALSE)
summary(emails)
str(emails)
table(emails$spam)
emails[1,]
subject
#Find the max of email len- longets email text
max(nchar(emails$text))
which.min(nchar(emails$text))
emails[1992,]
length(stopwords("english")) 

#Build the corpus
corpusEmail= Corpus(VectorSource(emails$text))

# Convert to lower-case
corpusEmail= tm_map(corpusEmail, tolower)

# Remove punctuation
corpusEmail= tm_map(corpusEmail, removePunctuation)

#Removed Stopword
corpusEmail= tm_map(corpusEmail, removeWords, stopwords("english"))

#Stem the document
corpusEmail= tm_map(corpusEmail, stemDocument)

#Create a DTM
dtm = DocumentTermMatrix(corpusEmail)
str(dtm)

# Remove sparse terms
spdtm = removeSparseTerms(dtm, 0.95)
str(spdtm)

# Convert to a data frame
emailsSparse = as.data.frame(as.matrix(spdtm))
#str(tweetsSparse)

# Make all variable names R-friendly
colnames(emailsSparse) = make.names(colnames(emailsSparse))

str(emailsSparse)
#Find Max of sum of frequencies across all terms
	#use colSums() 
which.max(colSums(emailsSparse))

csTrm = colSums(emailsSparse)
str(csTrm)
csTrm[92]

# Add dependent variable
emailsSparse$spam = emails$spam
str(emailsSparse)

#To find the word stems appear at least 5000 times
emailsSparse[1,]
table(emailsSparse$spam)
emailsHam =subset(emailsSparse, spam==0)
csHam = colSums(emailsHam)
str(csHam)
# Not working -- csHam5K =subset(csHam, csHam[,2]>4999)
sort(csHam)

emailsSpam =subset(emailsSparse, spam==1)
csSpam= colSums(emailsSpam)
sort(csSpam)

#Build model

emailsSparse$spam = as.factor(emailsSparse$spam) #Conver to a factor?

str(emailsSparse)

#Split to Train and Test
set.seed(123)

spl = sample.split(emailsSparse$spam, 0.7)

train = subset(emailsSparse, spl == TRUE)
test = subset(emailsSparse, spl == FALSE)



# Logistic Regression Model # Make predictions on training set

spamLog= glm(spam ~., data=train, family=binomial)
predLog =  predict(spamLog, type="response")
# Confusion matrix for threshold of  0.00001
table(train$spam, predLog >0.5)
(3052+954)/(3052+954+4) #4010
#get the probability
str(predLog)
sort(predLog)
predLog[1356]
preSub = subset(predLog,  predLog < 0.00001)
str(preSub)
preSub2 = subset(predLog,  predLog > 0.99999)
str(preSub2)
str(predLog)
4010 -3046-954
summary(spamLog)
#Predict against Test
predLog2 =  predict(spamLog, newdata =test, type="response")
table(test$spam, predLog2 >0.5)
(1257+376)/(1257+376+34+51)
#Question 3.5
# Prediction function
ROCRpred = prediction(predLog, train$spam)
ROCRpredT = prediction(predLog2, test$spam)
summary(ROCRpred)
# Performance function
ROCRperf = performance(ROCRpred, "tpr", "fpr")
ROCRperfT = performance(ROCRpredT, "tpr", "fpr")
auc = as.numeric(performance(ROCRpredT, "auc")@y.values)
auc

#CART Model Make prediction
clinicalCART = rpart(spam ~., data=train, method="class")
predCART = predict(clinicalCART)
prp(clinicalCART)
predCART[1:10,]
predCART.prob = predCART[,2]

# Compute accuracy

table(train$spam, predCART.prob >= 0.5)
(2885+894)/(2885+894+167+64)
predCART2 = predict(clinicalCART,newdata = test)
predCART2.prob = predCART2[,2]
table(test$spam, predCART2.prob >= 0.5)
(1228+386)/(1228+386+104)
#ROCR plot and AUC
predROCR2 = prediction(predCART.prob, train$spam)
predROCRT2 = prediction(predCART2.prob, test$spam)

perfROCR2 = performance(predROCR2, "tpr", "fpr")

plot(perfROCR2, colorize=TRUE)

# Compute AUC

auc = as.numeric(performance(predROCR2, "auc")@y.values)
auc = as.numeric(performance(predROCRT2, "auc")@y.values)
auc


# Install randomForest package
library(randomForest)

# Build random forest model # Make predictions
set.seed(123)
StevensForest = randomForest(spam ~., data = train)

PredictForest = predict(StevensForest,type="prob")
PredictForestT = predict(StevensForest, newdata = test,type="prob")

PredictForest.prob = PredictForest[,2]
PredictForestT.prob = PredictForestT[,2]
table(train$spam, PredictForest.prob >= 0.5)
(3013+918)/(3013+918+79)
table(test$spam, PredictForestT.prob >= 0.5)
(1290+387)/(1290+387+23+18)

#ROCR plot and AUC
predROCR3 = prediction(PredictForest.prob, train$spam)
predROCRT3 = prediction(PredictForestT.prob, test$spam)
perfROCR3 = performance(predROCR3, "tpr", "fpr")

plot(perfROCR2, colorize=TRUE)

# Compute AUC

auc = as.numeric(performance(predROCR3, "auc")@y.values)
auc
auc = as.numeric(performance(predROCRT3, "auc")@y.values)




