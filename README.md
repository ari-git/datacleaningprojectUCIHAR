# Data Cleaning Project for the Coursera "Getting and Cleaning Data" course
## The dataset used is the [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

### Notes on what the run_analysis.R script performs
1. Cleans up the environemnt (so be careful to save your environment before you run the script!)
2. Loads libraries and obtains the *working directory*. Assumption is the **UCI HAR Dataset** directory would be present in the *working directory*
3. Reads the data from the appropriate directories/files
        * Reference data
        * Test data and
        * Training data
4. Names/renames the columns (aka variables) using the *Reference data*

        **NOTE:** Merging the Test and Train datasets have been put off until reduced datasets containing only the variables of interest are created

5. Select the variables of interest (*all* computed mean() and stdev()) from the *test* and *train* datasets (we still have separate datasets for *test* and *train*)
6. Enhace the dataset obtained above with the 'subject' and 'activity' information from the *y_* and *subject_* files
        * for this step, activity numbers obtained from the 'y_' files have been reinterpreted utilizing the information obtained from the 'activitylabels.txt' file (a new column was added to the 'y' data)
7. Merge the *test* and *train* datasets. We now get a dataset with rows equal to the sum of the number of rows in *x_test* and *x_train*. The resulting dataset has most *column names* obtained from the the *reference.txt* file
8. Variables of the dataset are labeled with *descriptive* variable names by interpreting the *column names* obtained from the the *reference.txt* file
9. A new dataset is created by computing the *average* of *all* variables by groups of
        * the subject (which remains a numeric identifier)
        * then by the activity label (6 types, obtained from the _activitylabels.txt_ file)

        **NOTE:** This is the final tidy dataset

10. The data frame (containing the final data set) is written into the *UCI_HAR.txt* file
11. The environment is tidyed up post the script activities were performed
