# 0. Load packages and set wd correctly
setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset")
library(dplyr)

# 1. Merges the training and the test sets to create one data set.
# First, import the test set and training set
setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset")
Column_Names <- read.table("features.txt", col.names = c("n", "features"))

setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset/train")
Training_Data <- read.table("X_train.txt", col.names = Column_Names$features)

setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset/test")
Test_Data <- read.table("X_test.txt", col.names = Column_Names$features)

Combined_Data <- rbind(Test_Data, Training_Data)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# We select only the columns that end with "mean" or "std"

Mean_Std_Data <- select(Combined_Data, contains("mean"), contains("std"))

# 3. Uses descriptive activity names to name the activities in the data set
# First we need to import the activities list
setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset")
Activity_Labels <- read.table("activity_labels.txt")

setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset/train")
Y_Training <- read.table("Y_train.txt", col.names = "activity")

setwd("~/OneDrive/Coursera/Data Science/Module 3/data/UCI HAR Dataset/test")
Y_Test <- read.table("Y_test.txt", col.names = "activity")

Y_Complete <- rbind(Y_Training, Y_Test)
Y_Complete$activity <- factor(Y_Complete$activity)

# Add the activity column to the data set
Combined_Data$Activity <- Y_Complete

# 4. Appropriately labels the data set with descriptive variable names.
names(Combined_Data)[562] <- "activity"
names(Combined_Data) <- gsub("^t", "Time", names(Combined_Data))
names(Combined_Data) <- gsub("Acc", " Accelerator", names(Combined_Data))
names(Combined_Data) <- gsub(".mean", " Mean", names(Combined_Data))
names(Combined_Data) <- gsub(".std", " STD", names(Combined_Data))
names(Combined_Data) <- gsub(".mad", " STD", names(Combined_Data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Grouped_Data <- Combined_Data %>% summarise_all(mean)

#Export Table
setwd("~/OneDrive/Coursera/Data Science/Module 3/data")
write.table(Combined_Data, "Coursera_Week5.txt", row.names = FALSE)
        
