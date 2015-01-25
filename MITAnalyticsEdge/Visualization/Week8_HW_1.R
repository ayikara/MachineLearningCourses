library(ggplot2)
library(maps)
library(ggmap)
statesMap = map_data("state")
library(maps)
str(statesMap)
table(statesMap$group)

ggplot(statesMap, aes(x = long, y = lat, group = group)) + geom_polygon(fill = "white", color = "green") + coord_map("mercator")

polling = read.csv("PollingImputed.csv")
str(polling)
train = subset(polling, Year ==2004 | Year ==2008)
test = subset(polling, Year ==2012)

mod2 = glm(Republican~SurveyUSA+DiffCount, data=train, family="binomial")
TestPrediction = predict(mod2, newdata=test, type="response")
str(TestPrediction)
TestPrediction
TestPredictionBinary = as.numeric(TestPrediction > 0.5)
predictionDataFrame = data.frame(TestPrediction, TestPredictionBinary, test$State)
nrow(subset(predictionDataFrame, TestPredictionBinary==1))
summary(mod2)
summary(TestPrediction)

predictionDataFrame$region = tolower(predictionDataFrame$test.State)
predictionDataFrame$region
predictionMap = merge(statesMap, predictionDataFrame, by = "region")
predictionMap = predictionMap[order(predictionMap$order),]
nrow(predictionMap)
nrow(statesMap)

ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary)) + geom_polygon(color = "black")

ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPredictionBinary))+ geom_polygon(color = "black") + scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")

ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPrediction))+ geom_polygon(color = "black") + scale_fill_gradient(low = "blue", high = "red", guide = "legend", breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")
str(TestPrediction)
flPred =subset(predictionMap,predictionDataFrame$test.State =="florida")
flPred$TestPrediction
str(predictionMap)
flPred =subset(predictionMap,region =="florida")
summary(flPred$TestPrediction)
str(TestPrediction)


ggplot(predictionMap, aes(x = long, y = lat, group = group, fill = TestPrediction))+ 
geom_polygon(color = "black", linetype =3, size = 3) + scale_fill_gradient(low = "blue", high = "red", guide = "legend",  
breaks= c(0,1), labels = c("Democrat", "Republican"), name = "Prediction 2012")

??geom_polygon