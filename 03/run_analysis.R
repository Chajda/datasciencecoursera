###
# Project (Getting and Cleaning Data)
###

install.packages("gdata")
library(gdata) # for write.fwf
library(data.table)


# Decompress zip to working directory (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
# manual

rootDir <- file.path(getwd(), "UCI HAR Dataset")
#setwd(rootDir)

# load features.txt
features <- read.csv(file.path(rootDir, "features.txt"), sep=" ", header=FALSE)



############################################################
# Task 1
# Merges the training and the test sets to create one data set.
############################################################

# create dir merge for merged files
dir.create(file.path(rootDir, "merged"), showWarnings = FALSE)
# init dir
dirTest <- file.path(rootDir, "test", "Inertial Signals")
dirTrain <- file.path(rootDir, "train", "Inertial Signals")
dirInerSig <- file.path(rootDir, "merged", "Inertial Signals")
dir.create(dirInerSig, showWarnings = FALSE)



############################################################
# Auxiliary function for loading a 1-columns (csv) file of
# relevant path conventions.
#
# Arguments:  rootDir - start/root directory (ex. getwd())
#             name - Name of variable (ex. subject, y)
#             suffix - group (ex. test, train)
#
# Note file path: [rootDir]/[suffix]/[name]_[suffix].txt
#
# Return:     data.frame Nx1
#
tmp_load <- function(rootDir, name, suffix) {
  file <- file.path(rootDir, suffix, paste(name, "_", suffix, ".txt", sep=""))
  data <- read.table(file=file)
  rm(file)
  colnames(data) <- name
  data
}


############################################################
# Auxiliary function for saveing a 1-columns (csv) file of
# relevant path conventions.
#
# Arguments:  data - data.frame Nx1
#             rootDir - start/root directory (ex. getwd())
#             name - Name of variable (ex. subject, y)
#
# Note file path: [rootDir]/merged/[name].txt
#
tmp_save <- function(data, rootDir, name) {
  file <- file.path(rootDir, "merged", paste(name, ".txt", sep=""))
  write.table(x=data, file=file, row.names=FALSE, col.names=FALSE)
  rm(file)
}


# load file subject_test.txt (subject_train.txt)
subject_test <- tmp_load(rootDir, "subject", "test")
subject_train <- tmp_load(rootDir, "subject", "train")
# merge subject
subject <- rbind(subject_test, subject_train)
rm(subject_test, subject_train)
# save subject.txt
tmp_save(subject, rootDir, "subject")


# load file y_test.txt (y_train.txt)
y_test <- tmp_load(rootDir, "y", "test")
y_train <- tmp_load(rootDir, "y", "train")
# merge y
y <- rbind(y_test, y_train)
rm(y_test, y_train)
# save y.txt
tmp_save(y, rootDir, "y")


# merged file X_test.txt and X_train.txt
# run in shell:
# copy "test\X_test.txt"+"train\X_train.txt" "merged\X.txt"



############################################################
# Function for merge train and test data from Inertial
# Signals.
#
# Arguments: signal - ex. "body_acc_x"
#
# Note: Files are in directories "test/Inertial Signals" and
#       "train/Inertial Signals"
mergeInertialSignals <- function(signal) {
  file1 <- paste(signal, "_test.txt", sep="")
  file2 <- gsub("test", "train", file1) # source name 2
  file <- gsub("_test", "", file1) # result file name
  # load
  print(paste("Loading", file1))
  f1 <- read.fwf(file.path(dirTest, file1), width=rep(16, 2048/16))
  print(paste("Loading", file2))
  f2 <- read.fwf(file.path(dirTrain, file2), width=rep(16, 2048/16))
  # merge
  f <- rbind(f1, f2)
  rm(f1, f2)
  # save
  print(paste("Writeing", file))
  write.fwf(x=f, file=file.path(dirInerSig,file), colnames=FALSE, sep="", width=rep(16, 2048/16))
  rm(file, file1, file2)
}

# Merge files in directories Inertial Signals
sapply(gsub("_test.txt","",list.files(dirTest)), mergeInertialSignals)



############################################################
# Task 2
# Extracts only the measurements on the mean and standard deviation for each measurement.
############################################################
bigtable <- data.frame(character(0), numeric(0), numeric(0))
for (file in list.files(dirInerSig)) {
  # load file
  print(paste("Loading", file))
  data <- read.fwf(file.path(dirInerSig, file), width=rep(16, 2048/16))
  # create table [signal, mean, sd]
  signal <- gsub(".txt","",file)
  table <- data.frame(signal=rep(signal, nrow(data)), mean=rowMeans(data), sd=apply(data,1, sd))
  bigtable <- rbind(bigtable, table)
}



############################################################
# Task 3
# Uses descriptive activity names to name the activities in the data set
############################################################

# load activity_label.txt
activity_label <- read.csv(file.path(rootDir, "activity_labels.txt"), sep=" ", header=FALSE)
colnames(activity_label) <- c("activity_id", "activity")
# extension y about activity names
colnames(y) <- "activity_id"
y_label <- merge(y, activity_label, by="activity_id", sort=FALSE)$activity
# extension bigtable about activity name
bigtable <- data.frame(bigtable, activity=rep(y_label, length(list.files(dirInerSig))))



############################################################
# Task 4
# Appropriately labels the data set with descriptive variable names. 
############################################################
measure <- bigtable[2:4]



############################################################
# Task 5
# From the data set in step 4, creates a second, independent
# tidy data set with the average of each variable for each
# activity and each subject.
############################################################
# create vector 9x subject
subject9 <- subject
for (i in 2:length(list.files(dirInerSig))) {
  subject9 <- rbind(subject9, subject)
}
# added column subject
measure2 <- data.frame(measure, subject=subject9)
rm(subject9)

# computing of average measures
signalsAvg <- data.table(measure2)
signalsAvg <- signalsAvg[,.("mean"=mean(mean),"sd"=mean(sd)), by = .(activity,subject)]
# print table
print(signalsAvg)
# save
write.table(signalsAvg, "signalsAvg.txt", row.name=FALSE)
