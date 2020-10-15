##Loading the dplyr package
library(dplyr)

## Downloading the data set and unzipping the file
filename <- "CourseraProject.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename)
unzip(filename)

##Converting the text files into data frames

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("count", "functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

##Merge the train and test data sets
X_data <- rbind(x_train, x_test)
Y_data <- rbind(y_train, y_test)
Subject_data <- rbind(subject_train, subject_test)
Merged_data <- cbind(Subject_data, Y_data, X_data)

##Extract only mean and standard deviation columns
MeanStd_data <- Merged_data %>% select(subject, code, contains("mean"),
                                       contains("std"))

##Equating the code in the data frame to the activities data frame
MeanStd_data$code <- activities[MeanStd_data$code, 2]

##Labeling the data set with appropriate names

#Second column - activity
names(MeanStd_data)[2] <- "activity"

#Replacing all the column names starting with "t" with "Time"
names(MeanStd_data) <- gsub("^t", "Time", names(MeanStd_data))

#Replacing all the column names starting with "f" with "Frequency"
names(MeanStd_data) <- gsub("^f", "Frequency", names(MeanStd_data))

names(MeanStd_data) <- gsub("angle", "Angle", names(MeanStd_data))
names(MeanStd_data) <- gsub("gravity", "Gravity", names(MeanStd_data))

names(MeanStd_data) <- gsub("BodyBody", "Body", names(MeanStd_data))
names(MeanStd_data) <- gsub("Acc", "Accelerometer", names(MeanStd_data))
names(MeanStd_data) <- gsub("Gyro", "Gyroscope", names(MeanStd_data))
names(MeanStd_data) <- gsub("Mag", "Magnitude", names(MeanStd_data))

names(MeanStd_data)<-gsub("\\<std\\>", "STD", names(MeanStd_data))
names(MeanStd_data)<-gsub("\\<mean\\>", "Mean", names(MeanStd_data))
names(MeanStd_data)<-gsub("\\<meanFreq\\>", "MeanFrequence", names(MeanStd_data))

tidy_data <- MeanStd_data %>% group_by(subject, activity) %>% summarise_all(funs(mean))

write.table(tidy_data, "Output.txt", row.names = FALSE)