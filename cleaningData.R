library(plyr) 

############################################################################### 
# Step 1. Merge the training and the test sets to create one data set, that is,
#         create one data set per data-x, y, subject so total 3 tables
############################################################################### 

# read train data
x_train <- read.table("train/X_train.txt") 
y_train <- read.table("train/y_train.txt") 
subject_train <- read.table("train/subject_train.txt") 

# read test data
x_test <- read.table("test/X_test.txt") 
y_test <- read.table("test/y_test.txt") 
subject_test <- read.table("test/subject_test.txt") 

# merge train and test regarding 'x' 
x_data <- rbind(x_train, x_test)
                
# merge train and test regarding 'y'
y_data <- rbind(y_train, y_test) 
                
# merge train and test regarding 'subject'
subject_data <- rbind(subject_train, subject_test) 
                
# correct the column names 
names(subject_data) <- "subject"
             
   
############################################################################### 
# Step 2.Extract only the measurements on the mean and standard deviation for each measurement 
############################################################################### 
                
# read files describing features
features <- read.table("features.txt") 
                
# get column numbers and value which have "mean()" or "std()" 
col_mean_std <- grep("-(mean|std)\\(\\)", features[, 2])  # column numbers which correspond to the conditions
val_mean_std <- grep("-(mean|std)\\(\\)", features[, 2], value=T)  # values which correspond to the conditions
                
# extract the desired columns
x_mean_std <- x_data[, col_mean_std]
                
# correct the column names
names(x_mean_std) <- val_mean_std
                

############################################################################### 
# Step 3. Use descriptive activity names to name the activities in the data set 
############################################################################### 
                
# read files describing activities
activities <- read.table("activity_labels.txt") 
                
# attach activity names to the activity number
y_named_data <- merge(activities, y_data, by.x="V1", by.y="V1", all.x=TRUE)
                
# correct the column names 
names(y_named_data) <- c("activity_code", "activity_name") 
       
         
############################################################################### 
# Step 4. Appropriately label the data set with descriptive variable names 
############################################################################### 
                
# Since all the column names are assigned aprropriately, just bind all the data in a single data set 
binded_data <- cbind(x_mean_std, y_named_data, subject_data) 
                

############################################################################### 
# Step 5. Create a second, independent tidy data set with the average of each variable 
#         for each activity and each subject 
############################################################################### 
                
# calculate average of each variable for each activity and each subject
average_data <- ddply(binded_data, .(subject, activity_name), function(x) colMeans(x[, 1:66])) 
                
# export the result data
write.table(average_data, "averages_data.csv", sep=",", col.names=TRUE, row.name=FALSE) 
                