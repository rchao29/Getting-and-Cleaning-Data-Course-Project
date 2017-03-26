# Getting-and-Cleaning-Data-Course-Project

In this project, we use data collected from the accelerometers from the Samsung Galaxy S II smartphone. Data is from experiments carried out with a group of 30 volunteers aged between 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a Samsung Galaxy S II smartphone on the waist. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The original data set can be downloaded here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The CodeBook in this repository details the contents of this data set, and provides more background on the project.

The "run_analysis.R" script does the following (although not necessarily in this order):

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Note that the script assumes that the folder "UCI HAR Dataset" containing the raw data set is in the same directory as the script. More details are provided in the CodeBook.
