#R script that does the following
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and each subject.

#Load libraries for the script
library(reshape2) #For part 5 involving melt / dcast functions

#Download and create the data frames in R
#Variable to carry url for source of project data
harurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download the data zip file and unzip files or set to directory 
#having files if it already exits.

if(!file.exists("UCI HAR Dataset")){
        download.file(harurl, destfile = "har.zip")
        unzip("har.zip")        #unzip the file
        dir.create("UCI HAR Dataset") #create dir
        setwd("./UCI HAR Dataset") #set working dir to UCI HAR Dataset
} else{
                setwd("./UCI HAR Dataset")
        }

## creating dataframe for test and training sets
testData <- read.table("./test/X_test.txt")
trainData <- read.table("./train/X_train.txt")



## creating dataframes for test and training activity
testActivity <- read.table("./test/y_test.txt", col.names = "activity")
trainActivity <- read.table("./train/y_train.txt", col.names = "activity")


## creating dataframes for test and training subjects
testSubject <- read.table("./test/subject_test.txt", col.names = "subject") 
trainSubject <- read.table("./train/subject_train.txt", col.names = "subject")

## creating dataframe for the features
features <- read.table("features.txt")

## joining train and test data rows
traintestData <- rbind(trainData, testData)
names(traintestData) <- features$V2 #giving column names

#joining train and test activity rows
traintestActivity <- rbind(trainActivity, testActivity)

#joining train and test subject rows
traintestSubject <- rbind(trainSubject, testSubject)

#joining all columns of the data sets to make complete dateset
completeData <- cbind(traintestData, traintestSubject, traintestActivity)


# 2. Extracts only the measurements on the mean and standard deviation for
#each measurement.

#Line to extract measurements on only the mean and standard deviation
#of each measurement
IndMeanStd <- grep("mean|std", names(completeData)) #IndMeanStd to store indices of this data

#Data extracts on only the mean and standard deviation stored in dataMeanStd
#The data having means and standard deviation is dataMeanStd
dataMeanStd <- completeData[IndMeanStd,]


## 3. Uses descriptive activity names to name the activities in the data set
activityDf <- read.table("activity_labels.txt")
actLow <- tolower(sapply(activityDf$V2, function(x) gsub("_", " ", x)))
actLow <- sapply(actLow, function(x) gsub(" ", "", x))
#now label all names with activity
completeData$activity <- factor(completeData$activity, labels = actLow)


## 4. Appropriately labels the data set with descriptive variable names.
names(completeData) <- sapply(names(completeData), function(x) gsub("\\(", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\)", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\-", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\,", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub(" ", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("Acc", "Accelerometer", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("Gyro", "Gyroscope", x))
names(completeData) <- tolower(names(completeData))


# 5. From the data set in step 4, creates a second, independent tidy data 
#set with the average of each variable for each activity and 
#each subject.

#Melt the complete data set with focus id variables of subject and activity
#while melting the rest of the varibles about these
compMelt <- melt(completeData, id = c("subject", "activity"))

#recasting the compMelt melted data set into one with varible means
#of all the variables matching subject and activity varibles
SubjectActivity_Vmeans <- dcast(compMelt,subject+activity ~ variable, mean )

#write result dataframe to file
write.table(SubjectActivity_Vmeans, file = "SubjectActivityVmeans.csv", row.names = FALSE)

## Exit the directory having the files
setwd("..")
