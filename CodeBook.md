The run_analysis.R script performs the following steps as required in the final project for Getting and Cleaning Data course.
1. Download the dataset
Dataset is downloaded and extracted in the working directory under folder name “UCI HAR Dataset”.
2. Assign each set of data to data frames
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns
List of activities (along with their codes) performed when the corresponding measurements were taken.
x_train <- test/X_train.txt : 7352 rows, 561 columns
Contains recorded features of training data.
y_train <- test/y_train.txt : 7352 rows, 1 columns
List of activity codes of training data.
subject_train <- test/subject_train.txt : 7352 rows, 1 column
Contains training data of 21/30 volunteer subjects being observed.
x_test <- test/X_test.txt : 2947 rows, 561 columns
Contains recorded features of test data.
y_test <- test/y_test.txt : 2947 rows, 1 columns
List of activity codes of test data.
subject_test <- test/subject_test.txt : 2947 rows, 1 column
Contains test data of 9/30 volunteer subjects being observed
3. Merges the training and the test sets to create one data set
X_data (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
Y_data (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
Subject_data (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
Merged_data (10299 rows, 563 column) is created by merging Subject_data, Y_data and X_data using cbind() function


4. Extracts only the measurements on the mean and standard deviation for each measurement
MeanStd_data (10299 rows, 88 columns) is created by subsetting Merged_data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each observation.
5. Uses descriptive activity names to name the activities in the data set
Entire numbers in the code column of the MeanStd_data replaced with corresponding activity taken from the second column of the activities data frame.
6. Appropriately labels the data set with descriptive variable names
code column in MeanStd_data is renamed to activity
All Acc in column name is replaced by Accelerometer
All Gyro in column name is replaced by Gyroscope
All BodyBody in column name is replaced by Body
All Mag in column name is replaced by Magnitude
All columns starting with character f is replaced by Frequency
All columns starting with character t is replaced by Time
7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data (180 rows, 88 columns) is created by summarizing MeanStd_data taking the means of each variable for each activity and each subject, after grouped by subject and activity.
Export tidy_data into Output.txt file.