## This script does the following:
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for 
#    each measurement.
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names.
#5 From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

#download and read the data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
library(lubridate)
filename <- paste(make.names(now()),".zip")
detach("package:lubridate", unload=TRUE)
download.file(url,filename)
unzip(filename)
dirc <- "UCI HAR Dataset"
NA_syms <- c("","NA","Div/0")  #I think I got them all
#filename="X2017.09.13.15.42.10.zip"
library(data.table)
train <- cbind(
     fread(file.path(dirc,"train/y_train.txt"),sep=" ", na.strings = NA_syms),
     fread(file.path(dirc,"train/subject_train.txt"),sep=" ", na.strings = NA_syms),
     fread(file.path(dirc,"train/X_train.txt"),sep=" ", na.strings = NA_syms))
test <- cbind(
     fread(file.path(dirc,"test/y_test.txt"),sep=" ", na.strings = NA_syms),
     fread(file.path(dirc,"test/subject_test.txt"),sep=" ", na.strings = NA_syms),
     fread(file.path(dirc,"test/X_test.txt"),sep=" ", na.strings = NA_syms))
clab <- fread("UCI HAR Dataset/features.txt") #file contain column lables
clab <- as.vector(clab$V2)
clab <- c("activity_id","subject_id",clab)  #contains all column names
## 1 Merges test and train data
adata <- rbind(train,test) #merges train and test into one dateset
names(adata) <- as.character(clab)
cmeanstd  <- c(grep('mean\\(\\)',clab),grep('std\\(\\)',clab))

## 2 Extract only the measurements of mean and Standard Deviations
Xmeanstd <- adata[,..cmeanstd]
adata <- cbind(adata[,1:2],Xmeanstd) #place Xmeanstd back into adata replace
activity <- fread(file.path(dirc,"activity_labels.txt"),sep=" ", na.strings = NA_syms)
## 3Use descriptive activity names for each activity in the data set
adata <- merge(activity,adata,by.y="activity_id",by.x="V1")
adata <- adata[,-1]  #first column is reduntant

## 4 provide descriptive variables names
# most of this has been done already.  Below I label the first column
names(adata)[1]<- "activity"
## 5 create a second data set with the average and each variable by 
## activity and each subject
data2 <- aggregate(adata[,3:68],list(activity=adata$activity,
                                    subject_id=adata$subject_id),mean,na.action=na.omit)
detach("package:data.table")
## code to write required data set
write.table(data2,file="tidydataset.txt")  
#I have only included the data from STEP 5 because this is the only truely novel 
# data produce by the script.  The instrutions are unclear.
