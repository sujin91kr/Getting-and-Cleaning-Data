# Introduction

The script run_analysis.R contains 5 steps following the coursera-Getting and Cleaning Data project.
  1. Merges the training and the test sets to create one data set.
    - data are merged using rbind() to create 3 tables(x, y, subjet)  
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    - Only those columns with "mean()", "std()" are taken from the above tables.
    - Then, name the columns using features.txt file.
  3. Uses descriptive activity names to name the activities in the data set
    - From the activity_labels.txt file, match the activity number with the corresponding name. 
  4. Appropriately labels the data set with descriptive variable names. 
    - Correct the names of columns with appropriate labels.
  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and      each subject.
    - Calculate the average for each activity and each subject.



# Data and Variables

• `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` : downloaded data.
• `x_data`, `y_data` and `subject_data` : created by merging the previous datasets.
  - the subject_data's column name is "subject"
• `x_mean_std` : the subset of x_data which contains only mean, std.
  - column names are the features
• `y_named_data` : contains both the activity codes and the names.
  - column names are the "activity_code" and "activity_name"
• `binded_data` : a big dataset that contains x_mean_std, y_named_Data and subject_data
• `average_data` : arregated by mean for each activity and each subject.
