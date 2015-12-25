library(dplyr)

# Download the data 
if (!file.exists("data")) {
dir.create("data")

#File URL and name
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
Name <- "./data/activity.zip"

# download the file & note the time
download.file(fileUrl, Name)
dateDownloaded <- date()}

# read data for test
TestFeatures <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
TestActivityLabel <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
TestSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
# read the data for Training
TrainingFeatures <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
TrainingActivityLabel <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
TrainingSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
# Read labels for activity and subject
activityLabel <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
featuresLabel <- read.table("./data/UCI HAR Dataset/features.txt")

#Remove the () from label
featuresLabel$V2 <- gsub("\\()", "", featuresLabel$V2)

#Bind the data to single table
subject <- rbind(TrainingSubject, TestSubject)
activity <- rbind(TrainingActivityLabel, TestActivityLabel)
features <- rbind(TrainingFeatures, TestFeatures)

#Assign Coloumn names 
colnames(features) <- t(featuresLabel$V2)
colnames(activity) <- "Activity"
colnames(subject) <- "Subject"

#Cleaned complete data
DataFrame <- cbind(features,activity,subject)

#Filtering for required data
MeanValues <- grep(".*Mean.*|.*Std.*", names(DataFrame), ignore.case=TRUE)
Req_Col <- c(MeanValues, 562, 563)
Req_Data <- DataFrame[,Req_Col]

#factor the Activity data and assign to required data
Req_Data$Activity <- as.character(Req_Data$Activity)
for (i in 1:6){
Req_Data$Activity[Req_Data$Activity == i] <- as.character(activityLabel[i,2])}
Req_Data$Activity <- as.factor(Req_Data$Activity)
Req_Data$Subject <- as.factor(Req_Data$Subject)
Req_Data <- data.table(Req_Data)
#Tidy data file creation
Tidy_Data <- aggregate(. ~Activity+Subject, Req_Data, mean)
Tidy_Data <- Tidy_Data[order(Tidy_Data$Activity,Tidy_Data$Subject),]
write.table(Tidy_Data, file = "Tidy_Data.txt", row.names = FALSE)