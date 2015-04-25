# Requirement 1 -----------------------------------------------------------

# Create "processed, "processed/merged" and "processed/merged/Inertial Signals" folders in one call.
# Merged data will be saved in these "processed/merged" and "processed/merged/Inertial Signals" folders,
# following the name patterns in "train" or "test" folders.
if (!file.exists("data/processed/merged/Inertial Signals")) dir.create("data/processed/merged/Inertial Signals", recursive = TRUE)

srcDirs <- c("data/UCI HAR Dataset/train", "data/UCI HAR Dataset/test")
targetDir <- "data/processed/merged"

# Since filenames follow a preset pattern, we can just use file names in "train" folder
# and derive file names in "test" and "merged" folders
files <- list.files(srcDirs[1], recursive = TRUE, include.dirs = FALSE)
for (file in files) {
    f1 <- read.csv(paste(srcDirs[1], file, sep = "/"), header = FALSE)
    testName <- gsub("_train", "_test", file)
    f2 <- read.csv(paste(srcDirs[2], testName, sep = "/"), header = FALSE)
    mergeName <- gsub("_train", "_merged", file)
    write.table(f1, paste(targetDir, mergeName, sep = "/"), quote = FALSE, row.names = FALSE,
                col.names = FALSE)
    write.table(f2, paste(targetDir, mergeName, sep = "/"), quote = FALSE, row.names = FALSE,
                col.names = FALSE, append = TRUE)
}

# Requirement 2 -----------------------------------------------------------

# Prepare variable names
features <- read.csv("data/UCI HAR Dataset/features.txt", sep = "", header = FALSE)
varNames <- features[, 2]
meanPos <- grepl("-mean()", varNames)
stdPos <- grepl("-std()", varNames)
namePos <- meanPos | stdPos
keptMeasurements <- data.frame()

# Looking into X_merged.txt reveals that it is of a fixed width format with 561 fields, 
# each with 16 characters (numbers) 
fixedWidth <- rep.int(16, 561)

# Reading the whole X_merged.txt file requires a huge amount of memory. Thus, we
# need to read records in small chunks.
linesToSkip = 0;
linesToRead = 500;
linesRead = linesToRead
while (linesRead == linesToRead) {
    merged <- read.fwf("data/processed/merged/X_merged.txt", widths = fixedWidth, header = FALSE, n = linesToRead, skip = linesToSkip)
    linesRead <- nrow(merged)
    names(merged) <- varNames
    subset <- merged[, namePos]
    keptMeasurements <- rbind(keptMeasurements, subset)
    linesToSkip <- linesToSkip + linesRead
}

# Since this takes time to generate, let's save it to a file
write.table(keptMeasurements, file = "data/processed/keptMeasurements.txt", )


# Requirement 3 ---------------------------------------------------------

activities <- read.csv("data/processed/merged/y_merged.txt", header = FALSE)
activity_labels <- read.csv("data/UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)

# Create a "activity" column in "activities" containing descriptive activity names
activities$activity <- activity_labels[activities$V1, 2]

# Requirement 4 ---------------------------------------------------------

# Since we have applied varNames to read-in data in Requirement 2, the keptMeasurements
# has already descriptive variable names.
keptMeasurements <- read.table("data/processed/keptMeasurements.txt", check.names=FALSE)

# Need to merge subject, activities, keptMeasurements 
subject <- read.csv("data/processed/merged/subject_merged.txt", header = FALSE)
names(subject) <- c("subject")

combined <- cbind(subject, activities, keptMeasurements)
combined <- combined[, -2]
write.table(combined, file = "data/processed/combined.txt")

# Requirement 5 ---------------------------------------------------------

combined <- read.table("data/processed/combined.txt", check.names=FALSE)
library(dplyr)
# Finding the average of each variable for each activity and each subject.
tidySet <- combined %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# However, the column names that "tidySet" inherited from "combined" are not correct any more,
# except for "subject" and "activity". We need to change the name like "tBodyAcc-mean()-X" 
# to "avg of tBodyAcc-mean()-X", and attached the proper variable names to "tidySet"
newColNames <- paste("avg of", names(tidySet))
newColNames[1] <- names(tidySet)[1]
newColNames[2] <- names(tidySet)[2]
names(tidySet) <- newColNames

# Finally, we write out "tidySet" to a file with with write.table() using row.name=FALSE
write.table(tidySet, file = "data/processed/tidySet.txt", row.name=FALSE)
