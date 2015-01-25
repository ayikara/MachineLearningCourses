movies = read.table("movieLens.txt", header=FALSE, sep="|",quote="\"")

# Add column names
colnames(movies) = c("ID", "Title", "ReleaseDate", "VideoReleaseDate", "IMDB", "Unknown", "Action", "Adventure", "Animation", "Childrens", "Comedy", "Crime", "Documentary", "Drama", "Fantasy", "FilmNoir", "Horror", "Musical", "Mystery", "Romance", "SciFi", "Thriller", "War", "Western")

str(movies)

# Remove unnecessary variables
movies$ID = NULL
movies$ReleaseDate = NULL
movies$VideoReleaseDate = NULL
movies$IMDB = NULL

# Remove duplicates
movies = unique(movies)
table(movies$Comedy)
table(movies$Western)
mvRomDrama = subset(movies, Romance==1 & Drama==1)
str(mvRomDrama)

#Video 6 ex
# Compute distances
distances = dist(movies[2:20], method = "euclidean")

# Hierarchical clustering
clusterMovies = hclust(distances, method = "ward") 
# Assign points to clusters
clusterGroups = cutree(clusterMovies, k = 2)

tapply(movies$Action, clusterGroups, mean)
tapply(movies$Romance, clusterGroups, mean)

tapply(movies$Unknown, clusterGroups, mean)
tapply(movies$Adventure, clusterGroups, mean)
tapply(movies$Animation, clusterGroups, mean)

tapply(movies$Drama, clusterGroups, mean)

