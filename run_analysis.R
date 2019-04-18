# 0. Load packages, setwd correctly and import the tables
setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset")
library(dplyr)

Activity_Labels <- read.table("activity_labels.txt", col.names = c("code", "activity"))
Features <- read.table("features.txt", col.names = c("n","features"))

Test_Data <- read.table("./test/X_test.txt", col.names = Features$features)
Test_Labels <- read.table("./test/y_test.txt", col.names = "code")
Test_Subject <- read.table("./test/subject_test.txt", col.names = "subject")

Train_Data <- read.table("./train/X_train.txt", col.names = Features$features)
Train_Labels <- read.table("./train/y_train.txt", col.names = "code")
Train_Subject <- read.table("./train/subject_train.txt", col.names = "subject")

# 1. Merges the training and the test sets to create one data set.

Data_Merged <- rbind(Test_Data, Train_Data)
Labels_Merged <- rbind(Test_Labels, Train_Labels)
Subject_Merged <- rbind(Test_Subject, Train_Subject)

Complete_Merged <- cbind(Subject_Merged, Data_Merged, Labels_Merged)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# We select only the columns that end with "mean" or "std"

Mean_Std_Data <- select(Complete_Merged, subject, code, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
# Here, we simpley subset the 'code' by the Activity Labels

Mean_Std_Data$code <- Activity_Labels[Mean_Std_Data$code, 2]

# 4. Appropriately labels the data set with descriptive variable names.
names(Mean_Std_Data)[2] <- "activity"
names(Mean_Std_Data) <- gsub("^t", "Time", names(Mean_Std_Data))
names(Mean_Std_Data)<- gsub("Acc", " Accelerator", names(Mean_Std_Data))
names(Mean_Std_Data) <- gsub(".mean", " Mean", names(Mean_Std_Data))
names(Mean_Std_Data) <- gsub(".std", " STD", names(Mean_Std_Data))
names(Mean_Std_Data) <- gsub(".mad", " STD", names(Mean_Std_Data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Grouped_Data <- Mean_Std_Data %>% 
        group_by(subject, activity) %>%
        summarise_all(mean)

#Export Table
setwd("~/OneDrive/Coursera/Data Science/Module 3/data")
write.table(Grouped_Data, "Coursera_Week3_Final.txt", row.names = FALSE)
        