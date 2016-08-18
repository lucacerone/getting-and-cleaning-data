# Getting and Cleaning Data Course Project.

This is the code used to complete the Project for [John Hopkin's Getting and Cleaning Data course](https://www.coursera.org/learn/data-cleaning "John Hopkin's Getting and Cleaning Data") on Coursera.

To test the assignment you are supposed to clone the repository and run the script **run_analysis.R** 

Some helper functions are defined in the **functions.R** that is read at the beginning of run_analysis.R

Next the script make sure that all the required packages are available and the data are present. If not packages are installed
and data downloaded.

Once all the packages and data are available the scripts does the following:

- find the list of features to be used in the final dataset
- clean the feature names
- read the activity dictionary
- combine train dataset, the subject and the name of the relative activity
- select only the required columns applying the tidy names
- repeat the same for the test
- combine tidy train and tidy test in a dataset
- write the tidy dataset to disk (data/tidy_dataset.tsv)
