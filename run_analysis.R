
########################################################
#     INFORMATION OF PLATFORM CREATED AND TESTED ON    #
########################################################
# PLATFORM  : Windows 8.1, x64-Based Processor
# R Version : x64 3.1.2


##############################
#     CLEANUP ENVIRONMENT    #
##############################
# CAUTION!! Save your environment before running the script
rm (list=ls())


#####################################################
#     LOAD LIBRARIES AND FETCH WORKING DIRECTORY    #
#####################################################
library (dplyr)
workingDir = getwd()


################################
#     READ REFERENCE FILES     #
################################
# read the reference files ('labels' and 'variable names')
activity_labels <- read.table (paste(workingDir,"./UCI HAR Dataset/activity_labels.txt",sep="/"))
features <- read.table (paste(workingDir,"./UCI HAR Dataset/features.txt",sep="/"))


###########################
#     READ DATA FILES     #
###########################
# read the 'test' data files
x_test <- read.table (paste(workingDir,"./UCI HAR Dataset/test/X_test.txt",sep="/"))
y_test <- read.table (paste(workingDir,"./UCI HAR Dataset/test/y_test.txt",sep="/"))
subject_test <- read.table(paste(workingDir,"./UCI HAR Dataset/test/subject_test.txt",sep="/"))
# read the 'train' data files
x_train <- read.table (paste(workingDir,"./UCI HAR Dataset/train/X_train.txt",sep="/"))
y_train <- read.table (paste(workingDir,"./UCI HAR Dataset/train/y_train.txt",sep="/"))
subject_train <- read.table(paste(workingDir,"./UCI HAR Dataset/train/subject_train.txt",sep="/"))


##################################
#      NAME / RENAME COLUMNS     #
##################################
# rename columns in 'reference' files
names (activity_labels) <- c("activityId", "activityLabel")
names (features) <- c("featureId", "featureName")
# appropriateLY rename columns in 'test' data files
names (y_test) <- c("activityId")
names (subject_test) <- c("subjectId")
# appropriateLY rename columns in 'train' data files
names (y_train) <- c("activityId")
names (subject_train) <- c("subjectId")
# rename variables for x_test / x_train data drawing reference from 
# 'features.txt' file (utilizing the 'featureName' column)
names (x_test) <- features$featureName
names (x_train) <- features$featureName


################### -- I M P O R T A N T     N O T E -- ################
#     PUTTING OFF MERGING OF THE TEST AND TRAINING DATA SETS UNTIL     #
#  REDUCED DATA SETS ARE CREATED TO HAVE ONLY THE NECESSARY VARIABLES  #
########################################################################


#############################################
#     SELECT MEAN AND STD. DEV. COLUMNS     #
#############################################
# select 'mean' or 'standard devition' variableS
# from the 'x_test' and 'x_train' data frames
x_test_mean_std <- x_test[, grepl("mean[()]|std[()]", names(x_test))]
x_train_mean_std <- x_train[, grepl("mean[()]|std[()]", names(x_train))]


##########################################
#     BIND SUBJECT AND ACTIVITY DATA     #
##########################################
# add 'activityLabel' to 'y_test' to represent the 'activity names' against the
# activity numbers provided (using 'activity_labels.txt' data for transformation) 
y_test$activityLabel <- activity_labels$activityLabel[y_test$activityId]
# incorporate the 'activity' and 'subject' data to the 'test' data
# using data from 'subject_test.txt' and 'y_test.txt' files
x_test_subject_activity_mean_std <- cbind (activityLabel=y_test$activityLabel,
                                           subject_test,
                                           x_test_mean_std)

# add 'activityLabel' to 'y_train' to represent the 'activity names' against the
# activity numbers provided (using 'activity_labels.txt' data for transformation)
y_train$activityLabel <- activity_labels$activityLabel[y_train$activityId]
# incorporate the 'activity' and 'subject' data to the 'train' data
# using data from 'subject_train.txt' and 'y_train.txt' files
x_train_subject_activity_mean_std <- cbind (activityLabel=y_train$activityLabel,
                                            subject_train,
                                            x_train_mean_std)


#################################################
#     MERGE THE TEST AND TRAINING DATA SETS     #
#################################################
# the test and train data sets now contains variables
# that we are interested in (mean, stddev and activity labels)
# since these are independent data having the same variables,
# the merge is really a concatenation of one set to another
UCI_HAR <- rbind (x_test_subject_activity_mean_std,
                  x_train_subject_activity_mean_std)


##########################################################
#     LABEL DATA SET WITH DESCRIPTIVE VARIABLE NAMES     #
##########################################################
UCI_HAR <- rename (UCI_HAR, 
                         subject_id = `subjectId`,                  
                         activity_label = `activityLabel`,
                         Mean_Time_Body_Acc_X_axis = `tBodyAcc-mean()-X`,
                         Mean_Time_Body_Acc_Y_axis = `tBodyAcc-mean()-Y`,
                         Mean_Time_Body_Acc_Z_axis = `tBodyAcc-mean()-Z`,
                         StDev_Time_Body_Acc_X_axis = `tBodyAcc-std()-X`,
                         StDev_Time_Body_Acc_Y_axis = `tBodyAcc-std()-Y`,
                         StDev_Time_Body_Acc_Z_axis = `tBodyAcc-std()-Z`,
                         Mean_Time_Gravity_Acc_X_axis = `tGravityAcc-mean()-X`,
                         Mean_Time_Gravity_Acc_Y_axis = `tGravityAcc-mean()-Y`,
                         Mean_Time_Gravity_Acc_Z_axis = `tGravityAcc-mean()-Z`,
                         StDev_Time_Gravity_Acc_X_axis = `tGravityAcc-std()-X`,
                         StDev_Time_Gravity_Acc_Y_axis = `tGravityAcc-std()-Y`,
                         StDev_Time_Gravity_Acc_Z_axis = `tGravityAcc-std()-Z`,
                         Mean_Time_Body_Acc_Jerk_X_axis = `tBodyAccJerk-mean()-X`,
                         Mean_Time_Body_Acc_Jerk_Y_axis = `tBodyAccJerk-mean()-Y`,
                         Mean_Time_Body_Acc_Jerk_Z_axis = `tBodyAccJerk-mean()-Z`,
                         StDev_Time_Body_Acc_Jerk_X_axis = `tBodyAccJerk-std()-X`,
                         StDev_Time_Body_Acc_Jerk_Y_axis = `tBodyAccJerk-std()-Y`,
                         StDev_Time_Body_Acc_Jerk_Z_axis = `tBodyAccJerk-std()-Z`,
                         Mean_Time_Body_AngVelocity_X_axis = `tBodyGyro-mean()-X`,
                         Mean_Time_Body_AngVelocity_Y_axis = `tBodyGyro-mean()-Y`,
                         Mean_Time_Body_AngVelocity_Z_axis = `tBodyGyro-mean()-Z`,
                         StDev_Time_Body_AngVelocity_X_axis = `tBodyGyro-std()-X`,
                         StDev_Time_Body_AngVelocity_Y_axis = `tBodyGyro-std()-Y`,
                         StDev_Time_Body_AngVelocity_Z_axis = `tBodyGyro-std()-Z`,
                         Mean_Time_Body_AngVelocity_Jerk_X_axis = `tBodyGyroJerk-mean()-X`,
                         Mean_Time_Body_AngVelocity_Jerk_Y_axis = `tBodyGyroJerk-mean()-Y`,
                         Mean_Time_Body_AngVelocity_Jerk_Z_axis = `tBodyGyroJerk-mean()-Z`,
                         StDev_Time_Body_AngVelocity_Jerk_X_axis = `tBodyGyroJerk-std()-X`,
                         StDev_Time_Body_AngVelocity_Jerk_Y_axis = `tBodyGyroJerk-std()-Y`,
                         StDev_Time_Body_AngVelocity_Jerk_Z_axis = `tBodyGyroJerk-std()-Z`,
                         Mean_Time_Body_Acc_Magnitude = `tBodyAccMag-mean()`,
                         StDev_Time_Body_Acc_Magnitude = `tBodyAccMag-std()`,
                         Mean_Time_Gravity_Acc_Magnitude = `tGravityAccMag-mean()`,
                         StDev_Time_Gravity_Acc_Magnitude = `tGravityAccMag-std()`,
                         Mean_Time_Body_Acc_Jerk_Magnitude = `tBodyAccJerkMag-mean()`,
                         StDev_Time_Body_Acc_Jerk_Magnitude = `tBodyAccJerkMag-std()`,
                         Mean_Time_Body_AngVelocity_Magnitude = `tBodyGyroMag-mean()`,
                         StDev_Time_Body_AngVelocity_Magnitude = `tBodyGyroMag-std()`,
                         Mean_Time_Body_AngVelocity_Jerk_Magnitude = `tBodyGyroJerkMag-mean()`,
                         StDev_Time_Body_AngVelocity_Jerk_Magnitude = `tBodyGyroJerkMag-std()`,
                         Mean_Freq_Body_Acc_X_axis = `fBodyAcc-mean()-X`,
                         Mean_Freq_Body_Acc_Y_axis = `fBodyAcc-mean()-Y`,
                         Mean_Freq_Body_Acc_Z_axis = `fBodyAcc-mean()-Z`,
                         StDev_Freq_Body_Acc_X_axis = `fBodyAcc-std()-X`,
                         StDev_Freq_Body_Acc_Y_axis = `fBodyAcc-std()-Y`,
                         StDev_Freq_Body_Acc_Z_axis = `fBodyAcc-std()-Z`,
                         Mean_Freq_Body_Acc_Jerk_X_axis = `fBodyAccJerk-mean()-X`,
                         Mean_Freq_Body_Acc_Jerk_Y_axis = `fBodyAccJerk-mean()-Y`,
                         Mean_Freq_Body_Acc_Jerk_Z_axis = `fBodyAccJerk-mean()-Z`,
                         StDev_Freq_Body_Acc_Jerk_X_axis = `fBodyAccJerk-std()-X`,
                         StDev_Freq_Body_Acc_Jerk_Y_axis = `fBodyAccJerk-std()-Y`,
                         StDev_Freq_Body_Acc_Jerk_Z_axis = `fBodyAccJerk-std()-Z`,
                         Mean_Freq_Body_AngVelocity_X_axis = `fBodyGyro-mean()-X`,
                         Mean_Freq_Body_AngVelocity_Y_axis = `fBodyGyro-mean()-Y`,
                         Mean_Freq_Body_AngVelocity_Z_axis = `fBodyGyro-mean()-Z`,
                         StDev_Freq_Body_AngVelocity_X_axis = `fBodyGyro-std()-X`,
                         StDev_Freq_Body_AngVelocity_Y_axis = `fBodyGyro-std()-Y`,
                         StDev_Freq_Body_AngVelocity_Z_axis = `fBodyGyro-std()-Z`,
                         Mean_Freq_Body_Acc_Magnitude = `fBodyAccMag-mean()`,
                         StDev_Freq_Body_Acc_Magnitude = `fBodyAccMag-std()`,
                         Mean_Freq_Body_Acc_Jerk_Magnitude = `fBodyBodyAccJerkMag-mean()`,
                         StDev_Freq_Body_Acc_Jerk_Magnitude = `fBodyBodyAccJerkMag-std()`,
                         Mean_Freq_Body_AngVelocity_Magnitude = `fBodyBodyGyroMag-mean()`,
                         StDev_Freq_Body_AngVelocity_Magnitude = `fBodyBodyGyroMag-std()`,
                         Mean_Freq_Body_Body_AngVelocity_Magnitude = `fBodyBodyGyroJerkMag-mean()`,
                         StDev_Freq_Body_Body_AngVelocity_Magnitude = `fBodyBodyGyroJerkMag-std()`)


###############################################################
#     CREATE DATA SET WITH THE 'AVERAGE' OF EACH VARIABLE     #
#           FOR EACH 'ACTIVITY' AND EACH 'SUBJECT'            #
###############################################################
UCI_HAR_grouped_avg = UCI_HAR %>%
        group_by (subject_id, activity_label) %>%
        summarize (
                Mean_Time_Body_Acc_X_axis = mean (Mean_Time_Body_Acc_X_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Y_axis = mean (Mean_Time_Body_Acc_Y_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Z_axis = mean (Mean_Time_Body_Acc_Z_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_X_axis = mean (StDev_Time_Body_Acc_X_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_Y_axis = mean (StDev_Time_Body_Acc_Y_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_Z_axis = mean (StDev_Time_Body_Acc_Z_axis, na.rm = TRUE),
                Mean_Time_Gravity_Acc_X_axis = mean (Mean_Time_Gravity_Acc_X_axis, na.rm = TRUE),
                Mean_Time_Gravity_Acc_Y_axis = mean (Mean_Time_Gravity_Acc_Y_axis, na.rm = TRUE),
                Mean_Time_Gravity_Acc_Z_axis = mean (Mean_Time_Gravity_Acc_Z_axis, na.rm = TRUE),
                StDev_Time_Gravity_Acc_X_axis = mean (StDev_Time_Gravity_Acc_X_axis, na.rm = TRUE),
                StDev_Time_Gravity_Acc_Y_axis = mean (StDev_Time_Gravity_Acc_Y_axis, na.rm = TRUE),
                StDev_Time_Gravity_Acc_Z_axis = mean (StDev_Time_Gravity_Acc_Z_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Jerk_X_axis = mean (Mean_Time_Body_Acc_Jerk_X_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Jerk_Y_axis = mean (Mean_Time_Body_Acc_Jerk_Y_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Jerk_Z_axis = mean (Mean_Time_Body_Acc_Jerk_Z_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_Jerk_X_axis = mean (StDev_Time_Body_Acc_Jerk_X_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_Jerk_Y_axis = mean (StDev_Time_Body_Acc_Jerk_Y_axis, na.rm = TRUE),
                StDev_Time_Body_Acc_Jerk_Z_axis = mean (StDev_Time_Body_Acc_Jerk_Z_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_X_axis = mean (Mean_Time_Body_AngVelocity_X_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Y_axis = mean (Mean_Time_Body_AngVelocity_Y_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Z_axis = mean (Mean_Time_Body_AngVelocity_Z_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_X_axis = mean (StDev_Time_Body_AngVelocity_X_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Y_axis = mean (StDev_Time_Body_AngVelocity_Y_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Z_axis = mean (StDev_Time_Body_AngVelocity_Z_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Jerk_X_axis = mean (Mean_Time_Body_AngVelocity_Jerk_X_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Jerk_Y_axis = mean (Mean_Time_Body_AngVelocity_Jerk_Y_axis, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Jerk_Z_axis = mean (Mean_Time_Body_AngVelocity_Jerk_Z_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Jerk_X_axis = mean (StDev_Time_Body_AngVelocity_Jerk_X_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Jerk_Y_axis = mean (StDev_Time_Body_AngVelocity_Jerk_Y_axis, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Jerk_Z_axis = mean (StDev_Time_Body_AngVelocity_Jerk_Z_axis, na.rm = TRUE),
                Mean_Time_Body_Acc_Magnitude = mean (Mean_Time_Body_Acc_Magnitude, na.rm = TRUE),
                StDev_Time_Body_Acc_Magnitude = mean (StDev_Time_Body_Acc_Magnitude, na.rm = TRUE),
                Mean_Time_Gravity_Acc_Magnitude = mean (Mean_Time_Gravity_Acc_Magnitude, na.rm = TRUE),
                StDev_Time_Gravity_Acc_Magnitude = mean (StDev_Time_Gravity_Acc_Magnitude, na.rm = TRUE),
                Mean_Time_Body_Acc_Jerk_Magnitude = mean (Mean_Time_Body_Acc_Jerk_Magnitude, na.rm = TRUE),
                StDev_Time_Body_Acc_Jerk_Magnitude = mean (StDev_Time_Body_Acc_Jerk_Magnitude, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Magnitude = mean (Mean_Time_Body_AngVelocity_Magnitude, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Magnitude = mean (StDev_Time_Body_AngVelocity_Magnitude, na.rm = TRUE),
                Mean_Time_Body_AngVelocity_Jerk_Magnitude = mean (Mean_Time_Body_AngVelocity_Jerk_Magnitude, na.rm = TRUE),
                StDev_Time_Body_AngVelocity_Jerk_Magnitude = mean (StDev_Time_Body_AngVelocity_Jerk_Magnitude, na.rm = TRUE),
                Mean_Freq_Body_Acc_X_axis = mean (Mean_Freq_Body_Acc_X_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Y_axis = mean (Mean_Freq_Body_Acc_Y_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Z_axis = mean (Mean_Freq_Body_Acc_Z_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_X_axis = mean (StDev_Freq_Body_Acc_X_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_Y_axis = mean (StDev_Freq_Body_Acc_Y_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_Z_axis = mean (StDev_Freq_Body_Acc_Z_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Jerk_X_axis = mean (Mean_Freq_Body_Acc_Jerk_X_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Jerk_Y_axis = mean (Mean_Freq_Body_Acc_Jerk_Y_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Jerk_Z_axis = mean (Mean_Freq_Body_Acc_Jerk_Z_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_Jerk_X_axis = mean (StDev_Freq_Body_Acc_Jerk_X_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_Jerk_Y_axis = mean (StDev_Freq_Body_Acc_Jerk_Y_axis, na.rm = TRUE),
                StDev_Freq_Body_Acc_Jerk_Z_axis = mean (StDev_Freq_Body_Acc_Jerk_Z_axis, na.rm = TRUE),
                Mean_Freq_Body_AngVelocity_X_axis = mean (Mean_Freq_Body_AngVelocity_X_axis, na.rm = TRUE),
                Mean_Freq_Body_AngVelocity_Y_axis = mean (Mean_Freq_Body_AngVelocity_Y_axis, na.rm = TRUE),
                Mean_Freq_Body_AngVelocity_Z_axis = mean (Mean_Freq_Body_AngVelocity_Z_axis, na.rm = TRUE),
                StDev_Freq_Body_AngVelocity_X_axis = mean (StDev_Freq_Body_AngVelocity_X_axis, na.rm = TRUE),
                StDev_Freq_Body_AngVelocity_Y_axis = mean (StDev_Freq_Body_AngVelocity_Y_axis, na.rm = TRUE),
                StDev_Freq_Body_AngVelocity_Z_axis = mean (StDev_Freq_Body_AngVelocity_Z_axis, na.rm = TRUE),
                Mean_Freq_Body_Acc_Magnitude = mean (Mean_Freq_Body_Acc_Magnitude, na.rm = TRUE),
                StDev_Freq_Body_Acc_Magnitude = mean (StDev_Freq_Body_Acc_Magnitude, na.rm = TRUE),
                Mean_Freq_Body_Acc_Jerk_Magnitude = mean (Mean_Freq_Body_Acc_Jerk_Magnitude, na.rm = TRUE),
                StDev_Freq_Body_Acc_Jerk_Magnitude = mean (StDev_Freq_Body_Acc_Jerk_Magnitude, na.rm = TRUE),
                Mean_Freq_Body_AngVelocity_Magnitude = mean (Mean_Freq_Body_AngVelocity_Magnitude, na.rm = TRUE),
                StDev_Freq_Body_AngVelocity_Magnitude = mean (StDev_Freq_Body_AngVelocity_Magnitude, na.rm = TRUE),
                Mean_Freq_Body_Body_AngVelocity_Magnitude = mean (Mean_Freq_Body_Body_AngVelocity_Magnitude, na.rm = TRUE),
                StDev_Freq_Body_Body_AngVelocity_Magnitude = mean (StDev_Freq_Body_Body_AngVelocity_Magnitude, na.rm = TRUE)) %>%
        as.data.frame

###############################################################
#     WRITE RESULTS TO 'UCI_HAR.txt' (exclude 'ROW NAMES')    #
#    To Read, use: read.table ("./UCI_HAR.txt", header = T)   #
###############################################################
write.table (UCI_HAR_grouped_avg,
             file = paste(workingDir, "UCI_HAR.txt", sep="/"),
             row.names = FALSE)

##############################
#     CLEANUP ENVIRONMENT    #
##############################
# Returns a clean slate after running the script
rm (list=ls())
