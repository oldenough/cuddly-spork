Getting and Cleaning Data Course Project
================
Janet Kino
June 2017

### Table of Contents

1.  [The Task](#task)
    1.  [Instructions](#instructions)
    2.  [The Deliverables](#deliverables)
2.  [The Data](#data)
3.  [My Environment](#environment)
4.  [Auditability](#auditability)
5.  [Naming Conventions](#naming)
6.  [Clean Up](#cleanup)
    1.  [Global Environment](#global)
    2.  [Files on Disk](#disk)

<a name="task"></a>

### The Task

<a name="instructions"></a>

#### Instructions

<i>As provided by the course instructors.</i>

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1.  a tidy data set as described below,
2.  a link to a Github repository with your script for performing the analysis, and,
3.  a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site from where the data was obtained: [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data for the project: [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

You should create one R script called run\_analysis.R that does the following.

-   Merges the training and the train sets to create one data set.
-   Extracts only the measurements on the mean and standard deviation for each measurement.
-   Uses descriptive activity names to name the activities in the data set
-   Appropriately labels the data set with descriptive variable names.
-   From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

<a name="deliverables"></a>

#### The Deliverables

This project calls for the delivery of four files.

-   One is an r script, [run\_analysis.R](run_analysis.R) which will take the user through the process of creating the required end-result dataset: tidyData.
    -   The script is heavily commented to make what is being done as clear as possible.
    -   It does, in some environments create a warning about being unable to optimize the call to the mean() function. This may be a bug in the tidy.data package and, in any case, is spurious as there is no missing data (no NA's or NAN's in the data) so the warning is unnecessary.
    -   The column names provided for the tidyData data set, when fully tidied up, can be very long and cumbersome to work with. Section 6 of the script can be modified by commenting out lines, to shorten up some of the names if desired. I have noticed that if you do not remove the comments and hyphens, that rStudio appears to include a back accent character at the start and end of all of the column names and that shows as a small red dot on the screen. This can be seen in the column names of the "unifiedData$'variable name'" format. This is not an artifact, and must be included in the variable name in order to match. It disappears when the commas and hyphens are removed from the names.
    -   Since there are several possible end results that could satisfy the requirements for the tidyData dataset, I consulted with a engineer that often works with this type of data and he indicated that he would prefer to work with a "wide" form, which is what I have delivered. A tall version of the data, but without the requested mean calculations can be seen in the requiredData2 tibble which can be viewed as a sort of comparison in forms.
-   One is a tidy data set with the average of each variable for each activity and each subject. This is provided by the run\_analysis.R script and also supplied in two formats.
    -   tidyData.rda which can be read with the load() function and which will provide a tibble.
    -   tidyData.txt which can be read with the read.table() function and which will provide a dataframe.
-   One is this README.md which explains the background for the project and its data, along with information explaining my approach and why I made some of the decisions that I did along the way. It also, at the bottom, gives some code that could be useful in cleaning up your disk and environment after you are done running the script.
-   One is the [CodeBook.md](CodeBook.md) which contains further, more detailed, information about the data, files, datasets, vectors, and labels used in the project.

<a name="data"></a>

### The Data - Raw or otherwise

Information on the raw data itself and its sources can be found in the [Getting and Cleaning Data Project Codebook](CodeBook.md). Also to be found in the codebook is information about the datasets that the script creates in the process of getting to the final tidyData product, and several tables that may help understand the various variables (called features by the original experimenters).

The "features\_info.txt" and "README.txt" files provided as part of the zipped UCI HAR Dataset are also very important to understanding the data and contain additional information about the authors of the original data and citation information. They should be read along with the files that are the deliverables for this project.

<a name="environment"></a>

### My Environment

-   The run\_analysis.R script was created using 64-bit versions of
    -   rStudio version 1.0.143,
    -   r version 3.4.0(Patched 05-27-2017),
    -   MS Windows 10 Pro version 1703.
-   The working directory should be set to the directory that the run\_analysis.R script is placed and that you either have, or wish to have, the raw data placed and its various directories created in.

<a name="auditability"></a>

### Auditability

I have attempted to make my efforts for this project as auditable as possible. To that end, the run\_analysis.R script is very well (overly?) commented and many of the data sets have been created and used for a single purpose so that the results of each step can be more easily checked. Various information has also been included to facilitate cross-referencing of data.

<a name="naming"></a>

### Naming Conventions

I am new to programming and, as such, am fairly flexible in how I go about naming variables, etc.. I have read several style sheets and looked at various samples of r coding, both from the instructors of the courses and on the web. I also found [State of Naming Conventions in R](https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) which, while being slightly dated at this point still seems to sum up the matter quite well. In r, there is no widely agreed on style for naming. Whatever you decide on doing, be consistent. To that end, in this project I have used what is called mixed Camel Case. This is where there is - no separation between the words used, - the first letter of the first work is in lower case and, - the first letter of each following word in the name is in upper case. - examples: requiredData and subjectTrain

<a name="cleanup"></a>

### Clean Up

<a name="global"></a>

#### Global Environment

Any or all of the following code may be run to clean up the global environment after the script has been run. The only dataset left in memory at that point will be the tidyData tibble which is the ultimate product of the script and the desired end-product for the exercise.

``` r
rm(activities)
rm(colNames)
rm(features)
rm(listPackages)
rm(newPackages)
rm(requiredColumns)
rm(requiredData)
rm(requiredData2)
rm(subjectTest)
rm(subjectTrain)
rm(unifiedData)
rm(xtrain)
rm(xTrain)
rm(ytrain)
rm(yTrain)
```

<a name="disk"></a>

#### Files on disk

Any or all of the following can be run to remove the work files created by the run\_analysis.R script. They are coded assuming that your working directory is still the one with the script in it and that you unzipped the UCI HAR Dataset.zip

``` r
file.remove("unifiedData.rda")
file.remove("./UCI HAR Dataset/activities.rda")
file.remove("./UCI HAR Dataset/features.rda")
file.remove("./UCI HAR Dataset/test/subjectTest.rda")
file.remove("./UCI HAR Dataset/test/xTest.rda")
file.remove("./UCI HAR Dataset/test/yTest.rda")
file.remove("./UCI HAR Dataset/train/subjectTrain.rda")
file.remove("./UCI HAR Dataset/train/xTrain.rda")
file.remove("./UCI HAR Dataset/train/yTrain.rda")
```
