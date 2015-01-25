# Read dailykos.csv 

dailykos = read.csv("dailykos.csv")
str(dailykos)
# Compute distances
distances = dist(dailykos[2:1546], method = "euclidean")
 #Dont want to cluster on Document variable hence started at 2
# Hierarchical clustering
clusterDailykos = hclust(distances, method = "ward") 

# Plot the dendrogram
plot(clusterDailykos)

# Assign points to clusters
clusterGroups = cutree(clusterDailykos, k = 7)
str(clusterGroups)
clust1 = subset(dailykos, clusterGroups==1)
clust2 = subset(dailykos, clusterGroups==2)
clust3 = subset(dailykos, clusterGroups==3)
clust4 = subset(dailykos, clusterGroups==4)
clust5 = subset(dailykos, clusterGroups==5)
clust6 = subset(dailykos, clusterGroups==6)
clust7 = subset(dailykos, clusterGroups==7)
str(clust1)
nrow(clust1)
nrow(clust2)
nrow(clust3)
nrow(clust4)
nrow(clust5)
nrow(clust6)
nrow(clust7)

#Find the top 6 frequent words of a cluster
tail(sort(colMeans(clust1 [-1])))
tail(sort(colMeans(clust2 [-1])))
tail(sort(colMeans(clust3 [-1])))
tail(sort(colMeans(clust4 [-1])))
tail(sort(colMeans(clust5 [-1])))
tail(sort(colMeans(clust6 [-1])))
tail(sort(colMeans(clust7 [-1])))

# Specify number of clusters
k = 7

# Run k-means
set.seed(1000)
KMC = kmeans(dailykos[2:1546], centers = k)
str(KMC)
Kclust1 = subset(dailykos, KMC$cluster==1)
Kclust2 = subset(dailykos, KMC$cluster==2)
Kclust3 = subset(dailykos, KMC$cluster==3)
Kclust4 = subset(dailykos, KMC$cluster==4)
Kclust5 = subset(dailykos, KMC$cluster==5)
Kclust6 = subset(dailykos, KMC$cluster==6)
Kclust7 = subset(dailykos, KMC$cluster==7)

nrow(Kclust1)
nrow(Kclust2)
nrow(Kclust3)
nrow(Kclust4)
nrow(Kclust5)
nrow(Kclust6)
nrow(Kclust7)

#Find the top 6 frequent words of a cluster
tail(sort(colMeans(Kclust1 [-1])))
tail(sort(colMeans(Kclust2 [-1])))
tail(sort(colMeans(Kclust3 [-1])))
tail(sort(colMeans(Kclust4 [-1])))
tail(sort(colMeans(Kclust5 [-1])))
tail(sort(colMeans(Kclust6 [-1])))
tail(sort(colMeans(Kclust7 [-1])))

str(Kclust2)
table(Kclust2$democrat)
table(clust2$democrat)
sort(colSums(Kclust1 [-1]))




