
# # **Lung Cancer Prediction using Machine Leanring**
# ### **Importing the Libraries**

import matplotlib.pyplot as plt  # used for plotting data
import numpy as np  # creating arrays for linear algebra
import pandas as pd  # used to create dataframes for data processing using the csv file
import seaborn as sns  # used for visualization

# ### **Reading the CSV data file**
dataset = pd.read_csv("LungDataSet.csv")

# ### **Exploring the data**

dataset.head(10)

print("Number of columns: "+str(len(dataset.columns)))
print("\nThe list of available column names:")
for index in range(len(dataset.columns)):
    print(" - " + dataset.columns[index])


x = dataset.shape    # 1000 rows and 25 columns (rows, columns)

x = dataset.isnull().sum()    # checking for Null values
# There are no null values present

# I am print all these values because I will be using this in the front end to get the values from the user therefore it has to be within this range for the user input
print("The max value for AirPollution is '",dataset['AirPollution'].max(),"' and the min value is '",dataset['AirPollution'].min(), "'")
print("The max value for Alcoholuse is '",dataset['Alcoholuse'].max(),"' and the min value is '",dataset['Alcoholuse'].min() , "'")
print("The max value for DustAllergy is '",dataset['DustAllergy'].max(),"' and the min value is '",dataset['DustAllergy'].min() , "'")
print("The max value for OccuPationalHazards is '",dataset['OccuPationalHazards'].max(),"' and the min value is '",dataset['OccuPationalHazards'].min() , "'")
print("The max value for GeneticRisk is '",dataset['GeneticRisk'].max(),"' and the min value is '",dataset['GeneticRisk'].min() , "'")
print("The max value for chronicLungDisease is '",dataset['chronicLungDisease'].max(),"' and the min value is '",dataset['chronicLungDisease'].min() , "'")
print("The max value for BalancedDiet is '",dataset['BalancedDiet'].max(),"' and the min value is '",dataset['BalancedDiet'].min() , "'")
print("The max value for Obesity is '",dataset['Obesity'].max(),"' and the min value is '",dataset['Obesity'].min() , "'")
print("The max value for Smoking is '",dataset['Smoking'].max(),"' and the min value is '",dataset['Smoking'].min() , "'")
print("The max value for PassiveSmoker is '",dataset['PassiveSmoker'].max(),"' and the min value is '",dataset['PassiveSmoker'].min() , "'")
print("The max value for ChestPain is '",dataset['ChestPain'].max(),"' and the min value is '",dataset['ChestPain'].min() , "'")
print("The max value for CoughingofBlood is '",dataset['CoughingofBlood'].max(),"' and the min value is '",dataset['CoughingofBlood'].min() , "'")
print("The max value for Fatigue is '",dataset['Fatigue'].max(),"' and the min value is '",dataset['Fatigue'].min() , "'")
print("The max value for WeightLoss is '",dataset['WeightLoss'].max(),"' and the min value is '",dataset['WeightLoss'].min() , "'")
print("The max value for ShortnessofBreath is '",dataset['ShortnessofBreath'].max(),"' and the min value is '",dataset['ShortnessofBreath'].min() , "'")
print("The max value for Wheezing is '",dataset['Wheezing'].max(),"' and the min value is '",dataset['Wheezing'].min() , "'")
print("The max value for SwallowingDifficulty is '",dataset['SwallowingDifficulty'].max(),"' and the min value is '",dataset['SwallowingDifficulty'].min() , "'")
print("The max value for ClubbingofFingerNails is '",dataset['ClubbingofFingerNails'].max(),"' and the min value is '",dataset['ClubbingofFingerNails'].min() , "'")
print("The max value for FrequentCold is '",dataset['FrequentCold'].max(),"' and the min value is '",dataset['FrequentCold'].min() , "'")
print("The max value for DryCough is '",dataset['DryCough'].max(),"' and the min value is '",dataset['DryCough'].min() , "'")
print("The max value for Snoring is '",dataset['Snoring'].max(),"' and the min value is '",dataset['Snoring'].min() , "'")


# ### **Creating the dependent and independent variables with their labels**
from sklearn.model_selection import KFold, cross_val_score, train_test_split

X = dataset.drop(['Level','Patient Id'], axis=1)
y = dataset['Level']


# ### **Number of people with High, Medium and Low Prob of getting cancer**

from collections import Counter

counts = Counter(y)
label_count_list = list(counts.values())
print(counts)
print("These are the values: ", list(counts.values()))


# #### With the above result we can see clearly that there is a little bit of imbalance which is not and issue but lets still do some oversampling later

# ### **Plotting a bar graph against the target feature "Label" (before oversampling)**
# 

prediction_classes = ["Low","Medium", "High"]
count_of_prediction_classes = [303, 332, 365]
totalRecords = sum(count_of_prediction_classes)

plt.title("Distribution")
plt.ylabel("Number of records")
plt.xlabel("Level of risk")
plt.bar(prediction_classes,count_of_prediction_classes)
plt.show()


# Getting the percentage of the predicted classes 
percentage_of_low_counts = (count_of_prediction_classes[0]/totalRecords) * 100
percentage_of_medium_counts = (count_of_prediction_classes[1]/totalRecords) * 100
percentage_of_high_counts = (count_of_prediction_classes[2]/totalRecords) * 100
print("Percentage of low class counts: %1d \nPercentage of medium class counts: %2d \nPercentage of high class counts: %3d" %(percentage_of_low_counts, percentage_of_medium_counts, percentage_of_high_counts))


# ### Oversampling the data to be exactly equally balanced

# Current shape of the High, Medium, Low data
high = dataset[dataset['Level'] == "High"]
low = dataset[dataset['Level'] == "Low"]
medium = dataset[dataset['Level'] == "Medium"]

print("Shape of high", high.shape, "\nShape of Medium", medium.shape, "\nShape of Low", low.shape)

# importing the necessary library for Oversampling the data
from imblearn.combine import SMOTETomek

# Implementing Oversampling for Handling Imbalanced data
smk = SMOTETomek(random_state = 42)
X_res, y_res = smk.fit_sample(X, y)

print()
print("This was the shape before Oversampling: ", X.shape)
print("This was the shape after Oversampling: ", X_res.shape) # 95 new records have been added to make all the data balanced


# ### **Number of people with High, Medium and Low Prob of getting cancer (after oversampling)**

counts = Counter(y_res)
label_count_list = list(counts.values())
print(counts)
print("These are the values: ", list(counts.values()))


# ### **Plotting a bar graph against the new target label dataset (after oversampling)**
# 

prediction_classes = ["Low","Medium", "High"]
count_of_prediction_classes = [365, 365, 365]
totalRecords = sum(count_of_prediction_classes)

plt.title("Distribution")
plt.ylabel("Number of records")
plt.xlabel("Level of risk")
plt.bar(prediction_classes,count_of_prediction_classes)
plt.show()

# Getting the percentage of the predicted classes 
percentage_of_low_counts = (count_of_prediction_classes[0]/totalRecords) * 100
percentage_of_medium_counts = (count_of_prediction_classes[1]/totalRecords) * 100
percentage_of_high_counts = (count_of_prediction_classes[2]/totalRecords) * 100

print("Percentage of low class counts: ", round(percentage_of_low_counts, 1),"%")
print("Percentage of medium class counts: ", round(percentage_of_medium_counts, 1),"%")
print("Percentage of high class counts: ", round(percentage_of_high_counts, 1),"%")


# ### **Cleaning data process**
dataset['Gender'] = dataset['Gender'].replace(2, 0)   # 0 means Female and 1 means Male


# ### **Data Visulization**
#sns.pairplot(dataset)


# ### **Performing Train Test Split**

from sklearn.metrics import (accuracy_score, confusion_matrix, precision_score,
                             recall_score)

# dividing X_res, y_res into train and test data 
X_train, X_test, y_train, y_test = train_test_split(X_res, y_res, random_state = 101) 


# ### **Predicting using the Descision Tree Classifier**

# training a DescisionTreeClassifier ( Accuracy score:  78.8% )
from sklearn.tree import DecisionTreeClassifier

dtree_model = DecisionTreeClassifier(max_depth = 2).fit(X_train, y_train) 
dtree_predictions = dtree_model.predict(X_test) 

# creating a confusion matrix 
cm = confusion_matrix(y_test, dtree_predictions) 
ac = accuracy_score(y_test, dtree_predictions)
rs = recall_score(y_test, dtree_predictions, average=None)
ps = precision_score(y_test, dtree_predictions, average=None)

print("Confusion matrix: " + str(cm))
print("Accuracy score: " + str(ac*100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

"Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity)


# ### **Predicting using Support Vector Machine Classification**

# training a linear SVM classifier ( Accuracy score: 100.0 % )
from sklearn.svm import SVC

## training a SVM classifier 
svm_model_linear = SVC(kernel = 'linear', C = 1).fit(X_train, y_train) 

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
print("Accuracy score: " + str(ac*100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

"Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity)


# ### **Predicting using KNN Classifier**

# ### Choosing the best K value for KNN 


from sklearn.neighbors import KNeighborsClassifier

error_rate = []

for i in range(1,40):  #checking from 1 to 40 for the K value
    knn = KNeighborsClassifier(n_neighbors=i)
    knn.fit(X_train, y_train)
    pred_i = knn.predict(X_test)
    error_rate.append(np.mean(pred_i != y_test)) # when the 'pred' value doesn't match with the 'y value' I get the mean of that

plt.figure(figsize=(10, 6))
plt.plot(range(1, 40), error_rate, color='blue', linestyle='dashed', marker='o', markerfacecolor='red' ,markersize=10)
plt.title('Error Rate vs K value')
plt.xlabel('K')
plt.ylabel('Error Rate')


## Training a KNN classifier ( Accuracy score: 99.3 % )

## training a KNN classifier  (from the graph it's found that K=7 is the best choice of all)
knn = KNeighborsClassifier(n_neighbors = 7).fit(X_train, y_train) 

## Prediction using KNN
knn_predictions = knn.predict(X_test)  
print(knn.predict(X_test))

## Accuracy on X_test 
accuracy = knn.score(X_test, y_test) 

## Creating a confusion matrix 
cm = confusion_matrix(y_test, knn_predictions) 
ac = accuracy_score(y_test, knn_predictions)
rs = recall_score(y_test, knn_predictions, average=None)
ps = precision_score(y_test, knn_predictions, average=None)

## Displaying the content
print("Confusion matrix: " + str(cm))
print("Accuracy score: " + str(ac*100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

"Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity)


# ### **Predicting using Navie Bayes Classifier**

# training a Naive Bayes classifier ( Accuracy score: 86.9 )
from sklearn.naive_bayes import GaussianNB

gnb = GaussianNB().fit(X_train, y_train) 
gnb_predictions = gnb.predict(X_test) 
  
# accuracy on X_test 
accuracy = gnb.score(X_test, y_test) 
  
# creating a confusion matrix 
cm = confusion_matrix(y_test, gnb_predictions) 
ac = accuracy_score(y_test, gnb_predictions)
rs = recall_score(y_test, gnb_predictions, average=None)
ps = precision_score(y_test, gnb_predictions, average=None)

print("Confusion matrix: " + str(cm))
print("Accuracy score: " + str(ac*100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

"Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity)


# ### **Predicting using Random Forest Classifier**

# Training with a Random Forest Classifier ( Accuracy score: 100%)
from sklearn.ensemble.forest import RandomForestClassifier

randomForestModel = RandomForestClassifier().fit(X_train, y_train) 
randomForestModel_predictions = randomForestModel.predict(X_test) 
  
# accuracy on X_test 
accuracy = randomForestModel.score(X_test, y_test) 
  
# creating a confusion matrix 
cm = confusion_matrix(y_test, randomForestModel_predictions) 
ac = accuracy_score(y_test, randomForestModel_predictions)
rs = recall_score(y_test, randomForestModel_predictions, average=None)
ps = precision_score(y_test, randomForestModel_predictions, average=None)

print("Confusion matrix: " + str(cm))
print("Accuracy score: " + str(ac*100))
print("Recall score: " + str(rs))
print("Precision score: " + str(ps))

TP = cm[1, 1]
TN = cm[0, 0]
FP = cm[0, 1]
FN = cm[1, 0]

sensitivity = TP/(TP+FN)
specificity = TN/(TN+FP)

"Sensitivity: {} | Specifictity: {}".format(sensitivity, specificity)


# ### Saving the Model using joblib

import joblib

joblib.dump(svm_model_linear, 'lung-cancer-pred-model.pkl')

loadedModel = joblib.load('lung-cancer-pred-model.pkl')

new_test = [[44,5.2,5.5,5.5,5.5,5.5,5.3,1.3,1.3,1.3,5.6,1.6,1.6,1.8,5.8,1.7,1.7,5.7,1.1,1.2,5.9,1.0,5.4]]

x = loadedModel.predict(new_test)[0]
