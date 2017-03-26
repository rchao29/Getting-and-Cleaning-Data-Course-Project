
# This script will do the following (although not exactly in this order):

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Note that the script assumes that the folder "UCI HAR Dataset" containing the raw data set is in the same directory as the script. 

# Install and load the necessary packages.
# install.packages("data.table")
# install.packages("dplyr")
library(data.table)
library(dplyr)

# Read in the data.
Training_Set <- read.table("UCI HAR Dataset/train/X_train.txt")
Test_Set <- read.table("UCI HAR Dataset/test/X_test.txt")
Complete_Data <- rbind(Training_Set,Test_Set)
Complete_Data[1:4,1:5]
  
# Extract only the measurements on the mean and standard deviation for each measurement (2).
# Read in additional data.
Features <- read.table("UCI HAR Dataset/features.txt")[,2]
colnames(Complete_Data) <- Features
Mean_Std <- grepl('-(mean|std)\\(',Features)
Complete_Data <- subset(Complete_Data,select=Mean_Std)
Complete_Data[1:4,1:5]
  
# Appropriately labels the data set with descriptive variable names (4). 
colnames(Complete_Data) <- gsub("mean", "Mean", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("std", "Std", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("^t", "Time", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("^f", "Frequency", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("\\(\\)", "", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("-", "", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("BodyBody", "Body", colnames(Complete_Data))
colnames(Complete_Data) <- gsub("^", "MeanOf", colnames(Complete_Data))
colnames(Complete_Data)
Complete_Data[1:4,1:5]

# Use descriptive activity names to name the activities in the data set (3).
Training_Set_Activities <- read.table("UCI HAR Dataset/train//y_train.txt")
Test_Set_Activities <- read.table("UCI HAR Dataset/test/y_test.txt")
Activities <- rbind(Training_Set_Activities,Test_Set_Activities)[,1]
Actitities_Labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
Activities <- Actitities_Labels[Activities]
Complete_Data <- cbind(Activity = Activities,Complete_Data)
Complete_Data[1:4,1:5]
  
# From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject (5).
Subjects_Training <- read.table("UCI HAR Dataset/train/subject_train.txt")
Subjects_Testing <- read.table("UCI HAR Dataset/test/subject_test.txt")
Complete_Subjects <- rbind(Subjects_Training,Subjects_Testing)[,1]
Complete_Data <- cbind(Subject = Complete_Subjects,Complete_Data)
Complete_Data[1:4,1:5]
  
library('dplyr')
Average_Complete_Data <- Complete_Data %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))

# Wite out the independent tidy data set.   
write.table(Average_Complete_Data,row.name = FALSE,file = "Final_Tidy_Data_Set.txt")    
  
