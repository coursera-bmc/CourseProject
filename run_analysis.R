## Author: BMc
## Version: 1.0
## Date: 2015.01.21
## This R file (when run from run_analysis()) converts the data files in the
## getdata_projectfiles_UCI HAR Dataset.zip folder to a tidy data frame that
## has been organized first by Subject ID and then by ActivityName, with the
## Average of mean or Average of standard deviation filling out the rest of 
## the columns on the observation.

run_analysis <- function(returnType = FALSE)
{
  #Split into functions for ease of coding and unit testing
  
  #Load the data (Step 1)
  data <- loadAndMerge()

  #Subset the data (Step 2)
  data <- subsetDataFrame(data)
  
  #Rename the activities (Step 3)
  data <- mapActivities(data)

  #Update Labels (Step 4)
  data <- updateLabels(data)
  
  #Now ... make it tidy (Step 5)
  data <- createTidyTable(data)
  
  #Write the data to a file
  if(returnType)  write.table(data, "tidy_experiment_data.txt", row.names=FALSE)
  return(data)
}

createTidyTable <- function(data)
{
  #This function takes all numeric columns from the data frame, split by
  #the subject of the experiment and the activity, and calculates the mean.
  #It then saves the results into a dataframe
  #The final data frame is ordered first by subject, then by Activity Name.
  #Row names are reset to standard numbering (not needed but it was bugging
  #me during programming)
  tidy <- aggregate(data[,3:68], 
                     list(Subject = data$Subject, 
                          ActivityName = data$ActivityName), 
                     mean)
  tidy <- tidy[order(tidy$Subject,tidy$ActivityName),]
  rownames(tidy) <- NULL
  
  return(tidy)
}

updateLabels <- function(data)
{
  #Replaces the double period in column names
  names(data) <- gsub("\\.\\.", "", names(data))
  #This reorders the columns.  Subject and Activity at front, rest at end
  data <- subset(data, 
                 select=c(Subject, 
                          ActivityName, 
                          tBodyAcc.mean.X:fBodyBodyGyroJerkMag.std))
  return(data)
}

mapActivities <- function(data)
{
  library(plyr)      #Library needed for join()
  #This function performs a join of Activity Labels and the Activity column
  #It replaces the Activity column with a new column: ActivityName
  #This turns coded responses (enums) into a human-readable format
  
  dir <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\"
  mapping <- read.table(paste0(dir, "activity_labels.txt"))
  names(mapping) <- c("Activity", "ActivityName")
  data <- join(data, mapping, type="inner")
  
  #Delete Activity column as it no longer serves a purpose
  data <- subset(data,select=-c(Activity))
  
  return(data)
}

subsetDataFrame <- function(df)
{
  #This function restricts the data frame to only those columns with "mean, 
  #std, Subject, Activity" in their names.  It drops meanFreq()
  #It prepares the data frame as given in step 2 of the project
  
  #These lines might look weird.  It's just to fit in the 80 char width limit
  df <- 
  df[,grepl(".*mean\\.\\..*|.*std\\.\\..*|.*Subject.*|.*Activity.*",names(df))]
  return(df)
}

loadAndMerge <- function()
{
  #This function loads both the test and training data and merges it into a
  #single data frame
  #This does the lifting for step 1 of Project 1 in Getting And Cleaning Data
  #Returns the merged data tables - adds headers as well from features.txt
  
  #Directory string.  This is where the zip file unpacks all data
  dir <- ".\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\"
  headers <- read.table(paste0(dir, "features.txt"))

  
  #Training Data Table
  train_data <- 
    read.table(paste0(dir, "train\\X_train.txt"), col.names=headers[,2])  
  subject_train <- 
    read.table(paste0(dir, "train\\subject_train.txt"), col.names="Subject")
  activity_train <- 
    read.table(paste0(dir, "train\\Y_train.txt"), col.names="Activity")
  train_data <- cbind(train_data, subject_train, activity_train)
  
  #Testing Data Table
  test_data <- 
    read.table(paste0(dir, "test\\X_test.txt"), col.names=headers[,2])
  subject_test <- 
    read.table(paste0(dir, "test\\subject_test.txt"), col.names="Subject")
  activity_test <- 
    read.table(paste0(dir, "test\\Y_test.txt"), col.names="Activity")
  test_data <- cbind(test_data, subject_test, activity_test)
  
  #Merge the two data tables
  merged_training <- rbind(train_data, test_data)
  
  return(merged_training)
}
