songs = read.csv("songs.csv")
str(songs)

year2010 = subset(songs,year==2010)
str(year2010)

artMJ = subset(songs,artistname=="Michael Jackson")
str(artMJ)
--summary(limited)
mjTop10 = subset(artMJ,Top10==1)
mjTop10

unique(songs$timesignature)
table(songs$timesignature)

which.max(songs$tempo) #This returns the Index
songs$songtitle[which.max(songs$tempo)] #returns thesongtitle for index

#Make subset of Train and Test
SongsTrain  = subset(songs, songs$year <2010)
SongsTest = subset(songs, songs$year >2009)

str(SongsTrain)

#Building a Model
nonvars = c("year", "songtitle", "artistname", "songID", "artistID")

SongsTrain = SongsTrain[ , !(names(SongsTrain) %in% nonvars) ]
SongsTest = SongsTest[ , !(names(SongsTest) %in% nonvars) ]

SongsLog1 = glm(Top10 ~ ., data=SongsTrain, family=binomial)
summary(SongsLog1)

cor(SongsTrain$loudness, SongsTrain$energy)

#create a model by removing 1 variable

SongsLog2 = glm(Top10 ~ . - loudness, data=SongsTrain, family=binomial)
summary(SongsLog2)

SongsLog3 = glm(Top10 ~ . - energy, data=SongsTrain, family=binomial)
summary(SongsLog3)


# Predictions on the test set
predictTest = predict(SongsLog3, type="response", newdata=SongsTest)

# Confusion matrix with threshold of 0.5
table(SongsTest$Top10, predictTest > 0.45)

table(SongsTest$Top10)

