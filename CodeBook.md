---
Title: "CodeBook.md"
Author: "Allan Kavuma"
Date: "25/03/2019"
Project: "Human Activity Recognition using Smartphones"
---

describes the variables, the data, and any transformations or work that you performed to clean up the data

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set using data collected from 
accelerometers of Samsung Galaxy S smartphone.


## Data
The data for project is downloaded here: (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
and stored in folder "UCI HAR Dataset"
#### The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

#### The following files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


### Variables and Data frames are created to store data from the files above as shown below
- 'harurl': Variable to carry url for source of project data
- 'testData': Dataframe for test set, from X_test.txt file
- 'trainData': Dataframe for training set, from X_train.txt file
- 'testActivity': Dataframe for test activities, from y_test.txt file
- 'trainActivity': Dataframe for training activities, from y_train.txt file
- 'testSubject': Dataframe for test subjects, from subject_test.txt file
- 'trainSubject': Dataframe for train subjects, from subject_train.txt file

## 1. Merges the training and the test sets to create one data set.
- 'traintestData': combines the trainData and testData dataframes; and assigned names in features dataset
- 'traintestActivity': combines the trainActivity and testActivity dataframes
- 'traintestSubject': combines the trainSubject and testSubject dataframes 
- 'completeData': combines all above 3 dataframes into one having activities, subjects and features

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
-'IndMeanStd': stores indices that will be used to extract measurements on only the mean and standard deviation
-'dataMeanStd': uses indices from IndMeanStd to get Data extracts on only the mean and standard deviation


## 3. Uses descriptive activity names to name the activities in the data set
activityDf <- read.table("activity_labels.txt")
actLow <- tolower(sapply(activityDf$V2, function(x) gsub("_", " ", x)))
#now label all names with activity
completeData$activity <- factor(completeData$activity, labels = actLow)


## 4. Appropriately labels the data set with descriptive variable names.
names(completeData) <- sapply(names(completeData), function(x) gsub("\\(", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\)", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\-", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("\\,", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub(" ", "", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("Acc", "Accelerometer", x))
names(completeData) <- sapply(names(completeData), function(x) gsub("Gyro", " Gyroscope", x))


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
write.csv(SubjectActivity_Vmeans, file = "SubjectActivityVmeans.csv", row.names = FALSE)
