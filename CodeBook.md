---
Title: "CodeBook.md"
Author: "Allan Kavuma"
Date: "25/03/2019"
Project: "Human Activity Recognition using Smartphones"
---


## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set using data collected from 
accelerometers of Samsung Galaxy S smartphone.


### Data
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

### 1. Merges the training and the test sets to create one data set.
- 'traintestData': combines the trainData and testData dataframes; and assigned names in features dataset
- 'traintestActivity': combines the trainActivity and testActivity dataframes
- 'traintestSubject': combines the trainSubject and testSubject dataframes 
- 'completeData': combines all above 3 dataframes into one data set having activities, subjects and features

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
-'IndMeanStd': stores indices that will be used to extract measurements on only the mean and standard deviation
-'dataMeanStd': uses indices from IndMeanStd to get Data extracts on only the mean and standard deviation


### 3. Uses descriptive activity names to name the activities in the data set
- 'activityDf': dataframe that stores the different activities in the activity_labels.txt file
- 'actLow': vector to store all activity labels in lower case and having \"\_\" charaters and white spaces removed. It is turned into factor variable and values assigned to values in activity variable of the complete data


### 4. Appropriately labels the data set with descriptive variable names.
- variable names of completeData are turned into descriptive variable names by removing \"\,\", \"\\\", \"\-\", characters and white spaces; turning \"Acc\" and \"Gyro\" short forms into full names of \"Accelerometer\" and \"Gyroscope\"; and turning all names to lower case

### 5. From the data set in step 4, creates a second, independent tidy data 
- 'compMelt': While maintaining the subject and activity as the id variables, the rest of the variables of completeData are melted and result stored in compMelt dataframe 
- 'SubjectActivity_Vmeans': The compMelt melted dataframe is recast to a dataframe having means of the different variables matching the different subjects and activities; and stored in SubjectActivity_Vmeans dataframe
- The result is stored in a file named SubjectActivityVmeans.csv
