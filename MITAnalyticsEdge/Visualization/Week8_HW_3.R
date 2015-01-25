edges = read.csv("edges.csv")
users = read.csv("users.csv")
nrow(users)
str(users)
str(edges)
table(users$school)

install.packages("igraph")
library(igraph)
?graph.data.frame
?graph.data.frame
g = graph.data.frame(edges, FALSE, users)
plot(g, vertex.size=5, vertex.label=NA)
dfdeg = degree(g)
str(dfdeg)
dfdeg2 = subset(dfdeg,dfdeg$num>9)
table(dfdeg)

V(g)$size = degree(g)/2+2
plot(g, vertex.label=NA)

g2 = graph.data.frame(edges, FALSE, users)
dfdeg2 = degree(g2)
dfdeg2
V(g2)$size = degree(g2)/2+2 
table(V(g2)$size)

V(g)$color = "black"

V(g)$color[V(g)$gender == "A"] = "red"

V(g)$color[V(g)$gender == "B"] = "gray"

plot(g, vertex.label=NA)

table(V(g2)$gender)
table(V(g2)$school)

V(g)$color = "black"

V(g)$color[V(g)$school == "A"] = "red"

V(g)$color[V(g)$school == "B"] = "gray"

V(g)$color[V(g)$school == "AB"] = "yellow"

plot(g, vertex.label=NA)
table(V(g)$school,V(g)$size)


