# Week 3 Final Project Submission
This file describes how I structured the run_analysis.R script. Please note that I followed the instructions directly as per the "Getting and Cleaning Data" course description on Cousera

## 0. Load packages and set wd correctly
In this first step, I loaded the required packages and imported the data set. I am using the dplyr package, primarily. I have also added column names to all the data, using the col.names functions, because this will be useful in the next steps.

## 1. Merges the training and the test sets to create one data set.
In the first step, I have merged the following rows:
1) Row bind of Test_Data and Training_Data
2) Row bind of Test_Labels and Training_Labels
3) Row bind of Test_Subject and Train_Subject

I combined these three new dataframew togethers, using the column bind function, which results in the Complete_Merged data frame.

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
The second step is quite straightforward, using the select() function fromthe dplyr package. I select "subject", "code", and every column that mentions "mean" or "std".

## 3. Uses descriptive activity names to name the activities in the data set
Step 3 was exectued by subsetting the "code" column (the second column) and replacing these with the activity labels.

## 4. Appropriately labels the data set with descriptive variable names.
For updating the column names and column labels, I have chosen to use the names() and gsub() functions because they are easy to follow and read.

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
For step five, I have used the summarize_all() function from the dyplr package and grouped the data by subject and activitiy.

Final step was to write the table into a new text file.