library(dplyr)
library(doBy)

# Set your working directory
setwd("C:/Users/luis-alaniz/Desktop/R-Getting and Cleaning Data/")

# Download the data if it is not already in your working directory
if (!file.exists("final.zip") & !file.exists("final")) {
        fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileurl, "final.zip")
        dateDownloaded <- date()
        unzip("final.zip", exdir = "final")
}

#Reading the data and labels
runtest_data <- read.table("final/UCI HAR Dataset/test/X_test.txt")
runtest_subjects <- read.table("final/UCI HAR Dataset/test/subject_test.txt")
runtest_variables <- read.table("final/UCI HAR Dataset/test/y_test.txt")
runtrain_data <- read.table("final/UCI HAR Dataset/train/X_train.txt")
runtrain_subjects <- read.table("final/UCI HAR Dataset/train/subject_train.txt")
runtrain_variables <- read.table("final/UCI HAR Dataset/train/y_train.txt")
run_features <- read.table("final/UCI HAR Dataset/features.txt")
run_labels <- read.table("final/UCI HAR Dataset/activity_labels.txt")

# Making all the dataframes datatables
runtest_data <- tbl_df(runtest_data)
runtest_subjects <- tbl_df(runtest_subjects)
runtrain_variables <- tbl_df(runtrain_variables)
runtrain_data <- tbl_df(runtrain_data)
runtrain_subjects <- tbl_df(runtrain_subjects)
runtrain_variables <- tbl_df(runtrain_variables)
run_features <- tbl_df(run_features)
run_labels <- tbl_df(run_labels)

#names for the data sets columns
names(runtest_data) <- run_features$V2
names(runtrain_data) <- run_features$V2

# Parentesis are not valid for names in R the following two lines of codes replace them by points and not get the duplicate column error
valid_runtest_data_column_names <- make.names(names=names(runtest_data), unique=TRUE, allow_ = TRUE)
valid_runtrain_data_column_names <- make.names(names=names(runtrain_data), unique=TRUE, allow_ = TRUE)

#Puts valid names to the columns of the data sets
names(runtest_data) <- valid_runtest_data_column_names
names(runtrain_data) <- valid_runtrain_data_column_names

# Select the mean and std columns from the data sets (second (I started that way in order to spare memory) and fourth points of the assignment)
runtest_data <- select(runtest_data, contains(".mean."), contains(".std."))
runtrain_data <- select(runtrain_data, contains(".mean."), contains(".std."))

# Add subject and variables columns
runtest_data <- mutate(runtest_data, subjects = runtest_subjects$V1, variables = runtest_variables$V1)
runtest_data <- select(runtest_data, names(runtest_data[67:68]), names(runtest_data[1:66]))
runtrain_data <- mutate(runtrain_data, subjects = runtrain_subjects$V1, variables = runtrain_variables$V1)
runtrain_data <- select(runtrain_data, names(runtrain_data[67:68]), names(runtrain_data[1:66]))

# Merge the training and test sets, clean up, and arrange by subjects and variables (first and third points of the assignment)
run_data <- rbind(runtrain_data,runtest_data)
names(run_labels) <- c("variables", "activities")
run_data <- merge(run_data, run_labels, by = "variables")
rm(run_features, runtrain_data, runtest_data, runtrain_subjects, runtrain_variables, runtest_subjects, runtest_variables, valid_runtrain_data_column_names, valid_runtest_data_column_names, run_labels)
run_data <- select(run_data, - variables)
run_data <- mutate(run_data, subjects = as.factor(subjects))
run_data <- mutate(run_data, activities = as.factor(activities))
run_data_labels <- gsub("\\.","",names(run_data))
names(run_data) <- run_data_labels
rm(run_data_labels)
run_data <- select(run_data, subjects, activities, names(run_data[2:68]))
run_data <- arrange(run_data, subjects, activities)


# Final tidy data set of averages
final_data <- tbl_df(summaryBy(.~subjects+activities, data=run_data, FUN=mean))
final_data_labels <- sub("\\.mean","Avg",names(final_data))
names(final_data) <- final_data_labels
rm(final_data_labels)
rm(run_data)

# Exporting the results

write.table(final_data, "final/run_analysis_summary_data.txt", row.name = FALSE)
