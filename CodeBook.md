# About the Original Data Set
Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

# Introduction
The run_analysis.R script will do the following:
- create the directory for the project
- load packages needed for the script to run
- read the downloaded and unzipped files (see README instructions) into R
- merge data sets into one
- extract observations for the mean and standard deviation measurements only
- label columns with clean and appropriate descriptive names
- create a tidy data set from the merged data set
- exports tidy data set into a csv file

# Files Used
### Note: "X" in X_train and X_test files is in uppercase; "y" in y_train and y_test files is in lowercase
- subject_train.txt <- subject IDs for train
- X_train.txt <- values of variables in train
- y_train.txt <- activity ID for train

- subject_test.txt <- subject IDs for test
- X_test.txt <- values of variables in test
- y_test.txt <- activity ID for test

- features.txt <- labels for all x variables
- activity_labels.txt <- labels for all y IDs

# Assigned Names
- merged = contains merged data set from original training and test data sets
- MeanStdOnly = contains extracted mean and standard deviation columns, updated to "merged"
- activitylabels = contains activity names from activity_labels.txt converted into factors
- CleanFeatures = contains "cleaned up" feature names from features.txt used as column names for "merged" data set
- melted = contains melted tall and skinny data set
- tidy = tidy data set containing only the extracted columns (subject ID, activity, mean measurements, standard deviation measurements) with clean column names
- organizeddata - final data set containing clean data that can be exported neatly to a txt file

### TidyDataProject.txt = file containing the output of this project
