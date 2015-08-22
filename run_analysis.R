# 2 helper functions, then the main program

read_mean_std <- function(){
    # read the mean and std.deviation from both the train and test file into
    # 1 common data frame and return it
    
    # check if input is available -- c.f. "run_analysis.R [...] can be run as
    # long as the Samsung data is in your working directory"
    if (!file.exists("UCI HAR Dataset")) stop("input data is missing")
    # note: it could be downloaded from
    # http://archive.ics.uci.edu/ml/machine-learning-databases/00240/

    # prepare the list of (indexes of) columns to be read: only mean and std
    # are needed -- c.f. "run_analysis.R [...] extracts only the measurements on
    # the mean and standard deviation for each measurement" (note: meanFreq
    # is not needed...)
    # see also features_info.txt
    column_names <- as.character(read.table("UCI HAR Dataset/features.txt")[,2])
    mean_std_column_indexes <- grep("-mean\\(|-std\\(", column_names, ignore.case = TRUE)
    
    col_classes <- rep("NULL", 561)            # skip all columns ...
    col_classes[mean_std_column_indexes] <- NA # ... except mean and std ...
    col_classes[266:561] <- "NULL"             # ... of txxx features (i.e.: no fxxx is needed)
    
    return(rbind(read.table("UCI HAR Dataset/train/X_train.txt", colClasses = col_classes, col.names = column_names),
                 read.table("UCI HAR Dataset/test/X_test.txt",   colClasses = col_classes, col.names = column_names)))
}

add_subject_activity <- function(df) {
    # append 2 columns to the beginning of df: subject and activity
    # df = dataframe with same number of rows as the train + test data...
    # note: train and test data must be read here in the same order as they are coming in df
    # (i.e. as they are read in read_mean_std()...)
    
    # read in activities and replace their id numbers by the corresponding label. Because our task includes:
    # "run_analysis.R [...] uses descriptive activity names to name the activities in the data set"
    activity_column <- rbind(read.table("UCI HAR Dataset/train/y_train.txt", col.names = c("activity")),
                             read.table("UCI HAR Dataset/test/y_test.txt",   col.names = c("activity")))
    
    activity_labels <- as.character(read.table("UCI HAR Dataset/activity_labels.txt")[,2])
    
    activity_column[,"activity"] <- activity_labels[activity_column[,"activity"]]
    
    # build the final data table with
    # 1st column (ID) "subject", 2nd column (ID) "activity" and the rest: the measurements...
    return(
        cbind(
            rbind(read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject")),
                  read.table("UCI HAR Dataset/test/subject_test.txt",   col.names = c("subject"))),
            activity_column,
            df))
}

#### The main program starts here

# let's create the data set defined in point 4 of the course project
dataset_4 <- add_subject_activity(read_mean_std())

# let's create the data set defined in point 5 of the course project
# note: data tables ARE data sets as well
library(data.table)
datatable_5 <- data.table(dataset_4)[, lapply(.SD, mean), by=c("subject", "activity")]

#export as requested:
write.table(datatable_5,row.names = FALSE, file = "datatable_point_5.txt")

# message("The End")
