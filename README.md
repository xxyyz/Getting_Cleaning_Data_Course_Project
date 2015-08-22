# Intro to this repo Getting_Cleaning_Data_Course_Project

This repo contains material for the course project of "Getting and Cleaning Data" on Coursera,
from John Hopkins University, in the series of the specialization "Data Science".

# Content of the repo

Files and their contents are determined by the project's task description.

3 files are included (all in the main branch), according to the assignment:
* this README.md: "You should also include a README.md in the repo with your scripts. This ~~repo~~ _readme_ explains how all of the scripts work and how they are connected."
* CodeBook.md: "a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data"
* run_analysis.R: the "script for performing the analysis"

# Functionality of run_analysis.R

There is only 1 script "run_analysis.R", containing 2 functions, doing all the work for this assignment.

Details are in the script itself as comments. Here follows a higher level overview.

(Note: consult "CodeBook.md" to read about the output data created by "run_analysis.R".
"CodeBook.md" also explains how to get the source data and how to run "run_analysis.R"...)

run_analysis.R contains 2 functions and a few lines of "main program", calling those functions.

## read_mean_std()

The 1st function ("read_mean_std") simply reads the needed source data, assuming that the needed files are available
(as they should be, according to the course project assignment).

More specifically: it combines the train and test data using rbind (see point 1 of the task description) and
filters for the _measurements_ on the mean and standard deviation for each measurement (see point 2 of the task description).

As the original feature names are descriptive enough, this function simply greps for mean and std
in the feature names and adds some more processing (to filter out those columns that are not _measurements_, but results of calculations).

read.table utilizes colClasses to read in only the really needed data (see "NULL" to skip not needed columns), so using as minimal memory as possible. (~10% of the amount needed to read all, unfiltered data into memory.)

col.names is also prepared properly and used in read.table, so point 4 of the task description is fulfilled.

## add_subject_activity()

The 2nd function ("add_subject_activity") takes the output of the first ("read_mean_std") and adds 2 ID columns (using cbind) to the (beginning of the) measurements data set: person IDs ("subject") and activity names. We use activity _names_ (from activity_labels.txt) (instead of IDs, that would simplify the program a bit) to fulfill point 3 of the task description.

## the main program

This just calls the 2 functions (above) and then use data.table to calculate the group means (see point 5 of the task description).

Finally it exports the result to a .txt file as it has to be uploaded for the peer review part.
