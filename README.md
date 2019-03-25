# HumanActivityRecognitionProject
The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.
Data analysed is collected from the Accelerometers of the Samsung Galaxy S smartphone, whose full description is [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).


## THE SCRIPTS 

### CodeBook.md
Codebook.md describes the variables, the data, and any transformations or work that I performed in run_analysis.R to clean up the data.

### run_analysis.R
run_analysis.R is the R script I created to get and clean the data.
It downloads the data set of Human Activity Recognition using Samsung Galaxy S smartphone from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and does the following;
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

**SubjectActivityVmeans.csv** is the tidy data set produced after the above steps


#### Acknowledgments
* John Hopkins Bloomberg School of Public Health
* Jeffrey Leek
* Roger Peng
