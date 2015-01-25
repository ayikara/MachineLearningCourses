str(df.train)

mode(df.train$fsc_small)
mode(df.train$chl_big)

attach(df.train)
plot(time, fsc_perp, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)

testrb=df.train[1:1000,]

attach(testrb)
plot(time, fsc_perp, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)

plot(time, fsc_small, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)


plot(time, fsc_big, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)


plot(time, pe, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)

plot(time, chl_small, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)


plot(time, chl_big, main="Scatterplot Example", 
  	xlab="Car Weight ", ylab="Miles Per Gallon ", pch=1)




