# Project Assignment: Tidy Data Set #

##### Importing Data

# Import column names
column_names <- read.table("features.txt", colClasses = "character")

# Activity ID's
activityids <- read.table("activity_labels.txt", col.names = c("id", "activity"))

# Test Data
subject_test <- read.table("./test/subject_test.txt", col.names = "subject")
X_test <- read.table("./test/X_test.txt", col.names = column_names[,2])
y_test <- read.table("./test/y_test.txt", col.names = "ID")

# Train Data
subject_train <- read.table("./train/subject_train.txt", col.names = "subject")
X_train <- read.table("./train/X_train.txt", col.names = column_names[,2])
y_train <- read.table("./train/y_train.txt", col.names = "ID")

# Merge Test Data
test_df <- cbind(subject_test, y_test, X_test)

# Merge Train Data
train_df <- cbind(subject_train, y_train, X_train)

# Combine Test and Train Data Sets
Dataset <- rbind(test_df, train_df)

# Find Mean and STD columns in Dataset
columns <- Dataset[grep("mean|std", names(Dataset))]
dataset1 <- cbind(Dataset[,1:2], columns)

# Rename ID's
dataset1$ID <- activityids[dataset1$ID, 2]

# Tidy names 
names(dataset1) <- tolower(names(dataset1))
names(dataset1) <- gsub("acc", "Acceleration", names(dataset1))
names(dataset1) <- gsub("^t", "Time", names(dataset1))
names(dataset1) <- gsub("^f", "Frequency", names(dataset1))
names(dataset1) <- gsub("gyro", "Gyroscope", names(dataset1))
names(dataset1) <- gsub("bodybody", "Body", names(dataset1))
names(dataset1) <- gsub("body", "Body", names(dataset1))
names(dataset1) <- gsub("mean", "Mean", names(dataset1))
names(dataset1) <- gsub("std", "Std", names(dataset1))
names(dataset1) <- gsub("mag", "Magnitude", names(dataset1))
names(dataset1) <- gsub("gravity", "Gravity", names(dataset1))
names(dataset1) <- gsub("x$", "X", names(dataset1))
names(dataset1) <- gsub("y$", "Y", names(dataset1))
names(dataset1) <- gsub("z$", "Z", names(dataset1))
names(dataset1) <- gsub("^s", "S", names(dataset1))
names(dataset1) <- gsub("^i", "I", names(dataset1))

# Summarize by groups
FinalData <- dataset1 %>%
        group_by(Subject, Id) %>%
        summarise_each(mean)

# Export Data
write.table(FinalData, "FinalData.txt", row.names = F)
