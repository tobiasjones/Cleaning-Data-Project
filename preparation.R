if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI%20HAR%20Dataset.zip")
unzip('./data/UCI%20HAR%20Dataset.zip', exdir = "./data")

dataDir <- './data/UCI HAR Dataset/'
dataFile <- './data/dataset.RData'

if (!file.exists(dataFile)) 
{
    temp = read.table(paste(dataDir, "activity_labels.txt", sep = ""), sep = "")
    activityLabels = as.character(temp$V2)
    temp = read.table(paste(dataDir, "features.txt", sep = ""), sep = "")
    attributeNames = temp$V2

    training_x <- read.table(paste(dataDir, "train/X_train.txt", sep = ""), sep = "")
    training_x[,names(training_x)] <- apply(training_x[,names(training_x)], 2, function(x) as.numeric(as.character(x)))
    names(training_x) = attributeNames
    training_y = read.table(paste(dataDir, "train/y_train.txt", sep = ""), sep = "")
    names(training_y) = "Activity"
    training_y$Activity = as.factor(training_y$Activity)
    levels(training_y$Activity) = activityLabels
    training_subjects = read.table(paste(dataDir, "train/subject_train.txt", sep = ""), sep = "")
    names(training_subjects) = "subject"
    training_subjects$subject = as.factor(training_subjects$subject)
    train = cbind(training_x, training_subjects, training_y)
    
    testing_x = read.table(paste(dataDir, "test/X_test.txt", sep = ""), sep = "")
    testing_x[,names(testing_x)] <- apply(testing_x[,names(testing_x)], 2, function(x) as.numeric(as.character(x)))
    names(testing_x) = attributeNames
    testing_y = read.table(paste(dataDir, "test/y_test.txt", sep = ""), sep = "")
    names(testing_y) = "Activity"
    testing_y$Activity = as.factor(testing_y$Activity)
    levels(testing_y$Activity) = activityLabels
    testing_subjects = read.table(paste(dataDir, "test/subject_test.txt", sep = ""), sep = "")
    names(testing_subjects) = "subject"
    testing_subjects$subject = as.factor(testing_subjects$subject)
    test = cbind(testing_x, testing_subjects, testing_y)
    
    save(train, test, file = dataFile)
    rm(train, test, temp, training_y, testing_y, training_x, testing_x, 
       training_subjects, testing_subjects, activityLabels, attributeNames,
       dataDir, dataFile, fileUrl)
}
