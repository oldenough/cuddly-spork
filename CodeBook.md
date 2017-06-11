Getting and Cleaning Data Project Codebook
================
Janet Kino
9 June, 2017

1.  The run\_analysis.R script, provided along with this file, uses or creates the variables, files and data described in this document.
2.  The script was created using 64-bit versions of rStudio version 1.0.143, r version 3.4.0(Patched 05-27-2017), on a PC running MS Windows 10 Pro version 1703.

Table of Contents
-----------------

1.  [The Raw Data](#raw)
    1.  [Background](#background)
    2.  [Data Files Used](#dataFiles)
2.  [Additional Vectors and Datasets](#additionalVectors)
3.  [Column Labels/Names](#columnNames)
    1.  [tidyData Dataset](#tidyData)
    2.  [Original Names and Locations](#original)

<a name="raw"></a>

The Raw Data
------------

<a name="background"></a>

### Background

The original data for the study is stored on the UCI Machine Learning Repository web site. [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) The project's web page include the following information.

-   Data Set Characteristics: Multivariate, Time-Series
-   Number of Instances: 10299
-   Number of Attributes: 561
-   Date Donated: 2012-12-10
-   Missing Values?: None

However the actual data files were provided by the course instructors as the [UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and I have not attempted to compare those files to the original files on the UCI web site.

Finally, there are is an [updated version](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions) of the data also stored on the UCI Machine Learning site.

<a name="dataFiles"></a>

### Data Files Used

The zip file mentioned above, when un-zipped, contains the following files and directory structure. These files were used in the preparation of the final product of this project: the tidyData table.

Each of the txt files that contains data (as opposed to prose descriptions) is read into the global environment as a tibble (data.table and data.frame) and saved to disk as their respective "file names.rda" in the directory that the .txt is located in. The resulting dimensions of the table are listed below.

-   /UCI HAR Dataset/README.txt: Contains the original authors' information about their experiment, methods and datasets. <b>THIS IS A MUST-READ</b>
-   /UCI HAR Dataset/features\_info.txt: Information about the variables used for the features vector. In other words, an explanation of the column labels and what they mean. <b>THIS TOO IS A MUST-READ</b>
-   /UCI HAR Dataset/features.txt: List of all features/column labels.
    -   dim(features): [1] 561 2
-   /UCI HAR Dataset/activity\_labels.txt: Links the numerical activity codes labels with their text names.
    -   dim(activities): [1] 6 2
-   /UCI HAR Dataset/train/X\_train.txt: Sixty percent of the observations were designated by the authors of the original investigation for training purposes. Other than that, there is no difference between the X\_train.txt and X\_test.txt sets. Neither of these files contain an indication of who the subject was, and only a code number for the activity. These "lacks" are dealt with in the accompanying script.
    -   dim(xTrain): [1] 7352 563
-   /UCI HAR Dataset/train/y\_train.txt: The activity that each row in X\_train.txt is observing. Must be concatenated to the xTrain data.
    -   dim(yTrain): [1] 7352 1
-   /UCI HAR Dataset/test/X\_test.txt: Forty percent of the observations were designated by the authors of the original investigation for testing purposes. Other than that, there is no difference between the X\_train.txt and X\_test.txt sets. Neither of these files contain an indication of who the subject was, and only a code number for the activity. These "lacks" are dealt with in the accompanying script.
    -   dim(xTest): [1] 2947 563.
-   /UCI HAR Dataset/test/y\_test.txt: The activity that each row in X\_test.txt is observing. Must be concatenated to the xTest data.
    -   dim(yTrain): [1] 2947 1
-   /UCI HAR Dataset/train/subject\_train.txt: Each row identifies the subject who performed the activity for each sample in X\_test.txt. Its range is from 1 to 30.
    -   dim(subjectTrain): [1] 7352 1
-   /UCI HAR Dataset/test/subject\_test.txt: Each row identifies the subject who performed the activity for each sample in X\_train.txt. Its range is from 1 to 30.
    -   dim(subjectTest): [1] 2947 1

The following files are also available for the train and test data, however they are <b>not used</b> in the creation of the tidyData data table.

-   /train/Inertial Signals/total\_acc\_x\_train.txt: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the total\_acc\_x\_train.txt' and 'total\_acc\_z\_train.txt files for the Y and Z axis.
-   /train/Inertial Signals/body\_acc\_x\_train.txt: The body acceleration signal obtained by subtracting the gravity from the total acceleration.
-   /train/Inertial Signals/body\_gyro\_x\_train.txt: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.

<a name="additionalVectors"></a>

Additional vectors and data sets created by the run\_analysis.R script
----------------------------------------------------------------------

-   colNames: a character vector of 88 items created from the 88 column names/labels in the requiredData tibble. This is used for cleaning up the formatting of the names, after which they are used as the column names in the tidyData tibble.
-   listPackages: vector containing the names of the non-base packages that are required by the script.
-   newPackages: vector containing the names of the required non-base packages that are not already installed on the computer that the script is being run on. These will be installed if necessary.
-   requiredColumns: an integer vector of 88 column numbers extracted from the unifiedData tibble containing the number of the columns that contain a mean or a standard deviation which are the columns required by the instructions for the project. Also included are two additional columns which contain the activity and the subject performing the activity.
-   requiredData: a tibble containing 10299 observations of 88 variables. These observations are the 10,299 observations which the combined X\_train and X\_test data contain. The variables are columns containing the 86 features of the original data sets which contain mean or standard deviation (std) in their names, plus the subjects and activities, for 88 variables in all.
-   requiredData2: A 885,714 by 4 tibble reshaped and rearranged from requiredData.
-   tidyData: Tidy data set(a tibble) with the average (aggregated and calculated using the mean() function of the r base package) of each variable/measurement of the mean and standard deviation for each of the original features for each activity and each subject.
    -   180 observations of 88 variables.
    -   This data set is the final data and deliverable for the project. It is saved to disk in the working directory in two formats
        -   as a data frame, "tidyData.txt" which can be read using the read.table function of the utils package, and
        -   as a dataset, which can be read using the load function of the base package, and while will restore the tibble format.
-   unifiedData: This dataset combines all of the data from the test and train data resulting in a tibble of 10299 by 563. The labels are the un-tidied versions.

<a name="columnNames"></a>

Column Labels/Names
-------------------

<a name="tidyData"></a>

### tidyData Dataset

Column labels for tidyData data set and labels through their permutations.

These variable/column/feature names only apply if the code used to expand the names and clean them up has not been changed in Section 6 of the run\_analysis.R script .

<table>
<colgroup>
<col width="8%" />
<col width="28%" />
<col width="51%" />
<col width="11%" />
</colgroup>
<thead>
<tr class="header">
<th>Col. Num.</th>
<th>Variable Name</th>
<th>Variable Description<sup id="a1"><a href="#f1">1</a></sup></th>
<th>Variable Class</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>activity</td>
<td>name of the activity in alphabetic order</td>
<td>character<sup id="a2"><a href="#f2">2</a></sup></td>
</tr>
<tr class="even">
<td>2</td>
<td>subject</td>
<td>test subject identifying number</td>
<td>numeric <sup id="a3"><a href="#f3">3,</a></sup> <sup id="a4"><a href="#f4">4</a></sup></td>
</tr>
<tr class="odd">
<td>3</td>
<td>avgTimeBodyAccMeanX</td>
<td>avg of time body acceleration mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>4</td>
<td>avgTimeBodyAccMeanY</td>
<td>avg of time body acceleration mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>5</td>
<td>avgTimeBodyAccMeanZ</td>
<td>avg of time body acceleration mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>6</td>
<td>avgTimeBodyAccStdDevX</td>
<td>avg of time body acceleration standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>7</td>
<td>avgTimeBodyAccStdDevY</td>
<td>avg of time body acceleration standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>8</td>
<td>avgTimeBodyAccStdDevZ</td>
<td>avg of time body acceleration standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>9</td>
<td>avgTimeGravityAccMeanX</td>
<td>avg of time gravity acceleration mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>10</td>
<td>avgTimeGravityAccMeanY</td>
<td>avg of time gravity acceleration mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>11</td>
<td>avgTimeGravityAccMeanZ</td>
<td>avg of time gravity acceleration mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>12</td>
<td>avgTimeGravityAccStdDevX</td>
<td>avg of time gravity acceleration standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>13</td>
<td>avgTimeGravityAccStdDevY</td>
<td>avg of time gravity acceleration standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>14</td>
<td>avgTimeGravityAccStdDevZ</td>
<td>avg of time gravity acceleration standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>15</td>
<td>avgTimeBodyAccJerkMeanX</td>
<td>avg of time body acceleration jerk mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>16</td>
<td>avgTimeBodyAccJerkMeanY</td>
<td>avg of time body acceleration jerk mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>17</td>
<td>avgTimeBodyAccJerkMeanZ</td>
<td>avg of time body acceleration jerk mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>18</td>
<td>avgTimeBodyAccJerkStdDevX</td>
<td>avg of time body acceleration jerk standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>19</td>
<td>avgTimeBodyAccJerkStdDevY</td>
<td>avg of time body acceleration jerk standard for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>20</td>
<td>avgTimeBodyAccJerkStdDevZ</td>
<td>avg of time body acceleration jerk standard for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>21</td>
<td>avgTimeBodyGyroMeanX</td>
<td>avg of time body gyroscope mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>22</td>
<td>avgTimeBodyGyroMeanY</td>
<td>avg of time body gyroscope mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>23</td>
<td>avgTimeBodyGyroMeanZ</td>
<td>avg of time body gyroscope mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>24</td>
<td>avgTimeBodyGyroStdDevX</td>
<td>avg of time body gyroscope standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>25</td>
<td>avgTimeBodyGyroStdDevY</td>
<td>avg of time body gyroscope standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>26</td>
<td>avgTimeBodyGyroStdDevZ</td>
<td>avg of time body gyroscope standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>27</td>
<td>avgTimeBodyGyroJerkMeanX</td>
<td>avg of time body gyroscope jerk mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>28</td>
<td>avgTimeBodyGyroJerkMeanY</td>
<td>avg of time body gyroscope jerk mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>29</td>
<td>avgTimeBodyGyroJerkMeanZ</td>
<td>avg of time body gyroscope jerk mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>30</td>
<td>avgTimeBodyGyroJerkStdDevX</td>
<td>avg of time body gyroscope jerk standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>31</td>
<td>avgTimeBodyGyroJerkStdDevY</td>
<td>avg of time body gyroscope jerk standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>32</td>
<td>avgTimeBodyGyroJerkStdDevZ</td>
<td>avg of time body gyroscope jerk standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>33</td>
<td>avgTimeBodyAccMagnitudeMean</td>
<td>avg of time body acceleration magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>34</td>
<td>avgTimeBodyAccMagnitudeStdDev</td>
<td>avg of time body acceleration magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>35</td>
<td>avgTimeGravityAccMagnitudeMean</td>
<td>avg of time gravity acceleration magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>36</td>
<td>avgTimeGravityAccMagnitudeStdDev</td>
<td>avg of time gravity acceleration magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>37</td>
<td>avgTimeBodyAccJerkMagnitudeMean</td>
<td>avg of time body acceleration jerk magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>38</td>
<td>avgTimeBodyAccJerkMagnitudeStdDev</td>
<td>avg of time body acceleration jerk magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>39</td>
<td>avgTimeBodyGyroMagnitudeMean</td>
<td>avg of time body gyroscope magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>40</td>
<td>avgTimeBodyGyroMagnitudeStdDev</td>
<td>avg of time body gyroscope magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>41</td>
<td>avgTimeBodyGyroJerkMagnitudeMean</td>
<td>avg of time body gyroscope jerk magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>42</td>
<td>avgTimeBodyGyroJerkMagnitudeStdDev</td>
<td>avg of time body gyroscope jerk magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>43</td>
<td>avgFreqBodyAccMeanX</td>
<td>avg of frequency body acceleration mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>44</td>
<td>avgFreqBodyAccMeanY</td>
<td>avg of frequency body acceleration mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>45</td>
<td>avgFreqBodyAccMeanZ</td>
<td>avg of frequency body acceleration mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>46</td>
<td>avgFreqBodyAccStdDevX</td>
<td>avg of frequency body acceleration standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>47</td>
<td>avgFreqBodyAccStdDevY</td>
<td>avg of frequency body acceleration standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>48</td>
<td>avgFreqBodyAccStdDevZ</td>
<td>avg of frequency body acceleration standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>49</td>
<td>avgFreqBodyAccMeanFreqX</td>
<td>avg of frequency body acceleration mean frequency for X</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>50</td>
<td>avgFreqBodyAccMeanFreqY</td>
<td>avg of frequency body acceleration mean frequency for Y</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>51</td>
<td>avgFreqBodyAccMeanFreqZ</td>
<td>avg of frequency body acceleration mean frequency for Z</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>52</td>
<td>avgFreqBodyAccJerkMeanX</td>
<td>avg of frequency body acceleration jerk mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>53</td>
<td>avgFreqBodyAccJerkMeanY</td>
<td>avg of frequency body acceleration jerk mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>54</td>
<td>avgFreqBodyAccJerkMeanZ</td>
<td>avg of frequency body acceleration jerk mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>55</td>
<td>avgFreqBodyAccJerkStdDevX</td>
<td>avg of frequency body acceleration jerk standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>56</td>
<td>avgFreqBodyAccJerkStdDevY</td>
<td>avg of frequency body acceleration jerk standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>57</td>
<td>avgFreqBodyAccJerkStdDevZ</td>
<td>avg of frequency body acceleration jerk standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>58</td>
<td>avgFreqBodyAccJerkMeanFreqX</td>
<td>avg of frequency body acceleration jerk mean frequency for X</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>59</td>
<td>avgFreqBodyAccJerkMeanFreqY</td>
<td>avg of frequency body acceleration jerk mean frequency for Y</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>60</td>
<td>avgFreqBodyAccJerkMeanFreqZ</td>
<td>avg of frequency body acceleration jerk mean frequency for Z</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>61</td>
<td>avgFreqBodyGyroMeanX</td>
<td>avg of frequency body gyroscope mean for the X axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>62</td>
<td>avgFreqBodyGyroMeanY</td>
<td>avg of frequency body gyroscope mean for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>63</td>
<td>avgFreqBodyGyroMeanZ</td>
<td>avg of frequency body gyroscope mean for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>64</td>
<td>avgFreqBodyGyroStdDevX</td>
<td>avg of frequency body gyroscope standard deviation for the X axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>65</td>
<td>avgFreqBodyGyroStdDevY</td>
<td>avg of frequency body gyroscope standard deviation for the Y axis</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>66</td>
<td>avgFreqBodyGyroStdDevZ</td>
<td>avg of frequency body gyroscope standard deviation for the Z axis</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>67</td>
<td>avgFreqBodyGyroMeanFreqX</td>
<td>avg of frequency body gyroscope mean frequency for X</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>68</td>
<td>avgFreqBodyGyroMeanFreqY</td>
<td>avg of frequency body gyroscope mean frequency for Y</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>69</td>
<td>avgFreqBodyGyroMeanFreqZ</td>
<td>avg of frequency body gyroscope mean frequency for Z</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>70</td>
<td>avgFreqBodyAccMagnitudeMean</td>
<td>avg of frequency body accelerator magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>71</td>
<td>avgFreqBodyAccMagnitudeStdDev</td>
<td>avg of frequency body accelerator magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>72</td>
<td>avgFreqBodyAccMagnitudeMeanFreq</td>
<td>avg of frequency body accelerator magnitude mean frequency</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>73</td>
<td>avgFreqBodyAccJerkMagnitudeMean</td>
<td>avg of frequency body accelerator jerk magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>74</td>
<td>avgFreqBodyAccJerkMagnitudeStdDev</td>
<td>avg of frequency body accelerator jerk magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>75</td>
<td>avgFreqBodyAccJerkMagnitudeMeanFreq</td>
<td>avg of frequency body accelerator jerk magnitude mean frequency</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>76</td>
<td>avgFreqBodyGyroMagnitudeMean</td>
<td>avg of frequency body gyroscope magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>77</td>
<td>avgFreqBodyGyroMagnitudeStdDev</td>
<td>avg of frequency body gyroscope magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>78</td>
<td>avgFreqBodyGyroMagnitudeMeanFreq</td>
<td>avg of frequency body gyroscope magnitude mean frequency</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>79</td>
<td>avgFreqBodyGyroJerkMagnitudeMean</td>
<td>avg of frequency body gyroscope jerk magnitude mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>80</td>
<td>avgFreqBodyGyroJerkMagnitudeStdDev</td>
<td>avg of frequency body gyroscope jerk magnitude standard deviation</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>81</td>
<td>avgFreqBodyGyroJerkMagnitudeMeanFreq</td>
<td>avg of frequency body gyroscope jerk magnitude mean frequency</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>82</td>
<td>avgAngleTimeBodyAccMeanGravity</td>
<td>avg of angle signals for time body accelerator mean gravity</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>83</td>
<td>avgAngleTimeBodyAccJerkMeanGravityMean</td>
<td>avg of angle signals for time body accelerator jerk mean gravity mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>84</td>
<td>avgAngleTimeBodyGyroMeanGravityMean</td>
<td>avg of angle signals for time body gyroscope mean gravity mean</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>85</td>
<td>avgAngleTimeBodyGyroJerkMeanGravityMean</td>
<td>avg of angle signals for time body gyroscope jerk mean gravity mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>86</td>
<td>avgAngleXGravityMean</td>
<td>avg of angle signals for X axis gravity mean</td>
<td>numeric</td>
</tr>
<tr class="odd">
<td>87</td>
<td>avgAngleYGravityMean</td>
<td>avg of angle signals for Y axis gravity mean</td>
<td>numeric</td>
</tr>
<tr class="even">
<td>88</td>
<td>avgAngleZGravityMean</td>
<td>avg of angle signals for Z axis gravity mean</td>
<td>numeric</td>
</tr>
</tbody>
</table>

<i id="f1">1</i>The variable descriptions are taken from from scsosa, Getting Cleaning Data Project(2014), GitHub repository, [CodeBook.md](https://github.com/scsosa/Getting_and_Cleaning_Data_Project/blob/master/CodeBook.md) [&#x21A9;](#a1)

<i id="f2">2</i> First of two keys to the tidyData table. [&#x21A9;](#a2)

<i id="f3">3</i> Ordinal Data with values of 1 through 30. Numeric class so that it will sort correctly. [&#x21A9;](#a3)

<i id="f4">4</i> Second of two keys to the tidyData table. [&#x21A9;](#a4)

<a name="original"></a>

### Original column names/labels/features

<table style="width:93%;">
<colgroup>
<col width="15%" />
<col width="30%" />
<col width="10%" />
</colgroup>
<thead>
<tr class="header">
<th>xtrain and xtest<br /> Col. Num.</th>
<th>unifiedData<br /> Features/Col. Labels</th>
<th>tidyData<br /> Col. Num.</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>V1</td>
<td>tBodyAcc-mean()-X</td>
<td>3</td>
</tr>
<tr class="even">
<td>V2</td>
<td>tBodyAcc-mean()-Y</td>
<td>4</td>
</tr>
<tr class="odd">
<td>V3</td>
<td>tBodyAcc-mean()-Z</td>
<td>5</td>
</tr>
<tr class="even">
<td>V4</td>
<td>tBodyAcc-std()-X</td>
<td>6</td>
</tr>
<tr class="odd">
<td>V5</td>
<td>tBodyAcc-std()-Y</td>
<td>7</td>
</tr>
<tr class="even">
<td>V6</td>
<td>tBodyAcc-std()-Z</td>
<td>8</td>
</tr>
<tr class="odd">
<td>V7</td>
<td>tBodyAcc-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V8</td>
<td>tBodyAcc-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V9</td>
<td>tBodyAcc-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V10</td>
<td>tBodyAcc-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V11</td>
<td>tBodyAcc-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V12</td>
<td>tBodyAcc-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V13</td>
<td>tBodyAcc-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V14</td>
<td>tBodyAcc-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V15</td>
<td>tBodyAcc-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V16</td>
<td>tBodyAcc-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V17</td>
<td>tBodyAcc-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V18</td>
<td>tBodyAcc-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V19</td>
<td>tBodyAcc-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V20</td>
<td>tBodyAcc-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V21</td>
<td>tBodyAcc-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V22</td>
<td>tBodyAcc-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V23</td>
<td>tBodyAcc-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V24</td>
<td>tBodyAcc-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V25</td>
<td>tBodyAcc-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V26</td>
<td>tBodyAcc-arCoeff()-X,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V27</td>
<td>tBodyAcc-arCoeff()-X,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V28</td>
<td>tBodyAcc-arCoeff()-X,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V29</td>
<td>tBodyAcc-arCoeff()-X,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V30</td>
<td>tBodyAcc-arCoeff()-Y,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V31</td>
<td>tBodyAcc-arCoeff()-Y,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V32</td>
<td>tBodyAcc-arCoeff()-Y,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V33</td>
<td>tBodyAcc-arCoeff()-Y,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V34</td>
<td>tBodyAcc-arCoeff()-Z,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V35</td>
<td>tBodyAcc-arCoeff()-Z,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V36</td>
<td>tBodyAcc-arCoeff()-Z,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V37</td>
<td>tBodyAcc-arCoeff()-Z,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V38</td>
<td>tBodyAcc-correlation()-X,Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V39</td>
<td>tBodyAcc-correlation()-X,Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V40</td>
<td>tBodyAcc-correlation()-Y,Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V41</td>
<td>tGravityAcc-mean()-X</td>
<td>9</td>
</tr>
<tr class="even">
<td>V42</td>
<td>tGravityAcc-mean()-Y</td>
<td>10</td>
</tr>
<tr class="odd">
<td>V43</td>
<td>tGravityAcc-mean()-Z</td>
<td>11</td>
</tr>
<tr class="even">
<td>V44</td>
<td>tGravityAcc-std()-X</td>
<td>12</td>
</tr>
<tr class="odd">
<td>V45</td>
<td>tGravityAcc-std()-Y</td>
<td>13</td>
</tr>
<tr class="even">
<td>V46</td>
<td>tGravityAcc-std()-Z</td>
<td>14</td>
</tr>
<tr class="odd">
<td>V47</td>
<td>tGravityAcc-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V48</td>
<td>tGravityAcc-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V49</td>
<td>tGravityAcc-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V50</td>
<td>tGravityAcc-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V51</td>
<td>tGravityAcc-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V52</td>
<td>tGravityAcc-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V53</td>
<td>tGravityAcc-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V54</td>
<td>tGravityAcc-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V55</td>
<td>tGravityAcc-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V56</td>
<td>tGravityAcc-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V57</td>
<td>tGravityAcc-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V58</td>
<td>tGravityAcc-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V59</td>
<td>tGravityAcc-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V60</td>
<td>tGravityAcc-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V61</td>
<td>tGravityAcc-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V62</td>
<td>tGravityAcc-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V63</td>
<td>tGravityAcc-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V64</td>
<td>tGravityAcc-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V65</td>
<td>tGravityAcc-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V66</td>
<td>tGravityAcc-arCoeff()-X,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V67</td>
<td>tGravityAcc-arCoeff()-X,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V68</td>
<td>tGravityAcc-arCoeff()-X,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V69</td>
<td>tGravityAcc-arCoeff()-X,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V70</td>
<td>tGravityAcc-arCoeff()-Y,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V71</td>
<td>tGravityAcc-arCoeff()-Y,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V72</td>
<td>tGravityAcc-arCoeff()-Y,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V73</td>
<td>tGravityAcc-arCoeff()-Y,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V74</td>
<td>tGravityAcc-arCoeff()-Z,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V75</td>
<td>tGravityAcc-arCoeff()-Z,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V76</td>
<td>tGravityAcc-arCoeff()-Z,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V77</td>
<td>tGravityAcc-arCoeff()-Z,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V78</td>
<td>tGravityAcc-correlation()-X,Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V79</td>
<td>tGravityAcc-correlation()-X,Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V80</td>
<td>tGravityAcc-correlation()-Y,Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V81</td>
<td>tBodyAccJerk-mean()-X</td>
<td>15</td>
</tr>
<tr class="even">
<td>V82</td>
<td>tBodyAccJerk-mean()-Y</td>
<td>16</td>
</tr>
<tr class="odd">
<td>V83</td>
<td>tBodyAccJerk-mean()-Z</td>
<td>17</td>
</tr>
<tr class="even">
<td>V84</td>
<td>tBodyAccJerk-std()-X</td>
<td>18</td>
</tr>
<tr class="odd">
<td>V85</td>
<td>tBodyAccJerk-std()-Y</td>
<td>19</td>
</tr>
<tr class="even">
<td>V86</td>
<td>tBodyAccJerk-std()-Z</td>
<td>20</td>
</tr>
<tr class="odd">
<td>V87</td>
<td>tBodyAccJerk-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V88</td>
<td>tBodyAccJerk-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V89</td>
<td>tBodyAccJerk-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V90</td>
<td>tBodyAccJerk-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V91</td>
<td>tBodyAccJerk-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V92</td>
<td>tBodyAccJerk-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V93</td>
<td>tBodyAccJerk-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V94</td>
<td>tBodyAccJerk-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V95</td>
<td>tBodyAccJerk-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V96</td>
<td>tBodyAccJerk-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V97</td>
<td>tBodyAccJerk-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V98</td>
<td>tBodyAccJerk-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V99</td>
<td>tBodyAccJerk-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V100</td>
<td>tBodyAccJerk-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V101</td>
<td>tBodyAccJerk-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V102</td>
<td>tBodyAccJerk-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V103</td>
<td>tBodyAccJerk-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V104</td>
<td>tBodyAccJerk-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V105</td>
<td>tBodyAccJerk-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V106</td>
<td>tBodyAccJerk-arCoeff()-X,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V107</td>
<td>tBodyAccJerk-arCoeff()-X,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V108</td>
<td>tBodyAccJerk-arCoeff()-X,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V109</td>
<td>tBodyAccJerk-arCoeff()-X,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V110</td>
<td>tBodyAccJerk-arCoeff()-Y,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V111</td>
<td>tBodyAccJerk-arCoeff()-Y,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V112</td>
<td>tBodyAccJerk-arCoeff()-Y,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V113</td>
<td>tBodyAccJerk-arCoeff()-Y,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V114</td>
<td>tBodyAccJerk-arCoeff()-Z,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V115</td>
<td>tBodyAccJerk-arCoeff()-Z,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V116</td>
<td>tBodyAccJerk-arCoeff()-Z,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V117</td>
<td>tBodyAccJerk-arCoeff()-Z,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V118</td>
<td>tBodyAccJerk-correlation()-X,Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V119</td>
<td>tBodyAccJerk-correlation()-X,Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V120</td>
<td>tBodyAccJerk-correlation()-Y,Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V121</td>
<td>tBodyGyro-mean()-X</td>
<td>21</td>
</tr>
<tr class="even">
<td>V122</td>
<td>tBodyGyro-mean()-Y</td>
<td>22</td>
</tr>
<tr class="odd">
<td>V123</td>
<td>tBodyGyro-mean()-Z</td>
<td>23</td>
</tr>
<tr class="even">
<td>V124</td>
<td>tBodyGyro-std()-X</td>
<td>24</td>
</tr>
<tr class="odd">
<td>V125</td>
<td>tBodyGyro-std()-Y</td>
<td>25</td>
</tr>
<tr class="even">
<td>V126</td>
<td>tBodyGyro-std()-Z</td>
<td>26</td>
</tr>
<tr class="odd">
<td>V127</td>
<td>tBodyGyro-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V128</td>
<td>tBodyGyro-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V129</td>
<td>tBodyGyro-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V130</td>
<td>tBodyGyro-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V131</td>
<td>tBodyGyro-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V132</td>
<td>tBodyGyro-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V133</td>
<td>tBodyGyro-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V134</td>
<td>tBodyGyro-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V135</td>
<td>tBodyGyro-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V136</td>
<td>tBodyGyro-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V137</td>
<td>tBodyGyro-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V138</td>
<td>tBodyGyro-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V139</td>
<td>tBodyGyro-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V140</td>
<td>tBodyGyro-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V141</td>
<td>tBodyGyro-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V142</td>
<td>tBodyGyro-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V143</td>
<td>tBodyGyro-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V144</td>
<td>tBodyGyro-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V145</td>
<td>tBodyGyro-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V146</td>
<td>tBodyGyro-arCoeff()-X,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V147</td>
<td>tBodyGyro-arCoeff()-X,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V148</td>
<td>tBodyGyro-arCoeff()-X,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V149</td>
<td>tBodyGyro-arCoeff()-X,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V150</td>
<td>tBodyGyro-arCoeff()-Y,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V151</td>
<td>tBodyGyro-arCoeff()-Y,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V152</td>
<td>tBodyGyro-arCoeff()-Y,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V153</td>
<td>tBodyGyro-arCoeff()-Y,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V154</td>
<td>tBodyGyro-arCoeff()-Z,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V155</td>
<td>tBodyGyro-arCoeff()-Z,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V156</td>
<td>tBodyGyro-arCoeff()-Z,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V157</td>
<td>tBodyGyro-arCoeff()-Z,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V158</td>
<td>tBodyGyro-correlation()-X,Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V159</td>
<td>tBodyGyro-correlation()-X,Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V160</td>
<td>tBodyGyro-correlation()-Y,Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V161</td>
<td>tBodyGyroJerk-mean()-X</td>
<td>27</td>
</tr>
<tr class="even">
<td>V162</td>
<td>tBodyGyroJerk-mean()-Y</td>
<td>28</td>
</tr>
<tr class="odd">
<td>V163</td>
<td>tBodyGyroJerk-mean()-Z</td>
<td>29</td>
</tr>
<tr class="even">
<td>V164</td>
<td>tBodyGyroJerk-std()-X</td>
<td>30</td>
</tr>
<tr class="odd">
<td>V165</td>
<td>tBodyGyroJerk-std()-Y</td>
<td>31</td>
</tr>
<tr class="even">
<td>V166</td>
<td>tBodyGyroJerk-std()-Z</td>
<td>32</td>
</tr>
<tr class="odd">
<td>V167</td>
<td>tBodyGyroJerk-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V168</td>
<td>tBodyGyroJerk-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V169</td>
<td>tBodyGyroJerk-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V170</td>
<td>tBodyGyroJerk-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V171</td>
<td>tBodyGyroJerk-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V172</td>
<td>tBodyGyroJerk-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V173</td>
<td>tBodyGyroJerk-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V174</td>
<td>tBodyGyroJerk-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V175</td>
<td>tBodyGyroJerk-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V176</td>
<td>tBodyGyroJerk-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V177</td>
<td>tBodyGyroJerk-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V178</td>
<td>tBodyGyroJerk-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V179</td>
<td>tBodyGyroJerk-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V180</td>
<td>tBodyGyroJerk-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V181</td>
<td>tBodyGyroJerk-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V182</td>
<td>tBodyGyroJerk-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V183</td>
<td>tBodyGyroJerk-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V184</td>
<td>tBodyGyroJerk-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V185</td>
<td>tBodyGyroJerk-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V186</td>
<td>tBodyGyroJerk-arCoeff()-X,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V187</td>
<td>tBodyGyroJerk-arCoeff()-X,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V188</td>
<td>tBodyGyroJerk-arCoeff()-X,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V189</td>
<td>tBodyGyroJerk-arCoeff()-X,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V190</td>
<td>tBodyGyroJerk-arCoeff()-Y,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V191</td>
<td>tBodyGyroJerk-arCoeff()-Y,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V192</td>
<td>tBodyGyroJerk-arCoeff()-Y,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V193</td>
<td>tBodyGyroJerk-arCoeff()-Y,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V194</td>
<td>tBodyGyroJerk-arCoeff()-Z,1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V195</td>
<td>tBodyGyroJerk-arCoeff()-Z,2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V196</td>
<td>tBodyGyroJerk-arCoeff()-Z,3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V197</td>
<td>tBodyGyroJerk-arCoeff()-Z,4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V198</td>
<td>tBodyGyroJerk-correlation()-X,Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V199</td>
<td>tBodyGyroJerk-correlation()-X,Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V200</td>
<td>tBodyGyroJerk-correlation()-Y,Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V201</td>
<td>tBodyAccMag-mean()</td>
<td>33</td>
</tr>
<tr class="even">
<td>V202</td>
<td>tBodyAccMag-std()</td>
<td>34</td>
</tr>
<tr class="odd">
<td>V203</td>
<td>tBodyAccMag-mad()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V204</td>
<td>tBodyAccMag-max()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V205</td>
<td>tBodyAccMag-min()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V206</td>
<td>tBodyAccMag-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V207</td>
<td>tBodyAccMag-energy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V208</td>
<td>tBodyAccMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V209</td>
<td>tBodyAccMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V210</td>
<td>tBodyAccMag-arCoeff()1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V211</td>
<td>tBodyAccMag-arCoeff()2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V212</td>
<td>tBodyAccMag-arCoeff()3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V213</td>
<td>tBodyAccMag-arCoeff()4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V214</td>
<td>tGravityAccMag-mean()</td>
<td>35</td>
</tr>
<tr class="odd">
<td>V215</td>
<td>tGravityAccMag-std()</td>
<td>36</td>
</tr>
<tr class="even">
<td>V216</td>
<td>tGravityAccMag-mad()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V217</td>
<td>tGravityAccMag-max()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V218</td>
<td>tGravityAccMag-min()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V219</td>
<td>tGravityAccMag-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V220</td>
<td>tGravityAccMag-energy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V221</td>
<td>tGravityAccMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V222</td>
<td>tGravityAccMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V223</td>
<td>tGravityAccMag-arCoeff()1</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V224</td>
<td>tGravityAccMag-arCoeff()2</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V225</td>
<td>tGravityAccMag-arCoeff()3</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V226</td>
<td>tGravityAccMag-arCoeff()4</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V227</td>
<td>tBodyAccJerkMag-mean()</td>
<td>37</td>
</tr>
<tr class="even">
<td>V228</td>
<td>tBodyAccJerkMag-std()</td>
<td>38</td>
</tr>
<tr class="odd">
<td>V229</td>
<td>tBodyAccJerkMag-mad()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V230</td>
<td>tBodyAccJerkMag-max()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V231</td>
<td>tBodyAccJerkMag-min()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V232</td>
<td>tBodyAccJerkMag-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V233</td>
<td>tBodyAccJerkMag-energy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V234</td>
<td>tBodyAccJerkMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V235</td>
<td>tBodyAccJerkMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V236</td>
<td>tBodyAccJerkMag-arCoeff()1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V237</td>
<td>tBodyAccJerkMag-arCoeff()2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V238</td>
<td>tBodyAccJerkMag-arCoeff()3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V239</td>
<td>tBodyAccJerkMag-arCoeff()4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V240</td>
<td>tBodyGyroMag-mean()</td>
<td>39</td>
</tr>
<tr class="odd">
<td>V241</td>
<td>tBodyGyroMag-std()</td>
<td>40</td>
</tr>
<tr class="even">
<td>V242</td>
<td>tBodyGyroMag-mad()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V243</td>
<td>tBodyGyroMag-max()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V244</td>
<td>tBodyGyroMag-min()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V245</td>
<td>tBodyGyroMag-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V246</td>
<td>tBodyGyroMag-energy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V247</td>
<td>tBodyGyroMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V248</td>
<td>tBodyGyroMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V249</td>
<td>tBodyGyroMag-arCoeff()1</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V250</td>
<td>tBodyGyroMag-arCoeff()2</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V251</td>
<td>tBodyGyroMag-arCoeff()3</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V252</td>
<td>tBodyGyroMag-arCoeff()4</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V253</td>
<td>tBodyGyroJerkMag-mean()</td>
<td>41</td>
</tr>
<tr class="even">
<td>V254</td>
<td>tBodyGyroJerkMag-std()</td>
<td>42</td>
</tr>
<tr class="odd">
<td>V255</td>
<td>tBodyGyroJerkMag-mad()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V256</td>
<td>tBodyGyroJerkMag-max()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V257</td>
<td>tBodyGyroJerkMag-min()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V258</td>
<td>tBodyGyroJerkMag-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V259</td>
<td>tBodyGyroJerkMag-energy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V260</td>
<td>tBodyGyroJerkMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V261</td>
<td>tBodyGyroJerkMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V262</td>
<td>tBodyGyroJerkMag-arCoeff()1</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V263</td>
<td>tBodyGyroJerkMag-arCoeff()2</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V264</td>
<td>tBodyGyroJerkMag-arCoeff()3</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V265</td>
<td>tBodyGyroJerkMag-arCoeff()4</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V266</td>
<td>fBodyAcc-mean()-X</td>
<td>43</td>
</tr>
<tr class="odd">
<td>V267</td>
<td>fBodyAcc-mean()-Y</td>
<td>44</td>
</tr>
<tr class="even">
<td>V268</td>
<td>fBodyAcc-mean()-Z</td>
<td>45</td>
</tr>
<tr class="odd">
<td>V269</td>
<td>fBodyAcc-std()-X</td>
<td>46</td>
</tr>
<tr class="even">
<td>V270</td>
<td>fBodyAcc-std()-Y</td>
<td>47</td>
</tr>
<tr class="odd">
<td>V271</td>
<td>fBodyAcc-std()-Z</td>
<td>48</td>
</tr>
<tr class="even">
<td>V272</td>
<td>fBodyAcc-mad()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V273</td>
<td>fBodyAcc-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V274</td>
<td>fBodyAcc-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V275</td>
<td>fBodyAcc-max()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V276</td>
<td>fBodyAcc-max()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V277</td>
<td>fBodyAcc-max()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V278</td>
<td>fBodyAcc-min()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V279</td>
<td>fBodyAcc-min()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V280</td>
<td>fBodyAcc-min()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V281</td>
<td>fBodyAcc-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V282</td>
<td>fBodyAcc-energy()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V283</td>
<td>fBodyAcc-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V284</td>
<td>fBodyAcc-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V285</td>
<td>fBodyAcc-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V286</td>
<td>fBodyAcc-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V287</td>
<td>fBodyAcc-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V288</td>
<td>fBodyAcc-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V289</td>
<td>fBodyAcc-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V290</td>
<td>fBodyAcc-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V291</td>
<td>fBodyAcc-maxInds-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V292</td>
<td>fBodyAcc-maxInds-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V293</td>
<td>fBodyAcc-maxInds-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V294</td>
<td>fBodyAcc-meanFreq()-X</td>
<td>49</td>
</tr>
<tr class="odd">
<td>V295</td>
<td>fBodyAcc-meanFreq()-Y</td>
<td>50</td>
</tr>
<tr class="even">
<td>V296</td>
<td>fBodyAcc-meanFreq()-Z</td>
<td>51</td>
</tr>
<tr class="odd">
<td>V297</td>
<td>fBodyAcc-skewness()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V298</td>
<td>fBodyAcc-kurtosis()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V299</td>
<td>fBodyAcc-skewness()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V300</td>
<td>fBodyAcc-kurtosis()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V301</td>
<td>fBodyAcc-skewness()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V302</td>
<td>fBodyAcc-kurtosis()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V303</td>
<td>fBodyAcc-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V304</td>
<td>fBodyAcc-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V305</td>
<td>fBodyAcc-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V306</td>
<td>fBodyAcc-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V307</td>
<td>fBodyAcc-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V308</td>
<td>fBodyAcc-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V309</td>
<td>fBodyAcc-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V310</td>
<td>fBodyAcc-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V311</td>
<td>fBodyAcc-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V312</td>
<td>fBodyAcc-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V313</td>
<td>fBodyAcc-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V314</td>
<td>fBodyAcc-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V315</td>
<td>fBodyAcc-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V316</td>
<td>fBodyAcc-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V317</td>
<td>fBodyAcc-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V318</td>
<td>fBodyAcc-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V319</td>
<td>fBodyAcc-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V320</td>
<td>fBodyAcc-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V321</td>
<td>fBodyAcc-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V322</td>
<td>fBodyAcc-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V323</td>
<td>fBodyAcc-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V324</td>
<td>fBodyAcc-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V325</td>
<td>fBodyAcc-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V326</td>
<td>fBodyAcc-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V327</td>
<td>fBodyAcc-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V328</td>
<td>fBodyAcc-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V329</td>
<td>fBodyAcc-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V330</td>
<td>fBodyAcc-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V331</td>
<td>fBodyAcc-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V332</td>
<td>fBodyAcc-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V333</td>
<td>fBodyAcc-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V334</td>
<td>fBodyAcc-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V335</td>
<td>fBodyAcc-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V336</td>
<td>fBodyAcc-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V337</td>
<td>fBodyAcc-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V338</td>
<td>fBodyAcc-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V339</td>
<td>fBodyAcc-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V340</td>
<td>fBodyAcc-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V341</td>
<td>fBodyAcc-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V342</td>
<td>fBodyAcc-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V343</td>
<td>fBodyAcc-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V344</td>
<td>fBodyAcc-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V345</td>
<td>fBodyAccJerk-mean()-X</td>
<td>52</td>
</tr>
<tr class="even">
<td>V346</td>
<td>fBodyAccJerk-mean()-Y</td>
<td>53</td>
</tr>
<tr class="odd">
<td>V347</td>
<td>fBodyAccJerk-mean()-Z</td>
<td>54</td>
</tr>
<tr class="even">
<td>V348</td>
<td>fBodyAccJerk-std()-X</td>
<td>55</td>
</tr>
<tr class="odd">
<td>V349</td>
<td>fBodyAccJerk-std()-Y</td>
<td>56</td>
</tr>
<tr class="even">
<td>V350</td>
<td>fBodyAccJerk-std()-Z</td>
<td>57</td>
</tr>
<tr class="odd">
<td>V351</td>
<td>fBodyAccJerk-mad()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V352</td>
<td>fBodyAccJerk-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V353</td>
<td>fBodyAccJerk-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V354</td>
<td>fBodyAccJerk-max()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V355</td>
<td>fBodyAccJerk-max()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V356</td>
<td>fBodyAccJerk-max()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V357</td>
<td>fBodyAccJerk-min()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V358</td>
<td>fBodyAccJerk-min()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V359</td>
<td>fBodyAccJerk-min()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V360</td>
<td>fBodyAccJerk-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V361</td>
<td>fBodyAccJerk-energy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V362</td>
<td>fBodyAccJerk-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V363</td>
<td>fBodyAccJerk-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V364</td>
<td>fBodyAccJerk-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V365</td>
<td>fBodyAccJerk-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V366</td>
<td>fBodyAccJerk-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V367</td>
<td>fBodyAccJerk-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V368</td>
<td>fBodyAccJerk-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V369</td>
<td>fBodyAccJerk-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V370</td>
<td>fBodyAccJerk-maxInds-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V371</td>
<td>fBodyAccJerk-maxInds-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V372</td>
<td>fBodyAccJerk-maxInds-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V373</td>
<td>fBodyAccJerk-meanFreq()-X</td>
<td>58</td>
</tr>
<tr class="even">
<td>V374</td>
<td>fBodyAccJerk-meanFreq()-Y</td>
<td>59</td>
</tr>
<tr class="odd">
<td>V375</td>
<td>fBodyAccJerk-meanFreq()-Z</td>
<td>60</td>
</tr>
<tr class="even">
<td>V376</td>
<td>fBodyAccJerk-skewness()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V377</td>
<td>fBodyAccJerk-kurtosis()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V378</td>
<td>fBodyAccJerk-skewness()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V379</td>
<td>fBodyAccJerk-kurtosis()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V380</td>
<td>fBodyAccJerk-skewness()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V381</td>
<td>fBodyAccJerk-kurtosis()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V382</td>
<td>fBodyAccJerk-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V383</td>
<td>fBodyAccJerk-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V384</td>
<td>fBodyAccJerk-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V385</td>
<td>fBodyAccJerk-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V386</td>
<td>fBodyAccJerk-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V387</td>
<td>fBodyAccJerk-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V388</td>
<td>fBodyAccJerk-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V389</td>
<td>fBodyAccJerk-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V390</td>
<td>fBodyAccJerk-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V391</td>
<td>fBodyAccJerk-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V392</td>
<td>fBodyAccJerk-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V393</td>
<td>fBodyAccJerk-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V394</td>
<td>fBodyAccJerk-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V395</td>
<td>fBodyAccJerk-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V396</td>
<td>fBodyAccJerk-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V397</td>
<td>fBodyAccJerk-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V398</td>
<td>fBodyAccJerk-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V399</td>
<td>fBodyAccJerk-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V400</td>
<td>fBodyAccJerk-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V401</td>
<td>fBodyAccJerk-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V402</td>
<td>fBodyAccJerk-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V403</td>
<td>fBodyAccJerk-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V404</td>
<td>fBodyAccJerk-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V405</td>
<td>fBodyAccJerk-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V406</td>
<td>fBodyAccJerk-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V407</td>
<td>fBodyAccJerk-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V408</td>
<td>fBodyAccJerk-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V409</td>
<td>fBodyAccJerk-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V410</td>
<td>fBodyAccJerk-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V411</td>
<td>fBodyAccJerk-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V412</td>
<td>fBodyAccJerk-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V413</td>
<td>fBodyAccJerk-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V414</td>
<td>fBodyAccJerk-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V415</td>
<td>fBodyAccJerk-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V416</td>
<td>fBodyAccJerk-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V417</td>
<td>fBodyAccJerk-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V418</td>
<td>fBodyAccJerk-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V419</td>
<td>fBodyAccJerk-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V420</td>
<td>fBodyAccJerk-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V421</td>
<td>fBodyAccJerk-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V422</td>
<td>fBodyAccJerk-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V423</td>
<td>fBodyAccJerk-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V424</td>
<td>fBodyGyro-mean()-X</td>
<td>61</td>
</tr>
<tr class="odd">
<td>V425</td>
<td>fBodyGyro-mean()-Y</td>
<td>62</td>
</tr>
<tr class="even">
<td>V426</td>
<td>fBodyGyro-mean()-Z</td>
<td>63</td>
</tr>
<tr class="odd">
<td>V427</td>
<td>fBodyGyro-std()-X</td>
<td>64</td>
</tr>
<tr class="even">
<td>V428</td>
<td>fBodyGyro-std()-Y</td>
<td>65</td>
</tr>
<tr class="odd">
<td>V429</td>
<td>fBodyGyro-std()-Z</td>
<td>66</td>
</tr>
<tr class="even">
<td>V430</td>
<td>fBodyGyro-mad()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V431</td>
<td>fBodyGyro-mad()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V432</td>
<td>fBodyGyro-mad()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V433</td>
<td>fBodyGyro-max()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V434</td>
<td>fBodyGyro-max()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V435</td>
<td>fBodyGyro-max()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V436</td>
<td>fBodyGyro-min()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V437</td>
<td>fBodyGyro-min()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V438</td>
<td>fBodyGyro-min()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V439</td>
<td>fBodyGyro-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V440</td>
<td>fBodyGyro-energy()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V441</td>
<td>fBodyGyro-energy()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V442</td>
<td>fBodyGyro-energy()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V443</td>
<td>fBodyGyro-iqr()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V444</td>
<td>fBodyGyro-iqr()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V445</td>
<td>fBodyGyro-iqr()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V446</td>
<td>fBodyGyro-entropy()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V447</td>
<td>fBodyGyro-entropy()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V448</td>
<td>fBodyGyro-entropy()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V449</td>
<td>fBodyGyro-maxInds-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V450</td>
<td>fBodyGyro-maxInds-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V451</td>
<td>fBodyGyro-maxInds-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V452</td>
<td>fBodyGyro-meanFreq()-X</td>
<td>67</td>
</tr>
<tr class="odd">
<td>V453</td>
<td>fBodyGyro-meanFreq()-Y</td>
<td>68</td>
</tr>
<tr class="even">
<td>V454</td>
<td>fBodyGyro-meanFreq()-Z</td>
<td>69</td>
</tr>
<tr class="odd">
<td>V455</td>
<td>fBodyGyro-skewness()-X</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V456</td>
<td>fBodyGyro-kurtosis()-X</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V457</td>
<td>fBodyGyro-skewness()-Y</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V458</td>
<td>fBodyGyro-kurtosis()-Y</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V459</td>
<td>fBodyGyro-skewness()-Z</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V460</td>
<td>fBodyGyro-kurtosis()-Z</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V461</td>
<td>fBodyGyro-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V462</td>
<td>fBodyGyro-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V463</td>
<td>fBodyGyro-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V464</td>
<td>fBodyGyro-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V465</td>
<td>fBodyGyro-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V466</td>
<td>fBodyGyro-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V467</td>
<td>fBodyGyro-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V468</td>
<td>fBodyGyro-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V469</td>
<td>fBodyGyro-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V470</td>
<td>fBodyGyro-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V471</td>
<td>fBodyGyro-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V472</td>
<td>fBodyGyro-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V473</td>
<td>fBodyGyro-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V474</td>
<td>fBodyGyro-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V475</td>
<td>fBodyGyro-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V476</td>
<td>fBodyGyro-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V477</td>
<td>fBodyGyro-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V478</td>
<td>fBodyGyro-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V479</td>
<td>fBodyGyro-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V480</td>
<td>fBodyGyro-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V481</td>
<td>fBodyGyro-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V482</td>
<td>fBodyGyro-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V483</td>
<td>fBodyGyro-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V484</td>
<td>fBodyGyro-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V485</td>
<td>fBodyGyro-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V486</td>
<td>fBodyGyro-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V487</td>
<td>fBodyGyro-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V488</td>
<td>fBodyGyro-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V489</td>
<td>fBodyGyro-bandsEnergy()-1,8</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V490</td>
<td>fBodyGyro-bandsEnergy()-9,16</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V491</td>
<td>fBodyGyro-bandsEnergy()-17,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V492</td>
<td>fBodyGyro-bandsEnergy()-25,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V493</td>
<td>fBodyGyro-bandsEnergy()-33,40</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V494</td>
<td>fBodyGyro-bandsEnergy()-41,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V495</td>
<td>fBodyGyro-bandsEnergy()-49,56</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V496</td>
<td>fBodyGyro-bandsEnergy()-57,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V497</td>
<td>fBodyGyro-bandsEnergy()-1,16</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V498</td>
<td>fBodyGyro-bandsEnergy()-17,32</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V499</td>
<td>fBodyGyro-bandsEnergy()-33,48</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V500</td>
<td>fBodyGyro-bandsEnergy()-49,64</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V501</td>
<td>fBodyGyro-bandsEnergy()-1,24</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V502</td>
<td>fBodyGyro-bandsEnergy()-25,48</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V503</td>
<td>fBodyAccMag-mean()</td>
<td>70</td>
</tr>
<tr class="even">
<td>V504</td>
<td>fBodyAccMag-std()</td>
<td>71</td>
</tr>
<tr class="odd">
<td>V505</td>
<td>fBodyAccMag-mad()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V506</td>
<td>fBodyAccMag-max()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V507</td>
<td>fBodyAccMag-min()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V508</td>
<td>fBodyAccMag-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V509</td>
<td>fBodyAccMag-energy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V510</td>
<td>fBodyAccMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V511</td>
<td>fBodyAccMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V512</td>
<td>fBodyAccMag-maxInds</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V513</td>
<td>fBodyAccMag-meanFreq()</td>
<td>72</td>
</tr>
<tr class="even">
<td>V514</td>
<td>fBodyAccMag-skewness()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V515</td>
<td>fBodyAccMag-kurtosis()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V516</td>
<td>fBodyBodyAccJerkMag-mean()</td>
<td>73</td>
</tr>
<tr class="odd">
<td>V517</td>
<td>fBodyBodyAccJerkMag-std()</td>
<td>74</td>
</tr>
<tr class="even">
<td>V518</td>
<td>fBodyBodyAccJerkMag-mad()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V519</td>
<td>fBodyBodyAccJerkMag-max()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V520</td>
<td>fBodyBodyAccJerkMag-min()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V521</td>
<td>fBodyBodyAccJerkMag-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V522</td>
<td>fBodyBodyAccJerkMag-energy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V523</td>
<td>fBodyBodyAccJerkMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V524</td>
<td>fBodyBodyAccJerkMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V525</td>
<td>fBodyBodyAccJerkMag-maxInds</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V526</td>
<td>fBodyBodyAccJerkMag-meanFreq()</td>
<td>75</td>
</tr>
<tr class="odd">
<td>V527</td>
<td>fBodyBodyAccJerkMag-skewness()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V528</td>
<td>fBodyBodyAccJerkMag-kurtosis()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V529</td>
<td>fBodyBodyGyroMag-mean()</td>
<td>76</td>
</tr>
<tr class="even">
<td>V530</td>
<td>fBodyBodyGyroMag-std()</td>
<td>77</td>
</tr>
<tr class="odd">
<td>V531</td>
<td>fBodyBodyGyroMag-mad()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V532</td>
<td>fBodyBodyGyroMag-max()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V533</td>
<td>fBodyBodyGyroMag-min()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V534</td>
<td>fBodyBodyGyroMag-sma()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V535</td>
<td>fBodyBodyGyroMag-energy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V536</td>
<td>fBodyBodyGyroMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V537</td>
<td>fBodyBodyGyroMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V538</td>
<td>fBodyBodyGyroMag-maxInds</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V539</td>
<td>fBodyBodyGyroMag-meanFreq()</td>
<td>78</td>
</tr>
<tr class="even">
<td>V540</td>
<td>fBodyBodyGyroMag-skewness()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V541</td>
<td>fBodyBodyGyroMag-kurtosis()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V542</td>
<td>fBodyBodyGyroJerkMag-mean()</td>
<td>79</td>
</tr>
<tr class="odd">
<td>V543</td>
<td>fBodyBodyGyroJerkMag-std()</td>
<td>80</td>
</tr>
<tr class="even">
<td>V544</td>
<td>fBodyBodyGyroJerkMag-mad()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V545</td>
<td>fBodyBodyGyroJerkMag-max()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V546</td>
<td>fBodyBodyGyroJerkMag-min()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V547</td>
<td>fBodyBodyGyroJerkMag-sma()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V548</td>
<td>fBodyBodyGyroJerkMag-energy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V549</td>
<td>fBodyBodyGyroJerkMag-iqr()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V550</td>
<td>fBodyBodyGyroJerkMag-entropy()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V551</td>
<td>fBodyBodyGyroJerkMag-maxInds</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V552</td>
<td>fBodyBodyGyroJerkMag-meanFreq()</td>
<td>81</td>
</tr>
<tr class="odd">
<td>V553</td>
<td>fBodyBodyGyroJerkMag-skewness()</td>
<td>NA</td>
</tr>
<tr class="even">
<td>V554</td>
<td>fBodyBodyGyroJerkMag-kurtosis()</td>
<td>NA</td>
</tr>
<tr class="odd">
<td>V555</td>
<td>angle(tBodyAccMean,gravity)</td>
<td>82</td>
</tr>
<tr class="even">
<td>V556</td>
<td>angle(tBodyAccJerkMean),gravityMean)</td>
<td>83</td>
</tr>
<tr class="odd">
<td>V557</td>
<td>angle(tBodyGyroMean,gravityMean)</td>
<td>84</td>
</tr>
<tr class="even">
<td>V558</td>
<td>angle(tBodyGyroJerkMean,gravityMean)</td>
<td>85</td>
</tr>
<tr class="odd">
<td>V559</td>
<td>angle(X,gravityMean)</td>
<td>86</td>
</tr>
<tr class="even">
<td>V560</td>
<td>angle(Y,gravityMean)</td>
<td>87</td>
</tr>
<tr class="odd">
<td>V561</td>
<td>angle(Z,gravityMean)</td>
<td>88</td>
</tr>
<tr class="even">
<td>V562</td>
<td>subject</td>
<td>1</td>
</tr>
<tr class="odd">
<td>V563</td>
<td>activity</td>
<td>2</td>
</tr>
</tbody>
</table>
