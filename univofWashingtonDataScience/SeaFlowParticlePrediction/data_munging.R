summary(df.train)

table(df.train$pop)


## split training data into train batch and test batch
set.seed(23)
training.rows <- createDataPartition(df.train$pop,p = 0.5, list = FALSE)
train.batch <- df.train[training.rows, ]
test.batch <- df.train[-training.rows, ]
str(train.batch)
summary(train.batch)

p <- ggplot(data = train.batch, aes(x = pe, y =  chl_small, colour = pop))  #init. plot, specifying data and aes
p <- p + layer(geom = "point")  # add a layer with points geom
p  #render plot