# Cook book for tidyDataProject
## How did we do it?
#### Requirement 1: "Merges the training and the test sets to create one data set."
My interpretation is that the new data set should be something similar to "training" and "test" sets, which in its current form are directories and files with certain naming convention. Therefore, I created a directory called *data/processed/merged*, and created files that merged corresponding files from *data/UCI HAR Dataset/train* and *data/UCI HAR Dataset/test*. For example, *X_merged.txt* file is a merge of *X_train.txt* and *X_test.txt* in their respective directories.

#### Requirement 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
My understanding of "the mean and standard deviation for each measurement" is those features in in *features.txt* file with "-mean()" and "-std()" in their names. Thus, we read in all variable names into varNames, used grepl function to find locations of those with "-mean()" and "-std()", and merged location with a OR operation, and assigned it to namePos, and used it to extract only those measurements later on.

By examining *X_train.txt* and *X_test.txt* as text files, and the number of featues in *features.txt*, we can determine that the data file is of fixed width format, with 561 variables, each occupying 16 charaters (numbers). With this large number of variables and the number of observations, the loading of the merged file with "read.fwf" method requires a huge amount of memory, although the final data frame is much smaller. Thus, I had to limit the number of records to each read, and kept reading until the end of file.

Meanwhile, to facilitate "rbind" method, I attached varName to the read-in data frame, which basically satisfied the Requirement 4 below. Then we extracted the wanted columns with namePos, and combined all observations into keptMeasurements data frame.

Since this processing is time consuming, we saved it to a file called "data/processed/keptMeasurements.txt"

#### Requirement 3: "Uses descriptive activity names to name the activities in the data set"
We read in all the activities from the *y_merged.txt* file into "activities". Since it contains only activity labels, we have use the description in *data/UCI HAR Dataset/activity_labels.txt* to attach the descriptive name to it with the following script:
```activities$activity <- activity_labels[activities$V1, 2]```

#### Requirement 4: "Appropriately labels the data set with descriptive variable names."
This requirement is satisfield in the steps for Requirement 2, as described above.

At this point, we need to merge the "subject" read from *subject_merged.txt* file, "activities", and "keptMeasurements" into a single data frame "combined", and prepare for the next requirement.

#### Requirement 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
Finally, we utilized "dplyr" package and its "group_by" and "summarise_each" methods to accomplish this task, and assigned it to "tidySet" variable. However, the column names that "tidySet" inherited from "combined" are not correct any more, except for "subject" and "activity". We need to change the name like "tBodyAcc-mean()-X" to "avg of tBodyAcc-mean()-X", and attached the proper variable names to "tidySet".

Finally, we write out "tidySet" to a file.

## Variables

In this tidy data set, all variables, except the first two ("subject" and "activity"), are the average of existing variables for each activity and each subject. Those existing variables are  the mean and standard deviation for each measurement in the original "UCI HAR Dataset". The reader should refer to "data/UCI HAR Dataset/features_info.txt" file to find the exact meaning of those existing variables.

Variable | Meaning
-------- | --------
**subject**|ID assigned to a volunteer
**activity**|The activity the volunteer performed. It can be one of the following 6 values: *WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING*
**avg of tBodyAcc-mean()-X**|avg of tBodyAcc-mean()-X
**avg of tBodyAcc-mean()-Y**|avg of tBodyAcc-mean()-Y
**avg of tBodyAcc-mean()-Z**|avg of tBodyAcc-mean()-Z
**avg of tBodyAcc-std()-X**|avg of tBodyAcc-std()-X
**avg of tBodyAcc-std()-Y**|avg of tBodyAcc-std()-Y
**avg of tBodyAcc-std()-Z**|avg of tBodyAcc-std()-Z
**avg of tGravityAcc-mean()-X**|avg of tGravityAcc-mean()-X
**avg of tGravityAcc-mean()-Y**|avg of tGravityAcc-mean()-Y
**avg of tGravityAcc-mean()-Z**|avg of tGravityAcc-mean()-Z
**avg of tGravityAcc-std()-X**|avg of tGravityAcc-std()-X
**avg of tGravityAcc-std()-Y**|avg of tGravityAcc-std()-Y
**avg of tGravityAcc-std()-Z**|avg of tGravityAcc-std()-Z
**avg of tBodyAccJerk-mean()-X**|avg of tBodyAccJerk-mean()-X
**avg of tBodyAccJerk-mean()-Y**|avg of tBodyAccJerk-mean()-Y
**avg of tBodyAccJerk-mean()-Z**|avg of tBodyAccJerk-mean()-Z
**avg of tBodyAccJerk-std()-X**|avg of tBodyAccJerk-std()-X
**avg of tBodyAccJerk-std()-Y**|avg of tBodyAccJerk-std()-Y
**avg of tBodyAccJerk-std()-Z**|avg of tBodyAccJerk-std()-Z
**avg of tBodyGyro-mean()-X**|avg of tBodyGyro-mean()-X
**avg of tBodyGyro-mean()-Y**|avg of tBodyGyro-mean()-Y
**avg of tBodyGyro-mean()-Z**|avg of tBodyGyro-mean()-Z
**avg of tBodyGyro-std()-X**|avg of tBodyGyro-std()-X
**avg of tBodyGyro-std()-Y**|avg of tBodyGyro-std()-Y
**avg of tBodyGyro-std()-Z**|avg of tBodyGyro-std()-Z
**avg of tBodyGyroJerk-mean()-X**|avg of tBodyGyroJerk-mean()-X
**avg of tBodyGyroJerk-mean()-Y**|avg of tBodyGyroJerk-mean()-Y
**avg of tBodyGyroJerk-mean()-Z**|avg of tBodyGyroJerk-mean()-Z
**avg of tBodyGyroJerk-std()-X**|avg of tBodyGyroJerk-std()-X
**avg of tBodyGyroJerk-std()-Y**|avg of tBodyGyroJerk-std()-Y
**avg of tBodyGyroJerk-std()-Z**|avg of tBodyGyroJerk-std()-Z
**avg of tBodyAccMag-mean()**|avg of tBodyAccMag-mean()
**avg of tBodyAccMag-std()**|avg of tBodyAccMag-std()
**avg of tGravityAccMag-mean()**|avg of tGravityAccMag-mean()
**avg of tGravityAccMag-std()**|avg of tGravityAccMag-std()
**avg of tBodyAccJerkMag-mean()**|avg of tBodyAccJerkMag-mean()
**avg of tBodyAccJerkMag-std()**|avg of tBodyAccJerkMag-std()
**avg of tBodyGyroMag-mean()**|avg of tBodyGyroMag-mean()
**avg of tBodyGyroMag-std()**|avg of tBodyGyroMag-std()
**avg of tBodyGyroJerkMag-mean()**|avg of tBodyGyroJerkMag-mean()
**avg of tBodyGyroJerkMag-std()**|avg of tBodyGyroJerkMag-std()
**avg of fBodyAcc-mean()-X**|avg of fBodyAcc-mean()-X
**avg of fBodyAcc-mean()-Y**|avg of fBodyAcc-mean()-Y
**avg of fBodyAcc-mean()-Z**|avg of fBodyAcc-mean()-Z
**avg of fBodyAcc-std()-X**|avg of fBodyAcc-std()-X
**avg of fBodyAcc-std()-Y**|avg of fBodyAcc-std()-Y
**avg of fBodyAcc-std()-Z**|avg of fBodyAcc-std()-Z
**avg of fBodyAcc-meanFreq()-X**|avg of fBodyAcc-meanFreq()-X
**avg of fBodyAcc-meanFreq()-Y**|avg of fBodyAcc-meanFreq()-Y
**avg of fBodyAcc-meanFreq()-Z**|avg of fBodyAcc-meanFreq()-Z
**avg of fBodyAccJerk-mean()-X**|avg of fBodyAccJerk-mean()-X
**avg of fBodyAccJerk-mean()-Y**|avg of fBodyAccJerk-mean()-Y
**avg of fBodyAccJerk-mean()-Z**|avg of fBodyAccJerk-mean()-Z
**avg of fBodyAccJerk-std()-X**|avg of fBodyAccJerk-std()-X
**avg of fBodyAccJerk-std()-Y**|avg of fBodyAccJerk-std()-Y
**avg of fBodyAccJerk-std()-Z**|avg of fBodyAccJerk-std()-Z
**avg of fBodyAccJerk-meanFreq()-X**|avg of fBodyAccJerk-meanFreq()-X
**avg of fBodyAccJerk-meanFreq()-Y**|avg of fBodyAccJerk-meanFreq()-Y
**avg of fBodyAccJerk-meanFreq()-Z**|avg of fBodyAccJerk-meanFreq()-Z
**avg of fBodyGyro-mean()-X**|avg of fBodyGyro-mean()-X
**avg of fBodyGyro-mean()-Y**|avg of fBodyGyro-mean()-Y
**avg of fBodyGyro-mean()-Z**|avg of fBodyGyro-mean()-Z
**avg of fBodyGyro-std()-X**|avg of fBodyGyro-std()-X
**avg of fBodyGyro-std()-Y**|avg of fBodyGyro-std()-Y
**avg of fBodyGyro-std()-Z**|avg of fBodyGyro-std()-Z
**avg of fBodyGyro-meanFreq()-X**|avg of fBodyGyro-meanFreq()-X
**avg of fBodyGyro-meanFreq()-Y**|avg of fBodyGyro-meanFreq()-Y
**avg of fBodyGyro-meanFreq()-Z**|avg of fBodyGyro-meanFreq()-Z
**avg of fBodyAccMag-mean()**|avg of fBodyAccMag-mean()
**avg of fBodyAccMag-std()**|avg of fBodyAccMag-std()
**avg of fBodyAccMag-meanFreq()**|avg of fBodyAccMag-meanFreq()
**avg of fBodyBodyAccJerkMag-mean()**|avg of fBodyBodyAccJerkMag-mean()
**avg of fBodyBodyAccJerkMag-std()**|avg of fBodyBodyAccJerkMag-std()
**avg of fBodyBodyAccJerkMag-meanFreq()**|avg of fBodyBodyAccJerkMag-meanFreq()
**avg of fBodyBodyGyroMag-mean()**|avg of fBodyBodyGyroMag-mean()
**avg of fBodyBodyGyroMag-std()**|avg of fBodyBodyGyroMag-std()
**avg of fBodyBodyGyroMag-meanFreq()**|avg of fBodyBodyGyroMag-meanFreq()
**avg of fBodyBodyGyroJerkMag-mean()**|avg of fBodyBodyGyroJerkMag-mean()
**avg of fBodyBodyGyroJerkMag-std()**|avg of fBodyBodyGyroJerkMag-std()
**avg of fBodyBodyGyroJerkMag-meanFreq()**|avg of fBodyBodyGyroJerkMag-meanFreq()

