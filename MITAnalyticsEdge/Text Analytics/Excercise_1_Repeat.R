clinical = read.csv("clinical_trial.csv", stringsAsFactors=FALSE)
str
summary(clinical)
str(clinical)
clinical[which.max(nchar(clinical$abstract)),]


noAbsSub <- subset(clinical, nchar(clinical$abstract) ==0)
summary(noAbsSub)
str(noAbsSub)
clinical[which.min(nchar(clinical$title))]
clinical[1258,]


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

#Removed Stopword
corpusTitle = tm_map(corpusTitle, removeWords, stopwords("english"))
corpusAbstract = tm_map(corpusAbstract, removeWords, stopwords("english"))

# Create matrix
dtmTitle = DocumentTermMatrix(corpusTitle)
dtmAbstract = DocumentTermMatrix(corpusAbstract)

# Remove sparse terms
dtmTitle = removeSparseTerms(dtmTitle, 0.95)
dtmAbstract = removeSparseTerms(dtmAbstract, 0.95)

# Create data frame
dfTitle = as.data.frame(as.matrix(dtmTitle))
dfAbstract = as.data.frame(as.matrix(dtmAbstract))

# Make all variable names R-friendly

colnames(dfTitle) = make.names(colnames(dfTitle))
colnames(dfAbstract) = make.names(colnames(dfAbstract))

length(stopwords("english")) 
str(dfTitle)
summary(dfTitle)
str(dfAbstract)

dfAbstract[which.max(colSums(dfAbstract))]

colnames(dfTitle) = paste0("T", colnames(dfTitle))

colnames(dfAbstract) = paste0("A", colnames(dfAbstract))

dtm <- cbind(dfTitle,dfAbstract)
dtm$trial = clinical$trial
str(dtm)
summary(dtm)
dtm

# Split the data

library(caTools)

set.seed(144)

split = sample.split(dtm$trial, SplitRatio = 0.7)

train = subset(dtm, split==TRUE)
test = subset(dtm, split==FALSE)
table(dtm$trial)
1043/(1043+817)

# Build a CART model
str(train)
summary(train)
library(rpart)
library(rpart.plot)

clinicalCART = rpart(trial ~., data=train, method="class")

prp(clinicalCART)

PredictCART = predict(clinicalCART,type = "class")
table(train$trial, PredictCART)
(648+396)/nrow(train)
(636+426)/(636+426+146+94)

PredictCART2 = predict(clinicalCART,newdata ="test",type = "class")




