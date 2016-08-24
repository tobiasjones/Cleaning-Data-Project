dataFile <- './data/dataset.RData'
load(dataFile)
ls()

# 1. Merges the training and the test sets to create one data set.
mergeData <- rbind(test,train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
columns <- grep("-mean\\(\\)|-std\\(\\)", names(mergeData))
subMergeData <- mergeData[, columns]

# 3. Uses descriptive activity names to name the activities in the data set
## Added in preperation.R
table(mergeData[,'Activity'])

# 4. Appropriately labels the data set with descriptive variable names.
## Added in preperation.R
colnames(mergeData)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
TidyData <- aggregate(. ~ subject+Activity, mergeData, mean)
write.table(TidyData, file="./data/Tidy.txt", row.names = FALSE)
rm(dataFile, test, train, mergeData, subMergeData, means, std_devs, TidyData)
