Feature (variables descriptions)
================================

The features selected for this database come from the accelerometer and
gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain
signals (prefix 't' to denote time) were captured at a constant rate of
50 Hz. Then they were filtered using a median filter and a 3rd order low
pass Butterworth filter with a corner frequency of 20 Hz to remove
noise. Similarly, the acceleration signal was then separated into body
and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ)
using another low pass Butterworth filter with a corner frequency of 0.3
Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAccXYZ, fBodyAccJerkXYZ, fBodyGyroXYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for
each pattern:\
'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAccXYZ tGravityAccXYZ tBodyAccJerkXYZ tBodyGyroXYZ tBodyGyroJerkXYZ
tBodyAccMag tGravityAccMag tBodyAccJerkMag tBodyGyroMag tBodyGyroJerkMag
fBodyAccXYZ fBodyAccJerkXYZ fBodyGyroXYZ fBodyAccMag fBodyAccJerkMag
fBodyGyroMag fBodyGyroJerkMag

The set of variables that were estimated (following the instructions of
the assignment) from these signals are:

mean(): Mean value std(): Standard deviation

These variables were then averaged by subject and activity giving rise
to 66 features in total