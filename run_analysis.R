#Create folder for exercise
if(!file.exists("TidyDataProject")) {
        dir.create("TidyDataProject")
}

#Load packages

library(data.table)
library(dplyr)
library(plyr)
library(reshape2)

#Step 1: Merge the training and test data.

##1.1 read data

subject_train <- read.table("subject_train.txt") #subject IDs for train
x_train <- read.table("X_train.txt")             #values of variables in train
y_train <- read.table("y_train.txt")             #activity ID for train
subject_test <- read.table("subject_test.txt")   #subject IDs for test
x_test <- read.table("X_test.txt")               #values of variables in test
y_test <- read.table("y_test.txt")               #activity ID for test
features <- read.table("features.txt")           #labels for all x variables
activities <- read.table("activity_labels.txt")  #labels for all y IDs

##1.2 assign column names
##subject ID
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

##features
names(x_train) <- features$V2
names(x_test) <- features$V2

##activities
names(y_train) <- "activity"
names(y_test) <- "activity"

##1.3 merge
train <- cbind(subject_train, x_train, y_train)
test <- cbind(subject_test, x_test, y_test)
merged <- rbind(train, test)

#Step 2. Extract the measurements on the mean and standard deviation only
#for each measurement.
##2.1 determine columns
MeanStdOnly <- grepl("subjectID|activity|mean|std", colnames(merged))

##2.2 extract mean and standard deviation columns to updated data set
merged <- merged[ , MeanStdOnly]

#Step 3. Use descriptive activity names to name the activities in the data set.
activitylabels <- factor(merged$activity)
levels(activitylabels) <- activities[,2]
merged$activity <- activitylabels


#Step 4. Assign appropriate labels to the data set 
#using descriptive variable names.
##4.1 Get column names
CleanFeatures <- colnames(merged)

##4.1 Clean and remove special characters
CleanFeatures <- gsub("[\\(\\)-]", "",CleanFeatures)

##4.2 Expand descriptive activity names
CleanFeatures <- gsub ("^f", "frequencyDomain", CleanFeatures)
CleanFeatures <- gsub("^t", "timeDomain", CleanFeatures)
CleanFeatures <- gsub("Acc", "Accelerometer", CleanFeatures)
CleanFeatures <- gsub("Gyro", "Gyroscope", CleanFeatures)
CleanFeatures <- gsub("Mag", "Magnitude", CleanFeatures)
CleanFeatures <- gsub("Freq", "Frequency", CleanFeatures)
CleanFeatures <- gsub("mean", "Mean", CleanFeatures)
CleanFeatures <- gsub("std", "StandardDeviation", CleanFeatures)

##4.3 Assign new labels to column names
colnames(merged) <- CleanFeatures

#Step 5. Create a second, independent tidy data set 
#with the average of each variable for each activity and each subject.
#Use the data set in step 4.
##5.1 Create tidy data set
melted <- melt(merged, id=c("subjectID","activity"))
tidy <- dcast(melted, subjectID+activity ~ variable, mean)

##5.2 Write tidy data set to csv file
write.csv(tidy, "tidydataproject.csv", row.names=FALSE)