
##Tidied Human Activity Recognition Using Smartphones Dataset

Coursera: Getting and Cleaning Data

Course Project

https://github.com/coursera-bmc/courseproject

##Files Included in Repository
* 'getdata_projectfiles_UCI HAR Dataset.zip': Raw data from original collection
* 'project1_codebook.txt': Code book documenting collection of data, tidying process, and column names / measurements
* 'run_analysis.R': R file containing function run_analysis() used for tidying data.
* 'readme.md': This file.  A readme.
* 'tidy_experiment_data.txt': Tidy data set (output of run_analysis.R).  This can be loaded into R via read.table('tidy_experiment_data.txt', header=TRUE)

##To Reproduce the Data Tidying Process
The zip file 'getdata_projectfiles_UCI HAR Dataset.zip' and R script 'run_analysis.R' may be downloaded from github.com/coursera-bmc/courseproject and placed in the current working directory for R.  Files can be placed elsewhere, but directory callouts in the R script must be updated to point to the correct location.

'run_analysis.R' is commented for a more in-depth look at methodology.


###TO TIDY RAW DATA
1. Unpack zip to R working directory.  The top level folder should be './getdata_projectfiles_UCI HAR Dataset'

2. Open R and load the 'run_analysis.R' source file.
  * If in Working Directory, use source('./run_analysis.R')
  
3. Execute function run_analysis(returnType).  This will return the tidy data set in one of two ways:
  * If executed as run_analysis(TRUE), the data will be printed to './tidy_experiment_data.txt' as well as returned as output from the function.
  * If no arguments are given or run_analysis(FALSE) is executed, no file will be written.

###TO LOAD TIDY DATA
To load the file 'tidy_experiment_data.txt' into R, use read.table('tidy_experiment_data.txt', header=TRUE).
