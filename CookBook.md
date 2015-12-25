#Cookbook
Explanation of run_Analysis.R script
- LOC 4 to 13
Download the data from Website and note the time of download
- LOC 15 to 25
Reading the data.The data consist of Test and Training sets and lables for activity and subject.
- LOC 27-28
Removing () from the feature lables
- LOC 30-33
After cleaning up the data, the data is binded together. 
- LOC 35-38
Column names assignment from feature labels, activity and subject
- LOC 40-41
Complete data set for analysis
- LOC 43-46
Filer the data which is mean and std in column names
- LOC 48-54
Factoring the activity column and assigning the factors to the filtered data
- LOC 55- 57
Aggregate the data based on subject and activity
- LOC 58
Tidy Data File creation
