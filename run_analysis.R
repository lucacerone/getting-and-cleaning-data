# Load some helper functions.
source("functions.R")

# Import the required packages (eventually installing them if not available)
# Note: al libraries should be written here!
ensure_package_("dplyr")
ensure_package_("readr")


# Ensure that the directory to store the data exists:
ensure_directory_exists("data")

# First of all checks whether data are present, if not download them.
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataset_dest <- "data/dataset_raw.zip"

# Depending on the platform if you have issues downloading the data
# try to change the method (see download.file help)
download_data(dataset_url, dataset_dest, method = "libcurl")

# Make sure the dataset is extracted:
if (!file.exists("data/UCI HAR Dataset/")) unzip("data/dataset_raw.zip", exdir = "data")

# extract indexes of required features.
features <- import_features()
idx_mean <- grepl(pattern = "mean()", features, fixed = T)
idx_std <- grepl(pattern="std()", features, fixed = T)
idx_selected <- idx_mean | idx_std
features_selected <- c("Subject", "Activity",features[idx_selected])
idx_selected <- c(TRUE,  TRUE, idx_selected)

features_selected <- gsub("^t","timeDomain_",features_selected)
features_selected <- gsub("^f","frequencyDomain_",features_selected)
features_selected <- gsub("-mean()","_mean", features_selected, fixed = T)
features_selected <- gsub("-std()","_std", features_selected, fixed = T)
features_selected <- gsub("-","_", features_selected, fixed = T)
features_selected <- gsub("Acc","Acceleration", features_selected)
features_selected <- gsub("Gyro","Gyroscope", features_selected)
features_selected <- gsub("Mag","Magnitude", features_selected)
writeLines(features_selected,"data/tidy_features.txt")


activity_labels <- read_delim("data/UCI HAR Dataset/activity_labels.txt", delim = " ", col_names = c("code","activity"))

# Import train and get only selected columns
train_file <- "data/UCI HAR Dataset/train/X_train.txt"
train <- read_fwf(train_file, fwf_empty(train_file, col_names=NULL))
subject_train <- read_delim("data/UCI HAR Dataset/train/subject_train.txt", delim="\t", col_names = FALSE)
activities_train <- read_delim("data/UCI HAR Dataset/train/y_train.txt", delim = " ", col_names = "code")
activities_train <- activity_labels[activities_train$code,"activity"]

tidy_train <- cbind(subject_train, activities_train, train)
tidy_train <- tidy_train[,idx_selected]
colnames(tidy_train) <- features_selected

# Import test and get only selected columns
test_file <- "data/UCI HAR Dataset/test/X_test.txt"
test <- read_fwf(test_file, fwf_empty(test_file, col_names=NULL))
subject_test <- read_delim("data/UCI HAR Dataset/test/subject_test.txt", delim="\t", col_names = FALSE)
activities_test <- read_delim("data/UCI HAR Dataset/test/y_test.txt", delim = " ", col_names = "code")
activities_test <- activity_labels[activities_test$code,"activity"]

tidy_test <- cbind(subject_test, activities_test, test)
tidy_test <- tidy_test[,idx_selected]
colnames(tidy_test) <- features_selected

# Combine tidy train and test:
dataset <- rbind(tidy_train,tidy_test)
write.table(dataset, file = "data/tidy_dataset.txt",col.names = TRUE, row.names = FALSE)

aggdata <- dataset %>% group_by(Subject,Activity) %>% summarise_each( funs(mean) ) %>% arrange(Subject,Activity)
aggdata
write.table(dataset, file = "data/aggregated_dataset.txt",col.names = TRUE, row.names = FALSE)
