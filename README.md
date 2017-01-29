# GettingAndCleaningData
JH-Data Science Course - Getting and Cleaning Data Project Course

As per the project instructions:
##Following things are assumed:
The dataset has already been downloaded as Dataset.zip and has been extracted in a directory "Dataset"; quotes excluded
In the same repository as that of extracted run_analysis.R is present
(i.e. dir() will have Dataset folder (having the entire extracted dataset) and run_analysis.R

### 
 This assignment is all about ability to understand raw data that is distributed across many places (here files).
 
 Structure of data is:
 
  ______________________________________________________________________________________________________-
  Subject-30       |  Activity-6    |  Measurements  561 measurements
  ______________________________________________________________________________________________________
                         x-train content
  subject_train.txt|   ytrain.txt   |    X_train.txt
                   |                |                                                                 
                   |                |                                                                 
                   |                |                                                                 
                   |                |                                                                 
_______________________________________________________________________________________________________                  
                   
                         x-test content
  subject_test.txt |   ytest.txt   |    X_test.txt
                   |                |                                                                 
                   |                |                                                                 
                   |                |                                                                 
                   |                |                                                                 
_______________________________________________________________________________________________________   
  
 
 There are 30 subjects (human beings)/ 6 Activities
 
 Activity and SUbject each are present in one column. So in Tidy( Codd 3 normalform?), will have 1+1+561 measurements
 
 
 Final asked std() and mean() tidy set will have of course 30(subjects)* 6( activities) = 180 rows.
 
 
 
Feel free to suggest changes in ReadMe.md
  
  
