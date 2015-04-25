# samsung
## Coursera Getting and Cleaning Data Course Project

I have one big script for this project and I explain step by step what the code does below. 
The tried to follow the assignment instructions carefully but the one place where I took some liberty with how I interpreted them is in Step 2. I interpreted Step 2's requirement to extract only the mean and standard deviation values for each "measurement" to refer to the mean and standard deviation for the actual measured variables among the 561 'features.' 
Looking at the README for the data and the "Relevant Papers" on the website for the data, I think that
the features ending in 'jerk' or 'mag' or beginning with 'f' or 'angle,' were all calculated, so I excluded those.

Other than that I think my process was pretty straightforward:
I downloaded and read the files, except the inertial signals as David Hood suggested in 
"David's personal course project FAQ."
I started to merge the test and train datasets by cbinding the subject and activity (y files) columns to the X_train and X_test tables.
I used the features.txt file for column headings after transposing it and adding headings for subject and activity, since I had added those columns.
When I tried to extract columns that included "mean" and "std", I got an error saying I had duplicate column names. I checked which were duplicates and none were mean or standard deviation variables, so I deleted the dups.
(Thanks to http://stackoverflow.com/questions/28549045/dplyr-select-error-found-duplicated-column-name for advice on that).
Next I converted the numbers identifying the activity to the name of the activity using activity_labels.txt and the existing activity column as an index.
When it came time to add descriptive variable names I started thinking about what mean and standard deviation variables we actually needed. It was this paper, referenced on the UCI website for the data http://www.jucs.org/jucs_19_9/energy_efficient_smartphone_based/jucs_19_09_1295_1314_anguita.pdf, page 1302 in particular, that made me think that only 18 of the variables were actually variables, and the rest were calculated from those. I'm not certain of that but it gave me a framework to keep manipulating the data. 
Based on my decision to exclude 'calculated' mean and SD variables, I used select() to remove all those columns and renamed the remaining variables based on the naming conventions from the video lecture.
Finally, and thanks to the tidy data swirl modules, I found the mean for each subject performing each activity with the plyr package's grouping and summarizing functions. Thanks also to Frederick Wildi on the discussion forum thread, "problem with ddply..." who suggested summarise_each. 
The annotated code is below for more detail. The code alone is in the run_analysis.R file in this repo's main directory. 
Thanks!


## Preliminaries: downloading and reading the files into R
## First download the zip file with the data for the project
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data", method = "curl")

## read datasets into R
## start with the big one, the training data set
TrainDF <- read.table("./data/X_train.txt", stringsAsFactors = FALSE)

## then load the features.txt file that we'll use for column headings
## for the merged dataset. Each feature is a variable, so one way to make 
## a tidy data set is to store each variable in a column. 
ColHeadings <- read.table("./data/features.txt", stringsAsFactors = FALSE)

## and the smaller test data set
TestDF <- read.table("./data/X_test.txt", stringsAsFactors = FALSE)

## next read in the columns that show code for the subject and activity 
## in each observation from y_train.txt, y_test.txt, subject_train.txt, 
## and subject_test.txt

testActivityCol <- read.table("./data/y_test.txt")
trainActivityCol <- read.table("./data/y_train.txt")
testSubjectCol <- read.table("./data/subject_test.txt")
trainSubjectCol <- read.table("./data/subject_train.txt")

## finally read the file with labels for the activity column so we 
## can eventually label the values in the activity column instead 
## of having numbers representing, sitting, walking, etc.

activityLabels <- read.table("./data/activity_labels.txt")

## Step 1 Merge the training and test sets to create one dataset:
## add activity and subject columns to train and test dataframes so each row
## shows the features values for each subject performing each activity

trainSubActDF <- cbind(trainSubjectCol, trainActivityCol, TrainDF)
View(trainSubActDF)

testSubActDF <- cbind(testSubjectCol, testActivityCol, TestDF)
View(testSubActDF)

## Clean up the ColHeadings. The first problem is that there are two rows, 
## one with labels (V1, V2) and one with the feature names we want
##first I subset ColHeadings to just have the second row, with the feature names
## use as.character so the new ColHeadingsSubset isn't stored as a factor string
ColHeadingsSubset <- as.character(ColHeadings[, 2])
View(ColHeadingsSubset)


## If I'm making column headings, then I have to account for the fact that
## I added the Subject and Activity labels as two additional columns to train and test datasets
## So I have to add those column headings to the vector with the feature names.

ColHeadingsComplete <- c("Subject", "Activity", ColHeadingsSubset)
View(ColHeadingsComplete)

## the next problem is that the feature names (with added Activity and Subject headers) 
## I want to use for column headings are stored in a column. 
## To be at the head of the other columns, the feature names need to be transposed to be in a row.
ColHeadings <- t(ColHeadingsComplete)
View(ColHeadings)


## now we have a row of 561 column headings we can attach
## to trainDF, which will now show values for each feature
## for each subject performing each activity

colnames(trainSubActDF) <- ColHeadings
View(trainSubActDF)

colnames(testSubActDF) <- ColHeadings
dim(testSubActDF)

## finally I use rbind to merge the test data with the train data 
## and then take a look at the result to see if it looks right
mergedData <- rbind(trainSubActDF, testSubActDF)
dim(mergedData)
View(mergedData)

## Step 2 extracting only the measurements on the mean and standard deviation for each measurement:
## This requires first eliminating duplicates. None of the duplicates are mean or SD 
## values, so we can safetly remove them
dups <- duplicated(mergedData)
View(dups)
dedupedData <- mergedData[!duplicated(names(mergedData))]

## then select the Subject and Activity columns along with any columns that contain "mean or "std"
library(dplyr)
meanStd <- select(dedupedData, Subject, Activity, contains("mean"), contains("std"))

## Step 3 Uses descriptive activity names to name the activities in the data set: 
## apply activity labels by creating a data frame with the activity labels
## and use the numbers in the existing Activity column to index the label list

labeled <- data.frame("activity"= activityLabels[ ,2])
labelData <- labeled$activity[meanStd$Activity] 

##then change the numbers to the labels with mutate

labeledData <- mutate(meanStd, Activity = labelData)
View(labeledData)

## Step 4 Appropriately labels the data set with descriptive variable names:
## first I cut out the mean and SD values for variables that are not 'measurements' 
## from the README, the features.info file and the papers cited on the UCI website, 
## it looks like only the tACC, tGyro, t BodyAcc, tGravityAcc, and tBodyGyro features are 
## measurements. The rest--the jerk, mag, and frequency features--are calculated from 
## those raw measurements.
## so i'm exluding any mean and SD measures for those calculated variables

measure <- select(labeledData, -contains("jerk"), -contains("mag"), -starts_with("f"), -starts_with("angle"))

## give the variables decriptive names that comply with the naming conventions
## lowercase, non-repetitive, no numbers or symbols, describe what the variable is

newnames <- c("subjectid", "activity", "meanbodyaccelx", "meanbodyaccely", "meanbodyaccelz", "meangravityaccelx", "meangravityaccely", "meangravityaccelz", "meanbodygyrox", "meanbodygyroy", "meanbodygyroz", "stdvbodyaccelx", "stdvbodyaccely", "stdvbodyaccelz", "stdvgravityaccelx", "stdvgravityaccely", "stdvgravityaccelz", "stdvbodygyrox", "stdvbodygyroy", "stdvbodygyroz")

names(measure) <- newnames

## find average of each variable for each subject and each activity
table <- tbl_df(measure)
bySubAct <- group_by(measure, subjectid, activity)
avergeByGroup <- summarise_each(bySubAct, funs(mean), vars = -c(subjectid, activity))
                 
