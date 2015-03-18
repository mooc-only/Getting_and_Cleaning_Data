##  function setup.filedata() 
##      Parameter:
##          URL to download
##          List of filenames or folder to check if script is running inside the 
##              desired workspace
##
##      Functionality:
##          1. Decode the url and get the filename to download
##          2. Download the file to /tmp folder in case that data folder or zip 
##              file can not be found (it is not downloaded in the current
##              work directory, but in /tmp folder)
##          3. Unzip the data file in case that it be necessary
##
##      Return:
##          The folder name where data resides
##
setup.filedata <- function(url, wsEvidence = c()) {
    list <- strsplit( URLdecode(url), "/" )[[1]]
    zipfile <- list[ length(list) ]
    foldername <- sub(".zip$", "", zipfile)
    
    # if inside the folder of dataset
    if ( ! is.null(wsEvidence) )
        if ( all(file.exists(wsEvidence)) ) 
            return(".")
    
    # if at the same level of dataset
    if ( file.exists( foldername ) ) return(foldername)
    
    if (! file.exists( zipfile )) {
        tempfile <- paste0("/tmp/", zipfile)
        
        if (! file.exists( tempfile )) {
            
            cat( "Downloading", URLdecode(url) )
            if (grepl("^https:", url))
                download.file( url, tempfile, method = "curl" )
            else
                download.file( url, tempfile )
            
            zipfile <- tempfile
        }
    }
    cat( "Decompressing", zipfile )
    unzip( zipfile )
    
    if ( file.exists(foldername) )
        foldername
    else
        "."
}

folder <- setup.filedata("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
			c("activity_labels.txt", "features_info.txt", "features.txt", "README.txt", "test", "train"))

#   1. Merges the training and the test sets to create one data set.

set <- "train"
filepaths <- paste(folder, set, paste0( c("X_", "y_", "subject_"), set, ".txt" ), sep = "/")
print( paste("Reading", set, "dataset: ", filepaths[1]) )
trainVars <- read.table(filepaths[1])
trainActivities <- read.table(filepaths[2])
trainSubjects <- read.table(filepaths[3])

set <- "test"
filepaths <- paste(folder, set, paste0( c("X_", "y_", "subject_"), set, ".txt" ), sep = "/")
print( paste("Reading", set, "dataset: ", filepaths[1]) )
testVars <- read.table(filepaths[1])
testActivities <- read.table(filepaths[2])
testSubjects <- read.table(filepaths[3])

vars <- rbind(trainVars, testVars)
activities <- rbind(trainActivities, testActivities)
subjects <- rbind(trainSubjects, testSubjects)

#   2. Extracts only the measurements on the mean and standard deviation for each measurement. 

features <- read.table(paste(folder, "features.txt", sep = "/"))
indices <- grep("-mean[^a-zA-Z]|-std[^a-zA-Z]", features[, 2])

newdata <- vars[, indices]

#   3. Uses descriptive activity names to name the activities in the data set

activityLabels <- read.table(paste(folder, "activity_labels.txt", sep = "/"))
activities[, 1] <- activityLabels[ activities[, 1], 2 ]
newdata <- cbind(subjects, activities, newdata)

#   4. Appropriately labels the data set with descriptive variable names. 

varnames <- gsub("[()]", "", c("Subject", "Activity", as.character(features[indices, 2])))
names(newdata) <- varnames
write.table(newdata, "training_and_test_set_merged.txt", row.names = FALSE)

#   5. From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject.

# Calculate the number of subjects, activities and variables (from the previous
# data set, the one with variables related with mean and standard deviation)

subjectCount <- nrow(unique(subjects))
activityCount <- nrow(activityLabels)
varCount <- length(indices)

# Create the new data.frame with as many rows as combinations of subjects with
# activities, and keep the names of the variables measured

df <- data.frame( newdata[ 1:(subjectCount * activityCount), ] )

# Initialize the combination, row 1 - subject id, row 2 - activity

df[, 1] <- sort(rep(1:subjectCount, activityCount))
df[, 2] <- activityLabels[ rep(1:activityCount, subjectCount), 2 ]

# Impose an order in the activity 

newdata$Activity <- factor(newdata$Activity, levels = activityLabels[, 2])

# Iterate through all variables
for (i in 1:varCount) {
    # Compute the mean of all subject-activity combination 
    colN <- aggregate(newdata[, i+2] ~ newdata[, 1] + newdata[, 2], newdata, mean)
    colN <- colN[ order(colN[, 1], colN[, 2]), ]
    df[, i+2] <- colN[, 3]
}
write.table(df, "average_of_mean_and_std.txt", row.names = FALSE)
