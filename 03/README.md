This file summarizes the solution of the problem of course "Getting Data and Cleaning".

It includes:
- Readme.MD - This file
- Run_analysis.R - script with the solution
- CodeBook.MD - file with description of variables, functions, ...

The entire analysis runs run_analysis.R script. Simplified forms script create union test and train sets, and tidy target set

Task # 1 - merges the training and the test sets to create one data set.
- Creates a merged directory and stores it in combination train + test files.
- First a created subject.txt, y.txt, then through the shell calls created X.txt. Then created files in the directory Inertial Signals.
- Always taking the first test file and finally connects train set.

Task # 2 - Extracts only the measurements on the mean and standard deviation for each loop measurement.
- Takes merged files Inertial Signals and lines compute the arithmetic mean and standard deviation, and merge them into a single table called 'bigTable'.

Task # 3 - Uses activity descriptive names to name the Activities in the data set
- File activity_labels.txt loaded into variable 'activity_labels' and stained it a variable 'y' connection through 'activity_id'.
- After the 'activity' column connects to 'bigTable' table.

Task # 4 - Appropriately labels the data set with descriptive variable names.
- Variable 'bigTable' except 'signal' column is stored in a variable 'measure'.

Task # 5 - From the data set in step 4 Creates a second, independent tidy data set with the average of each loop variable: for each activity and each loop subject.
- 'Subject' column connect to the table 'measure' and store the result in the table 'measure2'.
- After the table group by 'activity' and 'subject' and calculates averages. The result into the table 'signalsAvg' and also in the file "signalsAvg.txt".
