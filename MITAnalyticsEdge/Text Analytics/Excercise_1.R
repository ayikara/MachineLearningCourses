wiki = read.csv("wiki.csv", stringsAsFactors=FALSE)
str(wiki)
table(wiki$Vandal)
wiki$Vandal = as.factor(wiki$Vandal)

#library(tm)
#library(SnowballC)
# Create corpus
 
corpusAdded = Corpus(VectorSource(wiki$Added))
# Remove stopwords and apple
length(stopwords("english")) 
#corpusAdded = tm_map(corpusAdded, removeWords, stopwords("english"))
corpusAdded = tm_map(corpusAdded, removeWords, sw)
#sw = c("i", "me", "my", "myself", "we", "our", "ours", "ourselves", "you", "your", "yours", "yourself", "yourselves", "he", "him", "his", "himself", "she", "her", "hers", "herself", "it", "its", "itself", "they", "them", "their", "theirs", "themselves", "what", "which", "who", "whom", "this", "that", "these", "those", "am", "is", "are", "was", "were", "be", "been", "being", "have", "has", "had", "having", "do", "does", "did", "doing", "would", "should", "could", "ought", "i'm", "you're", "he's", "she's", "it's", "we're", "they're", "i've", "you've", "we've", "they've", "i'd", "you'd", "he'd", "she'd", "we'd", "they'd", "i'll", "you'll", "he'll", "she'll", "we'll", "they'll", "isn't", "aren't", "wasn't", "weren't", "hasn't", "haven't", "hadn't", "doesn't", "don't", "didn't", "won't", "wouldn't", "shan't", "shouldn't", "can't", "cannot", "couldn't", "mustn't", "let's", "that's", "who's", "what's", "here's", "there's", "when's", "where's", "why's", "how's", "a", "an", "the", "and", "but", "if", "or", "because", "as", "until", "while", "of", "at", "by", "for", "with", "about", "against", "between", "into", "through", "during", "before", "after", "above", "below", "to", "from", "up", "down", "in", "out", "on", "off", "over", "under", "again", "further", "then", "once", "here", "there", "when", "where", "why", "how", "all", "any", "both", "each", "few", "more", "most", "other", "some", "such", "no", "nor", "not", "only", "own", "same", "so", "than", "too", "very")

# Stem document 

corpusAdded= tm_map(corpusAdded, stemDocument)
dtmAdded = DocumentTermMatrix(corpusAdded)
summary(dtmAdded)
dtmAdded
sparseAdded = removeSparseTerms(dtmAdded, 0.997)
1-(.3/100)
sparseAdded

# Convert to a data frame

wordsAdded = as.data.frame(as.matrix(sparseAdded))

colnames(wordsAdded) = paste("A", colnames(wordsAdded))

corpusRemoved = Corpus(VectorSource(wiki$Removed))
corpusRemoved = tm_map(corpusRemoved, removeWords, sw)
corpusRemoved = tm_map(corpusRemoved, stemDocument)
dtmRemoved = DocumentTermMatrix(corpusRemoved)
sparseRemoved = removeSparseTerms(dtmRemoved, 0.997)

wordsRemoved = as.data.frame(as.matrix(sparseRemoved))
colnames(wordsRemoved) = paste("R", colnames(wordsRemoved))
summary(wordsRemoved)
str(wordsRemoved)
wikiWords = cbind(wordsRemoved,wordsAdded)
wikiWords$Vandal= wiki$Vandal

# Split the data

library(caTools)

set.seed(123)

split = sample.split(wikiWords$Vandal, SplitRatio = 0.7)

train = subset(wikiWords, split==TRUE)
test = subset(wikiWords, split==FALSE)

table(wikiWords$Vandal)
2061/(1815+2061)

# Build a CART model

library(rpart)
library(rpart.plot)

vandalCART = rpart(Vandal ~ ., data=train, method="class")
prp(vandalCART)

# Evaluate the performance of the model
predictCART = predict(vandalCART, newdata=test, type="class")

table(test$Vandal, predictCART)
(618+12)/(618+12+533)

wikiWords2 = wikiWords
wikiWords2$HTTP = ifelse(grepl("http",wiki$Added,fixed=TRUE), 1, 0)
table(wikiWords2$HTTP)

wikiTrain2 = subset(wikiWords2, split==TRUE)

wikiTest2 = subset(wikiWords2, split==FALSE)

vandal2CART = rpart(Vandal ~ ., data=wikiTrain2, method="class")

prp(vandal2CART)

# Evaluate the performance of the model
predict2CART = predict(vandal2CART, newdata=wikiTest2, type="class")
table(wikiTest2$Vandal, predict2CART)
(609+57)/(609+57+488+9)

wikiWords2$NumWordsAdded = rowSums(as.matrix(dtmAdded))

wikiWords2$NumWordsRemoved = rowSums(as.matrix(dtmRemoved))

#Average Number of words added
sum(wikiWords2$NumWordsAdded)
sum(wikiWords2$NumWordsRemoved)
str(wikiWords2)
15698/3876

#Third cart model

wikiTrain3 = subset(wikiWords2, split==TRUE)

wikiTest3 = subset(wikiWords2, split==FALSE)

vandal3CART = rpart(Vandal ~ ., data=wikiTrain3, method="class")

prp(vandal3CART)
# Evaluate the performance of the model
predict3CART = predict(vandal3CART, newdata=wikiTest3, type="class")
table(wikiTest3$Vandal, predict3CART)
(514+248)/(514+248+297+104)

#Using non-textual data

wikiWords3 = wikiWords2

wikiWords3$Minor = wiki$Minor

wikiWords3$Loggedin = wiki$Loggedin

#Fourth cart model

wikiTrain4 = subset(wikiWords3, split==TRUE)

wikiTest4 = subset(wikiWords3, split==FALSE)

vandal4CART = rpart(Vandal ~ ., data=wikiTrain4, method="class")

predict4CART = predict(vandal4CART, newdata=wikiTest4, type="class")
table(wikiTest4$Vandal, predict4CART)
(595+241)/(595+241+304+23)


prp(vandal4CART)

