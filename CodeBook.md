# Cook book for tidyDataProject
## Data
The original data is obtained from 

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The content of the zip file is extracted to the *data* folder of the project in RStuido. The *data/UCI HAR Dataset/README.txt* is a good start point to understand the data.

## Transformation
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

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

