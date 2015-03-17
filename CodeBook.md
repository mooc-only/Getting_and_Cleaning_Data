# Code book of the course project

## Sources

The dataset that were transformed can be obtained here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original explanation of the data set can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## How to reproduce the tidy datasets

The following operations was performed to create the 2 tidy datasets requested:

- The UCI HAR Dataset is downloaded and unziped, if there are found neither the .zip file, nor the dataset folder.

- Read from the "train" and "test" folder the measured variables (X_?.txt), the subjects ID (subjects_?.txt) and the activities (y_?.txt), and merge them respectively.

- Export only the measured means and standard deviations to the file "training_and_test_set_merged.txt" with appropiate descriptive variable names read from the file "features.txt", located at the root level of the unzipped dataset. The variable names where clean-up too( all bracket where eliminated ).

- The second tidy dataset was generated from the first one, computing the average of the means and standard deviations by subject and activity, and exporting the result to the file "average_of_mean_and_std.txt".

## Tidy datasets explained

The tables obtained are:

1. training_and_test_set_merged.txt
2. average_of_mean_and_std.txt

All measured variables contain a "t" or "f" in front of the variables that means 't'ime domain signals, and 'f'recuency domain signals. 

### training_and_test_set_merged.txt

training_and_test_set_merged.txt contain a subset of the variables (mean and standard deviation) from the UCI HAR datasets (train and test) merged together. It contain 68 variables.

1. Subject: literal ranging from 1 to 30
2. Activity: one of the states measured
    WALKING
    WALKING_UPSTAIRS
    WALKING_DOWNSTAIRS
    SITTING
    STANDING
    LAYING
3..68 Those are the means and standard deviations of the measured data. The variable names meaning are comprised of

Body Accelaration (BodyAcc), 
Gravity Acceleration (GravityAcc), 
Body Angular Velocity (BodyGyro),

the derived Jerk signals (Jerk), the 3-axial signal directions (-XYZ). And of ofcourse, the mean (-mean) and standard deviation (-std)

### average_of_mean_and_std.txt

average_of_mean_and_std.txt contain the average of the means and standard deviations of the measured variables. It has 
the same 68 variables of the former tidy dataset, and 180 rows represented by the combinations of each subject (30) with each activity (6).
