claims =  read.csv("reimbursement.csv")
str(claims)
chronic = subset(claims, alzheimers==1 | arthritis==1 | cancer==1 | copd == 1 | depression==1 | diabetes==1 | heart.failure==1 | ihd==1 | kidney==1 | osteoporosis==1 | stroke==1)
str(chronic) 
280427/458005
hist(claims$reimbursement2009)

#To measure skewdness
library(e1071)
reim2009 = claims$reimbursement2009     # dependent var 
skewness(reim2009)                # apply the skewness function 

log(1) 
claims$reimbursement2008 = log(claims$reimbursement2008+1)

claims$reimbursement2009 = log(claims$reimbursement2009+1)
hist(claims$reimbursement2009) 
claimsZ2009 =subset(claims,reimbursement2009==0)
nrow(claimsZ2009)/nrow(claims)

#Split the data 

set.seed(144)

spl = sample(1:nrow(claims), size=0.7*nrow(claims))

train = claims[spl,]

test = claims[-spl,]
nrow(train)
nrow(test)

lm.claims = lm(reimbursement2009 ~ ., data=train)
lm.claims = lm(reimbursement2009~., data=train)
summary(lm.claims)

predTrain = predict(lm.claims)
summary(predTrain)
lm.claimsNaive = lm(reimbursement2009 ~ reimbursement2008, data=train)
PredNaive = predict(lm.claimsNaive,mean(train$reimbursement2009))


SSEtrain= sum((train$reimbursement2009 - predTrain)^2)
SSTtrain = sum((train$reimbursement2009 - mean(train$reimbursement2009 ))^2)
RMSE = 1 - (SSEtrain/nrow(train))

RMSE = sqrt(SSE/nrow(NBA))

predTest = predict(lm.claims, newdata=test)
SSEtest= sum((test$reimbursement2009 - predTest)^2)
RMSEtest = 1 - (SSEtest/nrow(test))
summary(predTest)

SSEtest = sum((test$reimbursement2009 - predTrain)^2)
SST = sum((test$reimbursement2009 - mean(wine$Price))^2)
RMSEtest = sqrt(SSEtest/nrow(test))

SSE = sum((wineTest$Price - predictTest)^2)
SST = sum((wineTest$Price - mean(wine$Price))^2)
1 - SSE/SST

SSENaive = sum((test$reimbursement2009 - mean(train$reimbursement2008))^2)
RMSENaive = 1 - (SSENaive/nrow(test))

#Part II - Clustering

train.limited = train

train.limited$reimbursement2009 = NULL

test.limited = test

test.limited$reimbursement2009 = NULL

library(caret)

preproc = preProcess(train.limited)

train.norm = predict(preproc, train.limited)

test.norm = predict(preproc, test.limited)
str(train.norm)
mean(train.norm$arthritis)
mean(test.norm$arthritis)
hist(train.norm$arthritis)
hist(test.norm$arthritis)

# Specify number of clusters
k = 3

# Run k-means
set.seed(144)
km = kmeans(train.norm, centers = k)
str(km)

# Extract clusters
claimsClusters = km$cluster
str(claimsClusters)

clust1 = subset(train.norm, claimsClusters==1)
clust2 = subset(train.norm, claimsClusters==2)
clust3 = subset(train.norm, claimsClusters==3)

tapply(train.norm$age, claimsClusters, mean)
tapply(train.norm$stroke, claimsClusters, mean)
tapply(train.norm$reimbursement2008, claimsClusters, mean)
mean(train.norm$age)
mean(train.norm$stroke)
mean(train.norm$reimbursement2008)

install.packages("flexclust")
library(flexclust)

km.kcca = as.kcca(km, train.norm)

cluster.train = predict(km.kcca)

cluster.test = predict(km.kcca, newdata=test.norm)

--cluster.test[100]
--flexClusters = cluster.test$cluster
str(cluster.test)
clustA1 = subset(test.norm, cluster.test==1)
clustA2 = subset(test.norm, cluster.test==2)
clustA3 = subset(test.norm, cluster.test==3)
nrow(clustA2)
str(clustA2)
cls2 =subset(cluster.test,cluster.test==2)
summary(cls2)
str(cls2)

train1 = subset(train, cluster.test==1)
train2 = subset(train, cluster.test==2)
train3 = subset(train, cluster.test==3)

test1 = subset(test, cluster.test==1)
test2 = subset(test, cluster.test==2)
test3 = subset(test, cluster.test==3)

mean(train1$reimbursement2009)
mean(train2$reimbursement2009)
mean(train3$reimbursement2009)

lm1 = lm(reimbursement2009 ~ ., data=train1)
lm2 = lm(reimbursement2009 ~ ., data=train2)
lm3 = lm(reimbursement2009 ~ ., data=train3)
summary(lm1)
summary(lm2)
summary(lm3)

pred.test1 = predict(lm1, newdata=test1)
pred.test2 = predict(lm2, newdata=test2)
pred.test3 = predict(lm3, newdata=test3)
pred.test1
mean(pred.test1)
mean(pred.test2)
mean(pred.test3)
summary(pred.test2)

SSEtest1  = sum((pred.test1 - test1$reimbursement2009)^2)
RMSEtest1  = sqrt(SSEtest1/nrow(test1))
SSEtest2  = sum((pred.test2 - test2$reimbursement2009)^2)
RMSEtest2  = sqrt(SSEtest2/nrow(test2))
SSEtest3  = sum((pred.test3 - test3$reimbursement2009)^2)
RMSEtest3  = sqrt(SSEtest3/nrow(test3))

all.predictions = c(pred.test1, pred.test2, pred.test3)

all.outcomes = c(test1$reimbursement2009, test2$reimbursement2009, test3$reimbursement2009)

sqrt(mean((pred.test1 - test1$reimbursement2009)^2))

sqrt(mean((pred.test2 - test2$reimbursement2009)^2))

sqrt(mean((pred.test3 - test3$reimbursement2009)^2))

sqrt(mean((all.predictions - all.outcomes)^2))
sqrt(mean((all.predictions - test$reimbursement2009)^2))

