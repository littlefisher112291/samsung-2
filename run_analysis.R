
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "./data", method = "curl")

TrainDF <- read.table("./data/X_train.txt", stringsAsFactors = FALSE)

ColHeadings <- read.table("./data/features.txt", stringsAsFactors = FALSE)

TestDF <- read.table("./data/X_test.txt", stringsAsFactors = FALSE)

testActivityCol <- read.table("./data/y_test.txt")
trainActivityCol <- read.table("./data/y_train.txt")
testSubjectCol <- read.table("./data/subject_test.txt")
trainSubjectCol <- read.table("./data/subject_train.txt")

activityLabels <- read.table("./data/activity_labels.txt")

trainSubActDF <- cbind(trainSubjectCol, trainActivityCol, TrainDF)

testSubActDF <- cbind(testSubjectCol, testActivityCol, TestDF)

ColHeadingsSubset <- as.character(ColHeadings[, 2])

ColHeadingsComplete <- c("Subject", "Activity", ColHeadingsSubset)

ColHeadings <- t(ColHeadingsComplete)

colnames(trainSubActDF) <- ColHeadings

colnames(testSubActDF) <- ColHeadings

mergedData <- rbind(trainSubActDF, testSubActDF)

dups <- duplicated(mergedData)
dedupedData <- mergedData[!duplicated(names(mergedData))]

library(dplyr)
meanStd <- select(dedupedData, Subject, Activity, contains("mean"), contains("std"))

labeled <- data.frame("activity"= activityLabels[ ,2])
labelData <- labeled$activity[meanStd$Activity] 

labeledData <- mutate(meanStd, Activity = labelData)

measure <- select(labeledData, -contains("jerk"), -contains("mag"), -starts_with("f"), -starts_with("angle"))

newnames <- c("subjectid", "activity", "bodymotionaccelerationtimesignalmeanx", "bodymotionaccelerationtimesignalmeany", "bodymotionaccelerationtimesignalmeanz", "gravitationalaccelerationtimesignalmeanx", "gravitationalaccelerationtimesignalmeany", "gravitaitonalaccelerationtimesignalmeanz", "bodymotiongyroscopictimesignalmeanx", "bodymotiongyroscopictimesignalmeany", "bodymotiongyroscopictimesignalmeanz", "bodymotionaccelerationtimesignalstandarddeviationx", "bodymotionaccelerationtimesignalstandarddeviationy", "bodymotionaccelerationtimesignalstandarddeviationz", "gravitationalaccelerationtimesignalstandarddeviationx", "gravitationalaccelerationtimesignalstandarddeviationy", "gravitationalaccelerationtimesignalstandarddeviationz", "bodymotiongyroscopictimesignalstandarddeviationx", "bodymotiongyroscopictimesingalstandarddeviationy", "bodymotiongyroscopictimesignalstandarddeviationz")

names(measure) <- newnames

table <- tbl_df(measure)
bySubAct <- group_by(measure, subjectid, activity)
averageByGroup <- summarise_each(bySubAct, funs(mean), vars = -c(subjectid, activity))
View(averageByGroup)
