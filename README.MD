---
title: "Readme for Assignment 2"
author: "Brendan"
date: "September 14, 2017"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
==================================================================
##Tidying of the Human Activity Recognition Using Smartphones Dataset

==================================================================
This data set is downloaded and transformed into a tidy dataset. This is distributed as is and 
is not intended for commercial purposes.

References
==========
I aknowledge the data set developed by:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

Additional information regarding the data set can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

=================================================================================
##This repo contains the following files:
=================================================================================

*README.txt that explains the analysis files

*Codebook.md that documents the variables and analysis

*tidydataset.txt - contains the mean of the data stored in adata aggregated by activity and subject

*run_analysis.R a script that generates the tidy data and analysis

##Script procedure

The zip files were downloaded from the following url:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
To view documentation on the downloaded set and experiment view the README.txt file in in the above url

The analysis file downloads and unzips the data from the above url.

The files below are read from the unziped "UCI HAR Dataset" directory and 
stored in the indicated variables:
train/y_train.txt		     - train column 1
train/subject_train.txt		- train column 2
train/X_train.txt	     	- train column 3-563

test/y_test.txt			- test column 1
test/subject_test.txt		- test column 2
test/X_test.txt			- test column 3-563

features.txt			- clab 

clab contain the column 3-563 labels for train and test.
It is ammended to include the labels "activity_id" and "subject_id" for columns 1 and 2.

1. Merge training and test datasets
Train and test are combine with rbind to create a merged data set stored in adata.
The columns are labeled with the values stored in clab.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
The the columns from adata corresponding the values of clab which contain the strings 
"mean" and "std" are extracted and stored in Xmeanstd.

3. Label the activities
adata is updated to contain only the first two columns of adata and the columns of Xmeanstd.
The activity.txt file is read and stored in activity. 
activity and adata are merge by activity_id and store in adata.
The first column of adata containing activity_id is removed.
The first column of adata now contains the activity labels.

4. Label the variables
This step was completed when the datasets were merged in step 1.

5. create a second data set with the average and each variable by  activity and each subject
The means of adata are calculated on the adata aggregated by activity and subject_id and stored in data2.

data2 is writen to "tidydataset.txt".

