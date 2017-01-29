# GettingAndCleaningData
JH-Data Science Course - Getting and Cleaning Data Project Course

As per the project instructions:
Following things are assumed:
The dataset has already been downloaded as Dataset.zip and has been extracted in a directory "Dataset"; quotes excluded
In the same repository as that of extracted run_analysis.R is present
(i.e. dir() will have Dataset folder (having the entire extracted dataset) and run_analysis.R


Code flow:
## Step:1
There are two data sets: xtrain and xtest
Each of these datasets has a structure mentioned below.
 SubjectId  ActivityId  Measurements
SubjectId is present in Subject_*.txt file / Activity is present in yt*.txt / measurements in x*.txt file
(viz: xtrain : Subject_train.txt , ytrain.txt and xtrain.txt )
 
 
Reads xtrain (subject_train.txt, y_train.txt X_train.txt) into three tables.
All three are column binded to xtrain. After binding dimension will be : 7352  563
Reads xtest (subject_text.txt, y_test.txt, X_test.txt) into three tables.
All three are column binded to ytrain. After binding dimension will be: 2947  563
 
 Tables are row binded.
 After binding these two sets: Dimension will be: 10299   563
 
 
 Now column names are fetched from features.txt, the names in the second column are not unique.
 So column name is a combination of first column & second column format: "XXX_" + Measurement
 (XXX is a three digit format)
 
 This list is prepended by Subject, Activity (ytrain / ytest) .
 Length of this list of column headers : of course 563 
 
 Activity lables are read from activity_lables.txt. This list is having labels for each activity (ytrain/ytest), now represented by column Activity. These labels are replaced against the column "Activity" using merge operation.
 
 Here itself, names of the columns are cleaned up but with a prefix of 3 digit id of measurement
 
 
## Step2
 Extraction of columns containing mean() and std() are retreived along with subjectid & activity id using grep
 Total such extracted columnes is : 68 including "Subject" and "Activity"
## Step 3
  Names are already cleaned with prefix, so that uniqueue column names are persent.

## Step 4
  Aggregation is fired against subject & Activity calling mean for each of the extracted std()/mean() measurement.
  After firing aggregation: size of data frame is: 180, 68 
  (180 =  30 subjects * 6 activities )
  Here, prepended three digit prefix is removed to keep things neat!
## Step 5
  writes to a file  aggregatedTidyDataSet.txt (assumption is this file is not there! meaning, existing file check and cleaning the same is not done)
  
 
