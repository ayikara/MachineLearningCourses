airlines =  read.csv("AirlinesCluster.csv") 
str(airlines)

sort(colSums(airlines))
library(caret)

preproc = preProcess(airlines)

airlinesNorm = predict(preproc, airlines)

sort(colSums(airlinesNorm))

max(airlinesNorm$BonusTrans)
max(airlinesNorm$BonusMiles)
max(airlinesNorm$FlightTrans)
max(airlinesNorm$FlightMiles)
max(airlinesNorm$QualMiles)
max(airlinesNorm$Balance)
max(airlinesNorm$DaysSinceEnroll)

min(airlinesNorm$BonusTrans)
min(airlinesNorm$BonusMiles)
min(airlinesNorm$FlightTrans)
min(airlinesNorm$FlightMiles)
min(airlinesNorm$QualMiles)
min(airlinesNorm$Balance)
min(airlinesNorm$DaysSinceEnroll)

str(airlinesNorm)
# Compute distances
distances = dist(airlinesNorm, method = "euclidean")
 #Dont want to cluster on Document variable hence started at 2
# Hierarchical clustering
clusterAirlines = hclust(distances, method = "ward") 
# Plot the dendrogram
plot(clusterAirlines)

# Assign points to clusters
clusterGroups = cutree(clusterAirlines, k = 5)
str(clusterGroups)
clust1 = subset(airlines, clusterGroups==1)
clust2 = subset(airlines, clusterGroups==2)
clust3 = subset(airlines, clusterGroups==3)
clust4 = subset(airlines, clusterGroups==4)
clust5 = subset(airlines, clusterGroups==5)
nrow(clust1)
str(clust1)
str(airlines)
tapply(airlines$Balance, clusterGroups, mean)
tapply(airlines$QualMiles, clusterGroups, mean)
tapply(airlines$BonusMiles, clusterGroups, mean)
tapply(airlines$BonusTrans, clusterGroups, mean)
tapply(airlines$FlightMiles, clusterGroups, mean)
tapply(airlines$FlightTrans, clusterGroups, mean)
tapply(airlines$DaysSinceEnroll, clusterGroups, mean)

#
# Specify number of clusters
k = 5

# Run k-means
set.seed(88)
KMC = kmeans(airlinesNorm, centers = k, iter.max = 1000)
str(KMC)

# Extract clusters
airlinesClusters = KMC$cluster
str(airlinesClusters)
str(KMC)
kmcGT1000 = subset(KMC, KMC$size >1000)
nrow(kmcGT1000)
KMC$size

