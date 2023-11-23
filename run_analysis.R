# Load necessary libraries
library(dplyr)

# Set the working directory to the location of your data
setwd("C:/Users/WYMYYDS/Desktop/UCI HAR Dataset")

# Step 1: Merge the training and test sets to create one data set
train_data <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
train_subject <- read.table("train/subject_train.txt")

test_data <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
test_subject <- read.table("test/subject_test.txt")

merged_data <- bind_rows(train_data, test_data)
merged_labels <- bind_rows(train_labels, test_labels)
merged_subject <- bind_rows(train_subject, test_subject)

# Step 2: Extract only the measurements of the mean and standard deviation
features <- read.table("features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features$V2)
selected_data <- merged_data[, mean_std_indices]

# Step 3: Use descriptive activity names to name the activities in the data set
activity_labels <- read.table("activity_labels.txt")
merged_labels$V1 <- factor(merged_labels$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Step 4: Appropriately label the data set with descriptive variable names
colnames(selected_data) <- features$V2[mean_std_indices]

# Step 5: Create the tidy data set and write it to a file
tidy_data <- cbind(merged_subject, merged_labels, selected_data)
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)
read.table("tidy_data.txt", header = TRUE)