#Codebook 
## for samsung dataset on https://github.com/postess/samsung

The samsung data set is a subset of the public Human Activity Recognition database built by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz and available on the UCI Machine Learning Repository.
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data’s README file explains how the data was collected and presented and this code book explains the subset of that data on my github repo, https://github.com/postess/samsung.

### 1) Source Data Description from HAR README file:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. NOTE: In the samsung dataset, I merged the train and test datasets into one dataset. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Feature Selection (from features_info.txt in the HAR dataset)
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

### 2) Data dictionary for this samsung dataset

To create the samsung dataset I worked with the 561-feature vector as variables and did not include any inertial signals data. The subjects were volunteers in the study and each one performed each activity several times. This dataset extracts the mean and standard deviation for the time domain signals collected by the smartphone accelerometer and gyroscope for each subject performing each activity, and then shows the means of each mean and standard deviation measure. 
The time signals for linear acceleration and angular velocity (from the gyroscope) are the ‘raw data’—actual measurements—from which other variables, like jerk and magnitude, were calculated. This dataset only includes those time domain measurements, which are described in detail below.


Descriptions of column variables:

subjectid
Indicates which volunteer performed the activity in the observation.
Each of the 30 volunteers in the study is identified with a number from 1 to 30

activity
Indicates which activity of daily living was performed in the observation.
The volunteers performed six activities: laying, sitting, standing, walking, walking downstairs, and walking upstairs. Each activity was identified by a number between 1 and 6 in the activity_labels.txt file. I used the numeric vector from y_train and y_test to identify activities for each observation in the full dataset and changed the numbers to names using activity_labels.txt.


meanofbodymotionaccelerationtimesignalmeanx

Unit: standard gravity units
Description: The tBodyAcc-mean()-X feature in the source dataset estimated the mean for the time domain body motion acceleration signals for the x-axis. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotionaccelerationtimesignalmeany 

Unit: standard gravity units
Description: The tBodyAcc-mean()-Y feature in the source dataset estimated the mean for the time domain body motion acceleration signals for the y-axis. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotionaccelerationtimesignalmeanz

Unit:  standard gravity units
Description: The tBodyAcc-mean()-Z feature in the source dataset estimated the mean for the time domain body motion acceleration signals for the z-axis. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofgravitationalaccelerationtimesignalmeanx 

Unit: standard gravity units
Description: The tGravityAcc-mean()-X feature in the source dataset estimated the mean for the time domain gravitational acceleration signals on the x-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofgravitationalaccelerationtimesignalmeany 

Unit: standard gravity units
Description: The tGravityAcc-mean()-Y feature in the source dataset estimated the mean for the time domain gravitational acceleration signals on the y-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofgravitaitonalaccelerationtimesignalmeanz

Unit: standard gravity units
Description: The tGravityAcc-mean()-Z feature in the source dataset estimated the mean for the time domain gravitational acceleration signals on the z-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotiongyroscopictimesignalmeanx

Unit: radians per seconds
Description: The tBodyGyro-mean()-X feature in the source dataset estimated the mean for the time domain body motion angular velocity signals on the x-axis collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotiongyroscopictimesignalmeany 

Unit: radians per seconds
Description: The tBodyGyro-mean()-Y feature in the source dataset estimated the mean for the time domain body motion angular velocity signals on the y-axis, collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotiongyroscopictimesignalmeanz

Unit: radians per seconds
Description: The tBodyGyro-mean()-Z feature in the source dataset estimated the mean for the time domain body motion angular velocity signals on the z-axis, collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those means for each subject performing each activity.

meanofbodymotionaccelerationtimesignalstandarddeviationx

Unit: standard gravity units
Description: The tBodyAcc-std()-X feature in the source dataset estimated the standard deviation for the time domain body motion acceleration signals on the x-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofbodymotionaccelerationtimesignalstandarddeviationy 

Unit: standard gravity units
Description: The tBodyAcc-std()-Y feature in the source dataset estimated the standard deviation for the time domain body motion acceleration signals on the y-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofbodymotionaccelerationtimesignalstandarddeviationz

Unit: standard gravity units
Description: The tBodyAcc-std()-Z feature in the source dataset estimated the standard deviation for the time domain body motion acceleration signals on the z-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofgravitationalaccelerationtimesignalstandarddeviationx

Unit: standard gravity units
Description: The tGravityAcc-std()-X feature in the source dataset estimated the standard deviation for the time domain gravitational acceleration signals on the x-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofgravitationalaccelerationtimesignalstandarddeviationy

Unit: standard gravity units
Description: The tGravityAcc-std()-Y feature in the source dataset estimated the standard deviation for the time domain gravitational acceleration signals on the y-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofgravitationalaccelerationtimesignalstandarddeviationz 

Unit: standard gravity units
Description: The tGravityAcc-std()-Z feature in the source dataset estimated the standard deviation for the time domain gravitational acceleration signals on the z-axis, collected by the smarthphone accelerometer. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofbodymotiongyroscopictimesignalstandarddeviationx

Unit: radians per seconds
Description: The tBodyGyro-std()-X feature in the source dataset estimated the standard deviation for the time domain body motion angular velocity signals on the x-axis, collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.

meanofbodymotiongyroscopictimesingalstandarddeviationy

Unit: radians per seconds
Description: The tBodyGyro-std()-Y feature in the source dataset estimated the standard deviation for the time domain body motion angular velocity signals on the y-axis, collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.


meanofbodymotiongyroscopictimesignalstandarddeviationz

Unit: radians per seconds
Description: The tBodyGyro-std()-Z feature in the source dataset estimated the standard deviation for the time domain body motion angular velocity signals on the z-axis, collected by the smartphone gyroscope. This column in the samsung dataset is the mean of those standard deviations for each subject performing each activity.


citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
