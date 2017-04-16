run_analysis <- function(fileurl) {
  
  #Load relevant libraries. Script may not work properly 
  #if you have not installed and loaded plyr, dplyr packages 
  
  library(plyr)
  
  library(dplyr)
  
  #Downloading and unzipping file from source page
  
  filename <- "data.zip"
  
  if (!file.exists(filename)){
    download.file(fileurl, filename, method="curl")
  }  
  
  if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
  }
  
  #Read train, test, features datasets; 
  #initialise variable split_features2 and store formatted feature/column names 
  
  split_features2 <- list()
  
  train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  
  test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  features <- readLines("./UCI HAR Dataset/features.txt")
  
  split_features <- strsplit(features, " ")
  
  activity <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  for(i in 1:561) 
  {
    split_features2[i] <- split_features[[i]][[2]]
  }
  
  #Replace old column names with appropriate feature names
  
  names(train) <- split_features2
  
  names(test) <- split_features2

  #Merge train and test datasets
  
  final <- rbind(train, test)
  
  #read activity labels for train and test datasets and merge the two 
  
  activity_final <- rbind(read.table("./UCI HAR Dataset/train/y_train.txt"), 
                          read.table("./UCI HAR Dataset/test/y_test.txt"))
  
  subject_final <- rbind(read.table("./UCI HAR Dataset/train/subject_train.txt"), 
                         read.table("./UCI HAR Dataset/test/subject_test.txt"))
  
  names(activity_final) <- "activity"
  
  names(subject_final) <- "subject"
  
  #Select mean and standard deviation data and assign activity and subject labels 
  
  final <- final[grep("mean[()]|std[()]", names(test))]
  
  final <- cbind(final, activity_final)
  
  final <- cbind(final, subject_final)
  
  final$activity <- factor(final$activity)
  
  final$activity <- factor(final$activity,labels=as.character(activity$V2))
  
  final$subject <- factor(final$subject)
  
  #Substituting existing column names with decriptive variable names 
  
  names(final)<-gsub("^t", "Time",names(final))
  
  names(final)<-gsub("^f", "frequency", names(final))
  
  names(final)<-gsub("Acc", "Accelerometer", names(final))
  
  names(final)<-gsub("Gyro", "Gyroscope", names(final))
  
  names(final)<-gsub("Mag", "Magnitude", names(final))
  
  names(final)<-gsub("BodyBody", "Body", names(final))
  
  #Creating an independent dataset with average of each variable
  #according to subject
  
  final <- final %>% group_by(activity, subject) %>% summarise_each(funs(mean(., na.rm=TRUE)))
  
}
