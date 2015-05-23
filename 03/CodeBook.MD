This file is code book for the solution of the problem of course "Getting Data and Cleaning".

# Library
- Gdata - for write.fwf
- Data.table - for "group by"

# Function
- tmp_load - auxiliary function for loading subject_*.txt and y_*.txt
- tmp_save - auxiliary function for saveing ??subject.txt and y.txt
- mergeInertialSignals - merge function for train and test data from Inertial Signals.

# Variables
- rootDir - location input directory "UCI HAR Dataset"
- dirTest - a directory name [RootDir] / test / Inertial Signals with test files
- dirTrain - a directory name [RootDir] / train / Inertial Signals with train sets
- dirInerSig - a directory name [RootDir] / merged / Inertial Signals, which are unioned files test and train
- features - uploaded file "features.txt"
- subject - combined files subject_test.txt and subject_train.txt
- y - associated files y_test.txt and y_train.txt
- activity_label - File uploads activity_labels.txt
- y_label - y extension table about activity names from activity_label.txt
- bigTable - over unioned files test+train from "Inertial Signals" is each measurement (ROW) calculated arithmetic mean and standard deviation. columns:
-- signal - what/how it was measured, respectively file identification
-- mean - arithmetic average of the entire input line
-- sd - standard deviation of the entire input line
-- activity - activity name
- measure - just like 'bigTable' without 'signal' column
- measure2 - extended table measure of 'subject' column

# Output variables
- signalsAvg - a table showing mean values (mean, SD) through a subject and activity. Column: activity, subject, mean, sd.

# Notes
- Other documents refer to file code run_analysis.R.