The data used in the run_analysis script has been downloaded from the
link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

It contains data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone

There are a total of 561 features divided into 6 activity categories:
  1. Walking
  2. Walking_Upstairs
  3. Walking_Downstairs
  4. Sitting
  5. Standing
  6. Laying

The run_analysis.R script cleans this data to output the average values for each of the above six categories 
for features providing mean and standard deviation data

The variables used in run_analysis.R have been listed below along with their functions (in order of appearance):
  1. filename: assigns a filename for the data set to be downloaded
  2. split_features2: stores formatted feature names extracted from features.txt file
  3. train: stores data from X_train.txt file
  4. test: stores data from X_test.txt file 
  5. features: Reads features from features.txt file
  6. split_features: stores split list of feature names
  7. final: stores merged data from train and test files
  8. activity_final: stores activity category labels for final data 
  9. subject_final: stores subject labels for final data

The following transformations have been carried out on the data set
  1. Merging of the train and test data using rbind
  2. Formatting feature names to split feature number and feature name using for loop
  3. Selecting only mean and standard deviation features using grep
  4. Formatting feature names with descriptive variable names using gsub 
  5. Calculating the mean of feature values accoring to activity and subject labels and storing in final variable
  6. Using write.table function to output tidy data in text file
  
