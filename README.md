gettingAndCleaningData
======================
The runAnalysis script begins by reading the files that contain the data needed to perform the analysis:

X_train.txt: - Training set
y_train.txt: - Training labels
subject_train.txt: - Subject who performed the activity and ranges from 1 to 30.
X_test.txt: - Test set
y_test.txt: - Test labels
subject_test.txt: - Subject who performed the activity and ranges from 1 to 30.
activity_labels.txt: - Activities performed by each subject
features.txt: - each measurement name

After reading the data, train and test are combined into one set with:

dataset <- rbind(xtest, xtrain)

Then labels are combined into one set of labels with:

labeldata <- rbind(ytest, ytrain)

Activity data is converted into factor with the code line:

activity <- factor(labeldata[,1], labels = activities[,2]) 
to make sure each activity name is stored only once.

Next, the subject data for the test set and train set are combined into one, and converted into factor to ensure each subject value is stored only once:

subjectdata <- rbind(subjecttest, subjecttrain)
subject <- factor(subjectdata[,1], labels = unique(subjectdata[,1]))

The next two lines of code will create the column names of the dataset. The first line takes the second column
of features data because this is the column with all the measurements, but we make sure we read each measurement only once
with the keyword "unique", and then each character that comes after either the "-" and "." converts it to uppercase, and
the second line subsitutes each "()" or "-" with empty space "".

names(dataset) <- gsub("(-.)", "\\U\\1", unique(features[,2]), perl=TRUE)
names(dataset) <- gsub("[()-]", "", (names(dataset)))

The next line:

mydata <- dataset[,grepl("Mean|Std", names(dataset))]

takes a subset of the whole dataset, where the column names contain the word "Mean" or "Std". 
The data is grouped by activity, and subject with the code line:

runAnalysisOutput <- aggregate(mydata, by = data.frame(activity, subject), FUN = mean)

The final result which is tidy dataset is then saved to a txt file, runAnalysisOutput by the code line:

write.table(runAnalysisOutput, 'runAnalysisOutput.txt', row.name = FALSE) 
