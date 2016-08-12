# Load some helper functions.
source("functions.R")

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

