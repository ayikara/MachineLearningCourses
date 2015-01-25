clinical = read.csv("clinical_trial.csv", stringsAsFactors=FALSE)
summary(clinical)
str(clinical)

#
library(tm)
#
library(SnowballC)
# Create corpus
corpusTitle= Corpus(VectorSource(clinical$title))
corpusAbstract= Corpus(VectorSource(clinical$abstract))

# Convert to lower-case

corpusTitle= tm_map(corpusTitle, tolower)
corpusAbstract= tm_map(corpusAbstract, tolower)

# Remove punctuation

corpusTitle= tm_map(corpusTitle, removePunctuation)
corpusAbstract= tm_map(corpusAbstract, removePunctuation)
length(stopwords("english")) 

#Removed Stopword
corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))

#Stem the document

corpusTitle = tm_map(corpusTitle, stemDocument)
corpusAbstract = tm_map(corpusAbstract, stemDocument)

dtmTitle = DocumentTermMatrix(corpusTitle)
dtmAbstract = DocumentTermMatrix(corpusAbstract)

#str(dtmTitle)
#str(dtmAbstract)

# Remove sparse terms
dtmTitle = removeSparseTerms(dtmTitle, 0.95)
dtmAbstract = removeSparseTerms(dtmAbstract, 0.95)

# Create data frame
dfTitle = as.data.frame(as.matrix(dtmTitle))
dfAbstract = as.data.frame(as.matrix(dtmAbstract))
str(dfAbstract)
str(dfTitle)

dfAbstract[which.max(colSums(dfAbstract))]
dfAbstract[212]
str(dfAbstract)

#colnames(dtmTitle) = paste0("T", colnames(dtmTitle))

#colnames(dtmAbstract) = paste0("A", colnames(dtmAbstract))

#dtm = cbind(dtmTitle,dtmAbstract)
#dtm$trial = clinical$trial
#str(dtm)

colnames(dfTitle) = paste0("T", colnames(dfTitle))

colnames(dfAbstract) = paste0("A", colnames(dfAbstract))

dtm2 = cbind(dfTitle,dfAbstract)
dtm2$trial = clinical$trial

# Split the data

library(caTools)

set.seed(144)

split = sample.split(dtm2$trial, SplitRatio = 0.7)

train = subset(dtm2, split==TRUE)
test = subset(dtm2, split==FALSE)
table(dtm$trial)

library(rpart)
library(rpart.plot)

clinicalCART = rpart(trial ~., data=train, method="class")
pred = predict(clinicalCART)
pred[1:10,]
pred.prob = pred[,2]

max(pred.prob)

table(train$trial, pred.prob >= 0.5)
(631+441)/(631+441+131+99)
441/(441+131)
631/(631+99)

#Predict on Test

predTest = predict(clinicalCART, newdata=test)
predTest[1:10,]
predTest.prob = predTest[,2]
table(test$trial, predTest.prob >= 0.5)

(261+162)/(261+162+83+52)

# ROC curve

library(ROCR)

predROCR = prediction(predTest.prob, test$trial)

perfROCR = performance(predROCR, "tpr", "fpr")

plot(perfROCR, colorize=TRUE)

# Compute AUC

performance(predROCR, "auc")@y.values



