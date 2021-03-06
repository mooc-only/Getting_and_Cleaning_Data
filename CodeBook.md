# Code book of the course project

## Sources

The dataset that was transformed can be obtained here: [UCI HAR Datasets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The original explanation of the dataset can be found here: [Human Activity Recognition using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Tidy datasets explained

The tables obtained are:

1. training_and_test_set_merged.txt
2. average_of_mean_and_std.txt

All measured variables contain a `t` or `f` in front of the variables name that means 't'ime domain signals, and 'f'recuency domain signals. 

### training_and_test_set_merged.txt

training_and_test_set_merged.txt contain a subset of the variables (mean and standard deviation) from the UCI HAR datasets (train and test) merged together. It contain 68 variables.

1. Subject: Integer, ranging from 1 to 30  

2. Activity: Character, representing one of the activities measured  
    - WALKING
    - WALKING_UPSTAIRS
    - WALKING_DOWNSTAIRS
    - SITTING
    - STANDING
    - LAYING  
    
3. to the 68th. These are the means and standard deviations of the measured data.  
All these variables are numeric.  
The meaning of the variables' name are comprised of the combinations of:  

- Body Accelaration (BodyAcc), 
- Gravity Acceleration (GravityAcc), 
- Body Angular Velocity (BodyGyro),  

with the derived Jerk signals (Jerk), the 3-axial signal directions (-XYZ), the mean (-mean) and the standard deviation (-std)

### average_of_mean_and_std.txt

average_of_mean_and_std.txt contain the average of the means and standard deviations of the measured variables. It has 
the same 68 variables of the previous tidy dataset, and 180 rows represented by the combinations of each subject (30) with each activity (6).
