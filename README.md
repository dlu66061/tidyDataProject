# tidyDataProject
This is README file for the tidyDataProject, the course project for "Getting and Cleaning Data" course on Coursera.

You can clone this project with command 

git clone https://github.com/dlu66061/tidyDataProject.git

and open the tidyDataProject in RStudio. 

This project including the following major files and folders:

* CodeBook.md: the code book that describes the variables, the data, and transformations 
* data: a folder containing the original data and processed data. The original data is stored in "data/UCI HAR Dataset", and the processed data is stored in "data/processed" folder.
* README.md: this file that you are reading. It describes how the project works and how to reproduce the result.
* run_analysis.R: the R script that does the following. 
    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
* tidyDataProject.Rproj: the project file for RStudio

Once you clone the project, delete "data/processed" folder. Then you can open *run_analysis.R* in the source editor and run the script line by line to inspect how it works.  

## How does the scirpt work?
#### Requirement 1: "Merges the training and the test sets to create one data set."
My interpretation is that the new data set should be something similar to "training" and "test" sets, which in its current form are directories and files with certain naming convention. Therefore, I created a directory called *data/processed/merged*, and created files that merged corresponding files from *data/UCI HAR Dataset/train* and *data/UCI HAR Dataset/test*. For example, *X_merged.txt* file is a merge of *X_train.txt* and *X_test.txt* from their respective directories.

#### Requirement 2: "Extracts only the measurements on the mean and standard deviation for each measurement."
My understanding of "the mean and standard deviation for each measurement" is those features in in *features.txt* file with "-mean()" and "-std()" in their names. Thus, we read in all variable names into varNames, used grepl function to find locations of those with "-mean()" and "-std()", and merged location with a OR operation, and assigned it to namePos, and used it later on to extract only those measurements.

By examining *X_train.txt* and *X_test.txt* as text files, and the number of featues in *features.txt*, we can determine that the data file is of fixed width format, with 561 variables, each containing 16 charaters (digits). With this large number of variables and the number of observations, the loading of the merged file with "read.fwf" method requires a huge amount of memory, although the final data frame is much smaller. Thus, I had to limit the number of records to each read, and kept reading until the end of file.

Meanwhile, to facilitate "rbind" method, I attached varName to the read-in data frame, which "appropriately labels the data set with descriptive variable names" and satisfied the Requirement 4 below. Then we extracted the wanted columns with namePos, and combined all observations into keptMeasurements data frame.

Since this processing is time consuming, we saved it to a file called "data/processed/keptMeasurements.txt"

#### Requirement 3: "Uses descriptive activity names to name the activities in the data set"
We read in all the activities from the *y_merged.txt* file into "activities". Since it contains only activity labels, we have use the description in *data/UCI HAR Dataset/activity_labels.txt* to attach the descriptive name to it with the following script:
```activities$activity <- activity_labels[activities$V1, 2]```

#### Requirement 4: "Appropriately labels the data set with descriptive variable names."
This requirement is satisfield in the steps for Requirement 2, as described above.

At this point, we need to merge the "subject" read from *subject_merged.txt* file, "activities", and "keptMeasurements" into a single data frame "combined", and prepare for the next requirement.

#### Requirement 5: "From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."
Finally, we utilized "dplyr" package and its "group_by" and "summarise_each" methods to accomplish this task, and assigned it to "tidySet" variable. However, the column names that "tidySet" inherited from "combined" are not correct any more, except for "subject" and "activity". We need to change the name like "tBodyAcc-mean()-X" to "avg of tBodyAcc-mean()-X", and attached the proper variable names to "tidySet".

Finally, we write out "tidySet" to a file with with write.table() using row.name=FALSE.
