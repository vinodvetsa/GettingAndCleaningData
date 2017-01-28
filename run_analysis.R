###
## exhaustive Details in markdown documents
## There are two distributed sets train & test
## Each of these sets have three data sets viz: X / y / subject
## X being measurements, y being label and Subject being represented by measuremnt type
###
## Step 1.
## Tidy data set : each row one observation, each column one meaurement, no distribution
##
## on loading data and seeing dimension (dim), XTrain/XTest same columns- rbind
##  
## Y & Subject of train and test data to be coulmn binded to respective sets -cbind
##
## Features.txt has lables use colNames, name Y and subject (cbinded)
## Set is tidy !
###
## use dplyr
## use grep[^(mean\\(\\)| std\\(\\)) on columnnames with select of dplyr
## 
## Keep the run_analysis.R in the folder where Dataset.zip extracted.
##
###

run_analysis <- function()

{
        
        dataLocation <- "./Dataset/UCI HAR Dataset"
        
        xtest <- read.table(file.path(dataLocation, "test", "X_test.txt"), head= F)
        ytest <- read.table(file.path(dataLocation, "test", "y_test.txt"), head=F)
        subjectTest<-read.table(file.path(dataLocation, "test","subject_test.txt"), head=FALSE)
        
        xtrain <- read.table(file.path(dataLocation, "train", "X_train.txt"), head=F)
        ytrain <- read.table(file.path(dataLocation, "train", "y_train.txt"), head=F)
        subjectTrain <- read.table(file.path(dataLocation, "train", "subject_train.txt"), head=F)
        
        
        xtest <- cbind(subjectTest, ytest, xtest)
        xtrain <- cbind(subjectTrain, ytrain, xtrain)
        
        ##almost tidy without labels and headers
        test_n_train <- rbind(xtest,xtrain)

        
        ##let's name the columns and label i.e. test names
        
        
        
        headersTable<- read.table(file.path(dataLocation, "features.txt"), head = F)
        library("dplyr")
        headersTable<- tbl_df(headersTable)
        
        ###Format headersTable$V2
        ## Clean special characters
        ###
        headersTable$V2 <- gsub(pattern="^t", replacement = "Time", headersTable$V2)
        headersTable$V2 <- gsub(pattern="^f", replacement="Frequency", headersTable$V2)
        headersTable$V2 <- gsub(pattern="Acc", replacement="Accelerometer", headersTable$V2)
        headersTable$V2 <- gsub(pattern= "Mag", replacement="Magnitude", headersTable$V2)
        headersTable$V2 <- gsub(pattern="Gyro", replacement="Gyroscope", headersTable$V2)
        headersTable$V2 <- gsub(pattern="BodyBody", replacement="Body", headersTable$V2)
        
        
        
        ### column is a formatted three char number + reading
        ## headersTable$V2  is not unique, so dplyr will not work
        ## length(headersTable$V2) = 561   &    length(unique(headersTable$V2)) is 477
        ## so headersTable$V1 + headersTable$V2 ... will work
        ###
        
        formatter<- function(x){sprintf("%03d", x)}
        headersTable$V1 <- sapply(headersTable$V1, formatter)
        headersTable <- mutate(headersTable, label=paste(V1, V2, sep="_"))
        
        
        ### Column Names
        headers <- c("Subject", "Activity", headersTable$label )
        colnames(test_n_train) <- headers

        test_n_train <- tbl_df(test_n_train)
        
        activityLabels <- read.table(file.path(dataLocation, "activity_labels.txt"), header=F)
        activityLabels <- tbl_df(activityLabels)
        colnames(activityLabels) <- c("Id", "Activity")
        
        test_n_train<- merge( x= activityLabels, y=test_n_train, by.x="Id", by.y ="Activity")
        #test_n_train<- merge( y= activityLabels, x=test_n_train, by.y="Id", by.x ="Activity")
        test_n_train <- tbl_df(test_n_train)
        test_n_train <- select(test_n_train, -Id)
        
        ## Answer for Step 1
        ##  is in test_n_train
        
        

#####
##
##      Step 2 
##
#####
        
        
        totalColumns<- names(test_n_train)
        returnColumns <- totalColumns[grep("mean\\(\\)|std\\(\\)", x = totalColumns)]
        returnColumns <- c("Subject", "Activity", returnColumns)
        
        test_n_train <- subset( test_n_train, select=returnColumns)

###
#  
#       Step3 Names already given appropriately prepended with features$V1
#
###

        
###
#
#       Step 4: Aggregated 
#
###
        aggregatedOutput <- aggregate(x=test_n_train[,3:length(names(test_n_train))], by=list(Subject=test_n_train$Subject, Activity=test_n_train$Activity), FUN=mean)
        
###     Replace the prepended features$V1
        part1 <- names(aggregatedOutput)[1:2]
        part2 <- gsub("^....", "", names(aggregatedOutput)[3:length(names(aggregatedOutput))])
        colnames(aggregatedOutput) <- c(part1, part2)
        aggregatedOutput
        
#####
#
#       write files
#
#####
        
        write.table(aggregatedOutput, file="./aggregatedTidyDataSet.txt", row.names = FALSE, sep = " ")
        
        
        aggregatedOutput
        
        
        
}
