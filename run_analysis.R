## Getting and Cleaning Data Course Project
## run_analysis.R
## 4 June, 2017
######################################################################
## Make sure that your working directory is the one that contains   ##
## the UCI HAR directory, or contains its zip file and is the       ##
## directory that you wish to use for its expansion *before*        ##
## starting this script!                                            ##
######################################################################

## 1. Check to make sure the necessary libraries are available and loaded.
## 2. Get and read data for Exploratory Data Analysis Course Project 2. 
## 3. Clean up the data.
## 4. Merge the data sets and extract as a subset only those columns
##    that contain the means and standard deviations for each measurement.
## 5. Create a "Tidy Data" dataset with avg. of each 
##    each mean and standard variation variable, for each activity, 
##    for each participant/observational subject.
## 6. Clean up column names to be descriptive of their contents.
## 7. Save two formats of tidyData table

######################    Part 1 - Libraries    ######################

# Check to see if the R packages needed by the script are installed on
# the computer, if not, install them.
listPackages <- c("data.table", "magrittr", "dplyr")
newPackages <- listPackages[!(listPackages %in% installed.packages()
    [,"Package"])]
if (length(newPackages)) {
    install.packages(newPackages)
}

# Load the libraries that the script will use.
library(data.table)       # fread and other data.table functions
library(magrittr)         # required for %>%
library(dplyr)            # required for select and other functions

#######################   Part 2 - Load Data   #######################

# Check to see if the data exists, download and/or unzip if this hasn't 
# already been done there.

if (!dir.exists("Test HAR Dataset")) {
    if (!file.exists("UCI HAR Dataset.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            , destfile = "UCI HAR Dataset.zip")
    }
    unzip("UCI HAR Dataset.zip")
}

########################  Read Label Files   #########################

features <- fread("./UCI HAR Dataset/features.txt"
                  , header = FALSE
                  , sep = " "
                  , na.strings = "NA"
                  , col.names = c("featureNumber", "featureName"))
save(features, file = "./UCI HAR Dataset/features.rda")

activities <- fread("./UCI HAR Dataset/activity_labels.txt"
                    , header = FALSE
                    , sep = " "
                    , na.strings = "NA"
                    , col.names = c("activityNumber", "activityName"))
save(activities, file = "./UCI HAR Dataset/activities.rda")

#######################   Read Tests Datasets   ######################

xTest <- fread("./UCI HAR Dataset/test/X_test.txt"
               , header = FALSE
               , sep = " " 
               , na.strings = "NA")
save(xTest, file = "./UCI HAR Dataset/test/xTest.rda")

yTest <- fread("./UCI HAR Dataset/test/y_test.txt"
               , header = FALSE           
               , sep = " "
               , na.strings = "NA"
               , col.names = "activityCodes")
save(yTest, file = "./UCI HAR Dataset/test/yTest.rda")

subjectTest <- fread("./UCI HAR Dataset/test/subject_test.txt"
                     , header = FALSE
                     , sep = " "
                     , na.strings = "NA"
                     , col.names = "subject")
save(subjectTest, file = "./UCI HAR Dataset/test/subjectTest.rda")


#####################   Read Training Datasets   #####################

xTrain <- fread("./UCI HAR Dataset/train/X_train.txt"
                , header = FALSE
                , sep = " " 
                , na.strings = "NA")
save(xTrain, file = "./UCI HAR Dataset/train/xTrain.rda")

yTrain <- fread("./UCI HAR Dataset/train/y_train.txt"
                , header = FALSE           
                , sep = " "
                , na.strings = "NA"
                , col.names = "activityCodes")
save(yTrain, file = "./UCI HAR Dataset/train/yTrain.rda")

subjectTrain <- fread("./UCI HAR Dataset/train/subject_train.txt"
                       , header = FALSE
                       , sep = " "
                       , na.strings = "NA"
                       , col.names = "subject")
save(subjectTrain, file = "./UCI HAR Dataset/train/subjectTrain.rda")

#####################   Part 3 - Cleanind Data   #####################

# Need activities in tidy, mixed case format.  Should be do-able in one 
# line, but I don't know how.
activities <- within(activities, activityName <- tolower(activityName))
activities <- within(activities, activityName <- gsub("_([a-z])"
    , "\\U\\1"
    , activityName
    , perl=TRUE))

# Activity *codes* are not tidy, replace them with names. 
# Probably a way to do this in one line, but beyond my skills.

yTest$activities <-  activities$activityName[match(yTest$activityCodes
                                             , activities$activityNumber)]
yTest[, activityCodes := NULL]
yTrain$activities <-  activities$activityName[match(yTrain$activityCodes
                                              , activities$activityNumber)]
yTrain[, activityCodes := NULL]

# Column number labels are not tidy, replace them with names.
# Names at this point are useful right now for auditability of data, 
# but not for the desired tidydata end product.  

colnames(xTest) <- features$featureName
colnames(xTrain) <- features$featureName

###################   Part 4 - Merge and Extract  ####################

# Tidyness requires all of the data to be in one table 

xTest[, subject := subjectTest$subject][, activity := yTest$activities]
xTrain[, subject := subjectTrain$subject][, activity := yTrain$activities]
unifiedData <- rbind2(xTest, xTrain)

##############   Part 5 - Reshape calculate averages   ###############

# The requested end product is an independent tidy data set with the average 
# of each mean and standard deviation variable for each activity and 
# each subject.

requiredData2 <- melt(requiredData, id.vars = c("activity", "subject"))
tidyData <- dcast.data.table(requiredData2, activity + subject ~ variable
    , id.var = c("activity", "subject")                         
    , fun.aggregate = mean)


#############   Part 6 - Expand and Tidy Column Names   ##############

# Many of the data columns are not required for the final product.  Those
# that are required are extracted and the resulting temporary "requiredData" 
# data.table can be reordered to place the future table keys first for easier 
# reading.

requiredColumns <- grep("[Mm]ean|std|subject|activity"
                        , colnames(unifiedData))
requiredData <- unifiedData[, requiredColumns, with = FALSE]
requiredData <- requiredData %>%  select(activity, subject, everything())

# The "features" of the original data are highly untidy and programmer
# unfriendly.  The following loop cleans them up, resulting in very
# long and unfriendly column names.  Any or all of the individual lines
# of code in the loop can be commented out to achieve the desired effect
# for the ultimate user of the script. *WARNING* Leaving the commas and 
# hypens in the names can trigger a bug in some versions of rStudio 
# with characters being inserted at the beginning and end of each name.
# 
# Highly modified from  H.G. Wade, Getting Cleaning Data Project(2014), 
# GitHub repository, 
# https://github.com/hglennrock/getting-cleaning-data-project/blob/master/run_analysis.R

colNames <- colnames(requiredData)
for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\(","", colNames[i])
    colNames[i] = gsub("\\)","", colNames[i])
    colNames[i] = gsub("-std","StdDev", colNames[i])
    colNames[i] = gsub("-mean","Mean", colNames[i])
    colNames[i] = gsub("^(t)","time", colNames[i])
    colNames[i] = gsub("^(f)","freq", colNames[i])
    colNames[i] = gsub("(acc)","Acc", colNames[i])
    colNames[i] = gsub("(jerk)","Jerk", colNames[i])
    colNames[i] = gsub("([Mm]ag)","Magnitude", colNames[i])
    colNames[i] = gsub("BodyBody", "Body", colNames[i])
    colNames[i] = gsub("(gravity)","Gravity", colNames[i])
    colNames[i] = gsub("anglet", "angleTime", colNames[i])
    colNames[i] = gsub(",|-", "", colNames[i])
    colNames[i] = paste("avg", toupper(substring(colNames[i], 1,1))
                        , substring(colNames[i], 2), sep = "")
    colNames[i] = gsub("avgActivity", "activity", colNames[i])
    colNames[i] = gsub("avgSubject", "subject", colNames[i])
}

# Tidied column names need to go back into tidyData table
colnames(tidyData) <- colNames

#################   Part 7 - Save tidyData dataset   #################

# Save the delivery product in two versions for user convenince

# can be read back in using the read.table function of the r utils package.
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)

# can be read back in using the load function of the r base package.
save(tidyData, file = "tidyData.rda")
