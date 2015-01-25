#Function to read path
readData <- function(path.name, file.name, column.types, missing.types) {
  read.csv(  paste(path.name, file.name, sep="/") , 
            colClasses=column.types,
            na.strings=missing.types )
}
#getwd()
#file_id,time,cell_id,d1,d2,fsc_small,fsc_perp,fsc_big,pe,chl_small,chl_big,pop
Titanic.path <- getwd()
train.data.file <- "seaflow_21min.csv"
#test.data.file <- "test.csv"
missing.types <- c("NA", "")
train.column.types <- c('integer',# file_id
                        'integer',  # time 
                        'integer',  # cell_id
                        'integer',  # d1
                        'integer',  # d2
                        'integer',  # fsc_small
                        'integer',  # fsc_perp
                        'integer',  # fsc_big
                        'integer',  # pe
				'integer',  # chl_small  
				'integer',  # chl_big  
				'character'   # pop                    
)
#test.column.types <- train.column.types[1:9]     # # no Survived column in test.csv

train.raw <- readData(Titanic.path, train.data.file, 
                      train.column.types, missing.types)
df.train <- train.raw

#test.raw <- readData(Titanic.path, test.data.file, 
                     test.column.types, missing.types)
#df.infer <- test.raw  
