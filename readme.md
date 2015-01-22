==================================================================
Tidied Human Activity Recognition Using Smartphones Dataset
==================================================================
Version 1.0

Original Data collection by:
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

Data Tidying done by: BMc

Coursera: Getting and Cleaning Data

Course Project

https://github.com/coursera-bmc/courseproject

INITIAL DATA COLLECTION (explanation from initial study)
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'COLUMN INFORMATION' for more details. 

For each record it is provided: 
* A 68-feature vector with subject ID, Activity Name, time and frequency domain variables.  Each of these variables is the mean of all trials conducted with a given Subject - Activity combination.

DATA TIDYING PROCESS AND LOADING OF TIDY DATA TABLE
==================================================================

To reproduce the data tidying process, the zip file 'getdata_projectfiles_UCI HAR Dataset.zip' and R script 'run_analysis.R' may be downloaded from github.com/coursera-bmc/courseproject and placed in the current working directory for R.  Files can be placed elsewhere, but directory callouts in the R script must be updated to point to the correct location.

'run_analysis.R' is commented for a more in-depth look at methodology.
1. Data loaded from 'X_[test,train].txt', 'Y_[test,train].txt', and 'subject_[test,train].txt' and combined into a single table encompassing all of the data.  Column headers read from 'features.txt' and attached to the data table.
2. Per the assignment, only those columns pertaining to mean and standard deviation were retained.  NOTE: meanFreq columns are dropped.  Mean Frequency is a weighted average, which is different from a regular average.
3. Labels are updated and columns are sorted into a readable format.
4. Average is taken of each individual column of Subject:Activity readings and stored into new table.  This table is sorted by Subject and then ActivityName
5. Data frame printed to 'tidy_experiment_data.txt'

An already tidied data table is available as 'tidy_experiment_data.txt'.

###TO TIDY RAW DATA
1. Unpack zip to R working directory.  The top level folder should be './getdata_projectfiles_UCI HAR Dataset'
2. Open R and load the 'run_analysis.R' source file.
  * If in Working Directory, use source('./run_analysis.R')
3. Execute function run_analysis(returnType).  This will return the tidy data set in one of two ways:
  * If executed as run_analysis(TRUE), the data will be printed to './tidy_experiment_data.txt' as well as returned as output from the function.
  * If no arguments are given or run_analysis(FALSE) is executed, no file will be written.
4. TO LOAD the file 'tidy_experiment_data.txt' into R, use read.table('tidy_experiment_data.txt', header=TRUE).

COLUMN INFORMATION
==================================================================
All columns are the mean of measurements for each grouping of Subject ID - Activity Name sets.  That is, each column should be understood as "The Mean of <column_name>".

Each column has a specific formula for reading and understanding the name:

1. 't' or 'f'
  * 't' = time domain signal 
  * 'f' = frequency domain signal obtained via a Fast Fourier Transform on the equivalent 't' value column
2. 'Body' or 'Gravity'
  * 'Body' = Measurement accounted for by independent acceleration of body
  * 'Gravity' = Measurement accounted for by acceleration due to gravity
3. 'Acc', 'Gyro'
  * 'Acc' = From accelerometer signal.  These readings are in m/s^2.
  * 'Gyro' = From gyroscope signal.  These readings are in rad/s^2
4. 'Jerk' = Deals with Todd.  Also refers to "acceleration of acceleration" aka Time Rate of Acceleration.  These measurements are in m/s^3 or rad/s^3 depending on if the Jerk is angular or linear.
5. 'Mag' = Magnitude calculated via Euclidean norm.  A 'Mag' measurement is derived from the 'X','Y', and 'Z' columns sharing the same characteristics.
6. 'std' or 'mean'
  * 'std' = Standard deviation of measurement.  This is calculated from raw data found in original (non tidy) files.
  * 'mean' = Mean of measurement. This is calculated from raw data found in original (non tidy) files.
7. 'X', 'Y', 'Z' = Component value of a given vector measurement
8. 'Subject' = Subject ID number identifying an individual being tested.  Range: 1-30
9. 'ActivityName' = One of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) conducted by a subject.


#####What units go with which columns?

If 'Jerk' and 'Acc' are present in column name: m/s^3

If 'Jerk' and 'Gyro' are present in column name: rad/s^3

If only 'Acc' is present in column name: m/s^3

If only 'Gyro' is present in column name: rad/s^3 

##Column Names

"Subject"		"ActivityName"

"fBodyAcc.mean.X"	"fBodyAcc.mean.Y"	"fBodyAcc.mean.Z"

"fBodyAcc.std.X"	"fBodyAcc.std.Y"	"fBodyAcc.std.Z"           

"fBodyAccJerk.mean.X"	"fBodyAccJerk.mean.Y"	"fBodyAccJerk.mean.Z"

"fBodyAccJerk.std.X"	"fBodyAccJerk.std.Y"	"fBodyAccJerk.std.Z"

"fBodyAccMag.mean"	"fBodyAccMag.std"          

"fBodyBodyAccJerkMag.mean"	"fBodyBodyAccJerkMag.std"

"fBodyBodyGyroJerkMag.mean"	"fBodyBodyGyroJerkMag.std" 

"fBodyBodyGyroMag.mean"	"fBodyBodyGyroMag.std"

"fBodyGyro.mean.X"	"fBodyGyro.mean.Y"	"fBodyGyro.mean.Z"

"fBodyGyro.std.X"	"fBodyGyro.std.Y"	"fBodyGyro.std.Z"          

"tBodyAcc.mean.X"	"tBodyAcc.mean.Y"	"tBodyAcc.mean.Z"

"tBodyAcc.std.X"	"tBodyAcc.std.Y"	"tBodyAcc.std.Z"

"tBodyAccJerk.mean.X"	"tBodyAccJerk.mean.Y"	"tBodyAccJerk.mean.Z"

"tBodyAccJerk.std.X"	"tBodyAccJerk.std.Y"	"tBodyAccJerk.std.Z"       

"tBodyAccJerkMag.mean"	"tBodyAccJerkMag.std"	

"tBodyAccMag.mean"	"tBodyAccMag.std"          

"tBodyGyro.mean.X"	"tBodyGyro.mean.Y"	"tBodyGyro.mean.Z"

"tBodyGyro.std.X"	"tBodyGyro.std.Y"	"tBodyGyro.std.Z"

"tBodyGyroJerk.mean.X"	"tBodyGyroJerk.mean.Y"	"tBodyGyroJerk.mean.Z"

"tBodyGyroJerk.std.X"	"tBodyGyroJerk.std.Y"	"tBodyGyroJerk.std.Z"      

"tBodyGyroJerkMag.mean"	"tBodyGyroJerkMag.std"

"tBodyGyroMag.mean"	"tBodyGyroMag.std"         

"tGravityAcc.mean.X"	"tGravityAcc.mean.Y"	"tGravityAcc.mean.Z"

"tGravityAcc.std.X"	"tGravityAcc.std.Y"	"tGravityAcc.std.Z"

"tGravityAccMag.mean"	"tGravityAccMag.std"