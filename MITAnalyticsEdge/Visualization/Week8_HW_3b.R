# Load our data, which lives in intl.csv
tweets= read.csv("tweets.csv", stringsAsFactors=FALSE)

# Install new packages
library(tm)
library(SnowballC)

# Create corpus 
corpus = Corpus(VectorSource(tweets$Tweet))

# Convert to lower-case
corpus = tm_map(corpus, tolower)

# Remove punctuation
corpus = tm_map(corpus, removePunctuation)

# Remove stopwords 
corpus = tm_map(corpus, removeWords, c(stopwords("english")))

# Create matrix

frequencies = DocumentTermMatrix(corpus)

# Convert to a data frame

allTweets = as.data.frame(as.matrix(frequencies))

str(allTweets)

#Install Word cloud
install.packages("wordcloud")
library(wordcloud)

#Get vector of words
wordcloud()
allTweets$word

colSums(allTweets)
#Building a word cloud
wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

# Remove stopwords and apple
corpus = tm_map(corpus, removeWords, c("apple", stopwords("english")))

# Create matrix

frequencies = DocumentTermMatrix(corpus)

# Convert to a data frame

allTweets = as.data.frame(as.matrix(frequencies))

#Building a word cloud
wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

str(allTweets)
str(tweets)
str(corpus)
corpus$Avg

#getting the Negative tweets, AVG <-1
allTweets$Avg = tweets$Avg
negativeTweets = subset(allTweets, Avg <=-1)

#Building a word cloud of negative tweets
wordcloud(names(colSums(negativeTweets)),colSums(negativeTweets),, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

wordcloud(names(colSums(negativeTweets)),colSums(negativeTweets),rot.per=.1, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

#rot.per parameter

wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
#??wordcloud
wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=TRUE, colors=brewer.pal(8, "Dark2"))

wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=FALSE, colors=brewer.pal(8, "Dark2"))

#Playing with colors
clr = c("purple")
ordered.colors

wordcloud(names(colSums(allTweets)),colSums(allTweets),, random.order=TRUE, colors=clr, ordered.colors =TRUE)

library(RColorBrewer)
brewer.pal



