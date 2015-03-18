# Getting and Cleaning Data. Course Project 

This is the repository to evaluate the course project.  
We are using the UCI HAR Dataset to perform the operations and obtain the tidy data sets requested.

## About the script

The script is completely autonomous. You just have to download the file `run_analysis.R` and 'source' it - you don't have to download manually the dataset if you don't want to.  

## How the script `run_analysis.R` reproduce the tidy datasets

The following operations was performed to create the tidy datasets requested:

- The UCI HAR Dataset is downloaded and unziped, if there are found neither the .zip file, nor the dataset folder.

- Read from the `train` and `test` folder the measured variables (X_?.txt), the subjects ID (subjects_?.txt) and the activities (y_?.txt), and merge them respectively.

- Assign proper activity name to each observation in the dataset. 

- Export only the measured means and standard deviations to the file `training_and_test_set_merged.txt` with appropiate descriptive variable names read from the file `features.txt`. The variable names where clean-up too( all bracket where eliminated ).

- The second tidy dataset was generated from the first one, computing the average of the means and standard deviations by subject and activity, and exporting the result to the file `average_of_mean_and_std.txt`.
