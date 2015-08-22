"describes the variables, the data, and any transformations or work that you performed to clean up the data"

# Data and variable description

Here follows a concise description of the data in the output file ("datatable_point_5.txt", see below).

It contains 181 rows, the first being a header, so we have 180 "observations".
It contains 42 columns, the first 2 being ID columns, showing the groupings. Thus we have 40 "variables".

## 1st column ("subject")

It contains the IDs of the people participated in the experiment.
These are the same IDs as the ones in the source files "test/subject_test.txt" and "train/subject_train.txt"

## 2nd column ("activity")

It contains the names ("labels") of activities done by the people.
They come from the original source files "test/y_test.txt" and "train/y_train.txt"
combined with the file "activity_labels.txt".

## all the following columns, from column 3 to 42

These are "the average of each variable for each activity and each subject", as specified in the project assignment (see its point 5).

I.e. the variables are "only the measurements on the mean and standard deviation for each measurement"
of the original source.
In other words, these variables are coming from those columns of the source files "test/X_test.txt" and "train/X_train.txt" whose headers (in features.txt) contain either "-mean(" or "-std(" and does not start with "f"
(because "f" fields are calculated numbers, not measurements) -- c.f. the original file "features_info.txt".

The names of these columns come from the source file "features.txt" replacing "(", ")" and "-" by ".".
(This replacement is done by R automatically, during read.table(X.txt,col.names = column_names...) in my
run_analysis.R. As these changes do not hurt, I kept them.)

To understand the data in these columns, consult the original desriptions (in "features_info.txt" and "README.txt"),
keeping in mind that datatable_point_5.txt contains the averages per person, per activity.

So e.g.
datatable_point_5.txt's last row's 3rd column (0.269881106779661) is the mean of person 24's measurements for
"tBodyAcc-mean()-X" from "test/X_test.txt" while he was "WALKING_UPSTAIRS"...

Units of these variables can also be seen from the source documentation (README.txt). In short:
* the unit is the standard gravity unit "g" for variables containing acceleration measurement (this is indicated by "Acc" in the variable name);
* the unit is radians/second for the rest (having "Gyro" in their names, containing angular velocity data).

# Transformations made to get the final data set

Executing the steps below will recreate the same output as the one I uploaded to the course project page
(as far as the download links in point 1 below contain the same source data and
the R functionality in the script produces the same output...
I downloaded the files in August 2015 and
used RStudio Version 0.99.467, R 3.2.2 on 64 bit Ubuntu 15.04...).

1. Download the original data from the course project assignment
("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"), or, as noted there, from
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

2. Unzip the downloaded "getdata_projectfiles_UCI HAR Dataset.zip" or "UCI HAR Dataset.zip" into your
R's working directory's subdirectory "UCI HAR Dataset" (create this subdirectory first, if needed).

3. Run run_analysis.R
Note: run_analysis.R uses library "data.table", so install that library first, if you don't have it yet.

4. As the result of running run_analysis.R, the file datatable_point_5.txt will be created in R's working directory
(i.e. _besides_ the subdirectory "UCI HAR Dataset" created in point 2 above).
This *is* the output, equal to the file I submitted to the course project's peer review.
