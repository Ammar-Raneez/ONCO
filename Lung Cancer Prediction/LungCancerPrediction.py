
# Lung Cancer Prediction using Machine Leanring

# Importing the Libraries
import numpy as np                # creating arrays for linear algebra
import pandas as pd               # used to create dataframes for data processing using the csv file
import seaborn as sns             # used for visualization
import matplotlib.pyplot as plt   # used for plotting data

from sklearn.model_selection import cross_val_score, KFold, train_test_split
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score, precision_score
from sklearn.model_selection import train_test_split


# Reading the CSV data file
dataset = pd.read_csv("LungDataSet.csv")

# Exploring the data
print(dataset.head(10))

print("Number of columns: "+str(len(dataset.columns)))
print(dataset.columns)

print(dataset.shape)    # 1000 rows and 25 columns

print(dataset.describe )

print("The max value for AirPollution is",dataset['AirPollution'].max(),"and the min value is",dataset['AirPollution'].min())
print("The max value for Alcoholuse is",dataset['Alcoholuse'].max(),"and the min value is",dataset['Alcoholuse'].min())
print("The max value for DustAllergy is",dataset['DustAllergy'].max(),"and the min value is",dataset['DustAllergy'].min())
print("The max value for OccuPationalHazards is",dataset['OccuPationalHazards'].max(),"and the min value is",dataset['OccuPationalHazards'].min())
print("The max value for GeneticRisk is",dataset['GeneticRisk'].max(),"and the min value is",dataset['GeneticRisk'].min())
print("The max value for chronicLungDisease is",dataset['chronicLungDisease'].max(),"and the min value is",dataset['chronicLungDisease'].min())
print("The max value for BalancedDiet is",dataset['BalancedDiet'].max(),"and the min value is",dataset['BalancedDiet'].min())
print("The max value for Obesity is",dataset['Obesity'].max(),"and the min value is",dataset['Obesity'].min())
print("The max value for Smoking is",dataset['Smoking'].max(),"and the min value is",dataset['Smoking'].min())
print("The max value for PassiveSmoker is",dataset['PassiveSmoker'].max(),"and the min value is",dataset['PassiveSmoker'].min())
print("The max value for ChestPain is",dataset['ChestPain'].max(),"and the min value is",dataset['ChestPain'].min())
print("The max value for CoughingofBlood is",dataset['CoughingofBlood'].max(),"and the min value is",dataset['CoughingofBlood'].min())
print("The max value for Fatigue is",dataset['Fatigue'].max(),"and the min value is",dataset['Fatigue'].min())
print("The max value for WeightLoss is",dataset['WeightLoss'].max(),"and the min value is",dataset['WeightLoss'].min())
print("The max value for ShortnessofBreath is",dataset['ShortnessofBreath'].max(),"and the min value is",dataset['ShortnessofBreath'].min())
print("The max value for Wheezing is",dataset['Wheezing'].max(),"and the min value is",dataset['Wheezing'].min())
print("The max value for SwallowingDifficulty is",dataset['SwallowingDifficulty'].max(),"and the min value is",dataset['SwallowingDifficulty'].min())
print("The max value for ClubbingofFingerNails is",dataset['ClubbingofFingerNails'].max(),"and the min value is",dataset['ClubbingofFingerNails'].min())
print("The max value for FrequentCold is",dataset['FrequentCold'].max(),"and the min value is",dataset['FrequentCold'].min())
print("The max value for DryCough is",dataset['DryCough'].max(),"and the min value is",dataset['DryCough'].min())
print("The max value for Snoring is",dataset['Snoring'].max(),"and the min value is",dataset['Snoring'].min())

# Number of people with High Prob of getting cancer
numberOfHigh = dataset.loc[dataset.Level=="High"].count()
print(numberOfHigh)     #365

# Number of people with Medium Prob of getting cancer
numberOfMedium = dataset.loc[dataset.Level=="Medium"].count()
print(numberOfMedium)   #332

# Number of people with Low Prob of getting cancer
numberOfLow = dataset.loc[dataset.Level=="Low"].count()
print(numberOfLow)  #303

# Plotting a bar graph against the number
x = ["Low","Medium", "High"]
y = [303, 332, 365]

plt.title("Distribution")
plt.ylabel("Number of records")
plt.xlabel("Level of risk")
plt.bar(x,y)
plt.show()

# Checking for any null values in the data
print(dataset.isnull().values.any())

# Cleaning data process
dataset['Gender'] = dataset['Gender'].replace(2, 0)   # 0 means Female and 1 means Male

# Data Visulization
# sns.pairplot(dataset)

# Creating the dependent and independent variables with their labels
X = dataset.drop(['Level','Patient Id'], axis=1)
y = dataset['Level']

# Performing Train Test Split
# dividing X, y into train and test data
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state = 101)

# # Predicting using the Decision Tree Classifier ( Accuracy score:  87.2 )
# from sklearn.tree import DecisionTreeClassifier
#
# dtree_model = DecisionTreeClassifier(max_depth = 2).fit(X_train, y_train)
# dtree_predictions = dtree_model.predict(X_test)
#
# # creating a confusion matrix
# confusion_mat = confusion_matrix(y_test, dtree_predictions)
# accuracy_sc = accuracy_score(y_test, dtree_predictions)
# recall_sc = recall_score(y_test, dtree_predictions, average=None)
# precision_sc = precision_score(y_test, dtree_predictions, average=None)
#
# print("Confusion matrix: " + str(confusion_mat))
# print("Accuracy score: " + str(accuracy_sc*100))
# print("Recall score: " + str(recall_sc))
# print("Precision score: " + str(precision_sc))
#
# TP = confusion_mat[1, 1]
# TN = confusion_mat[0, 0]
# FP = confusion_mat[0, 1]
# FN = confusion_mat[1, 0]
#
# sensitivity = TP/(TP+FN)
# specificity = TN/(TN+FP)
#
# print("Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity))




# Predicting using Support Vector Machine Classification ( Accuracy score: 100.0 % )
from sklearn.svm import SVC

## training a SVM classifier
svm_model_linear = SVC(kernel='linear', C=1).fit(X_train, y_train)

## Prediction using SVM
svm_predictions = svm_model_linear.predict(X_test)
print(svm_predictions)

# model accuracy for X_test
accuracy = svm_model_linear.score(X_test, y_test)

# creating a confusion matrix, calculating accuracy, calculating score, calculating precision
cm = confusion_matrix(y_test, svm_predictions)
ac = accuracy_score(y_test, svm_predictions)
rs = recall_score(y_test, svm_predictions, average=None)
ps = precision_score(y_test, svm_predictions, average=None)

print("Confusion matrix: " + str(cm))
print("Accuracy score: " + str(ac * 100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP / (TP + FN)
specificity = TN / (TN + FP)

print("Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity))





# # Predicting using KNN Classifier ( Accuracy score: 99.2 % )

# Choosing the best K value for KNN
# from sklearn.neighbors import KNeighborsClassifier 
# error_rate = []

# for i in range(1,40):  #checking from 1 to 40 for the K value
#     knn = KNeighborsClassifier(n_neighbors=i)
#     knn.fit(X_train, y_train)
#     pred_i = knn.predict(X_test)
#     error_rate.append(np.mean(pred_i != y_test)) # when the 'pred' value doesn't match with the 'y value' I get the mean of that
    
# plt.figure(figsize=(10, 6))
# plt.plot(range(1, 40), error_rate, color='blue', linestyle='dashed', marker='o', markerfacecolor='red' ,markersize=10)
# plt.title('Error Rate vs K value')
# plt.xlabel('K')
# plt.ylabel('Error Rate')

## (from the graph it's found that K=7 is the best choice of all)
# ## training a KNN classifier
# knn = KNeighborsClassifier(n_neighbors = 7).fit(X_train, y_train)
#
# ## Prediction using KNN
# knn_predictions = knn.predict(X_test)
# print(knn.predict(X_test))
#
# ## Accuracy on X_test
# accuracy = knn.score(X_test, y_test)
#
# ## Creating a confusion matrix
# cm = confusion_matrix(y_test, knn_predictions)
# ac = accuracy_score(y_test, knn_predictions)
# rs = recall_score(y_test, knn_predictions, average=None)
# ps = precision_score(y_test, knn_predictions, average=None)
#
# ## Displaying the content
# print("Confusion matrix: " + str(cm))
# print("Accuracy score: " + str(ac*100))
# print("Recall score: " + str(rs))
# print("Precision score: " + str(ps))
#
# TP = cm[1, 1]
# TN = cm[0, 0]
# FP = cm[0, 1]
# FN = cm[1, 0]
#
# sensitivity = TP/(TP+FN)
# specificity = TN/(TN+FP)
#
# print("Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity))




# # Predicting using Navie Bayes Classifier  ( Accuracy score: 88.4 )
# from sklearn.naive_bayes import GaussianNB
#
# gnb = GaussianNB().fit(X_train, y_train)
# gnb_predictions = gnb.predict(X_test)
#
# # accuracy on X_test
# accuracy = gnb.score(X_test, y_test)
#
# # creating a confusion matrix
# cm = confusion_matrix(y_test, gnb_predictions)
# ac = accuracy_score(y_test, gnb_predictions)
# rs = recall_score(y_test, gnb_predictions, average=None)
# ps = precision_score(y_test, gnb_predictions, average=None)
#
# print("Confusion matrix: " + str(cm))
# print("Accuracy score: " + str(ac * 100))
# print("Recall score: " + str(rs))
# print("Precision score: " + str(ps))
#
# TP = cm[1, 1]
# TN = cm[0, 0]
# FP = cm[0, 1]
# FN = cm[1, 0]
#
# sensitivity = TP / (TP + FN)
# specificity = TN / (TN + FP)
#
# print("Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity))


# Saving the Model using joblib

#import joblib
#joblib.dump(svm_model_linear, 'lung-cancer-pred-model')

#loadedModel = joblib.load('lung-cancer-pred-model')
#loadedModel.predict(X_test)[0]
















