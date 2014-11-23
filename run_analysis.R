#Getting and cleaning data project
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE, sep = "")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE, sep = "")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep = "")
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE, sep = "")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE, sep = "")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep = "")

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE, sep = "")
features <- read.table("./UCI HAR Dataset/features.txt", header = FALSE, sep = "")

dataset <- rbind(xtest, xtrain)
labeldata <- rbind(ytest, ytrain)
activity <- factor(labeldata[,1], labels = activities[,2])
subjectdata <- rbind(subjecttest, subjecttrain)
subject <- factor(subjectdata[,1], labels = unique(subjectdata[,1]))
names(dataset) <- gsub("(-.)", "\\U\\1", unique(features[,2]), perl=TRUE)
names(dataset) <- gsub("[()-]", "", (names(dataset)))

mydata <- dataset[,grepl("Mean|Std", names(dataset))]

myOutput <- aggregate(mydata, by = data.frame(activity, subject), FUN = mean)
write.table(myOutput, 'myOutput.txt', row.name = FALSE) 
