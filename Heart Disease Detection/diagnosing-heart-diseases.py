#Importing Libraries

import numpy as np
import pandas as pd                     # reading csv file
import matplotlib.pyplot as plt 
import seaborn as sns                   #for plotting
​
from sklearn.ensemble import RandomForestClassifier             #for the model
from sklearn.tree import DecisionTreeClassifier
​
from sklearn.metrics import classification_report          #for model evaluation
from sklearn.metrics import confusion_matrix             #for model evaluation
from sklearn.model_selection import train_test_split     #for data splitting
​
#Reading the Data from the file
data = pd.read_csv('heart.csv')

#Reading the first 10 rows of the file
data.head(10)
data.head(10)

#Reading 10 random samples from the file
data.sample(10)

#Reading the columns of the table
data.columns

#Total number of rows in the csv file
data.shape    # 303 records

# checking if the data set is balanced
numberOfPosPatients = data.loc[data.target == 1].count()
numberOfNegPatients = data.loc[data.target == 0].count()
print("Positive count " + str(numberOfPosPatients))
print("Negative count " + str(numberOfNegPatients))


#Plotting a bar graph against the number
x = [0,1]
y = [138, 165]
​
plt.title("Distribution")
plt.ylabel("Number of records")
plt.xlabel("Targets")
plt.bar(x,y)
plt.show()


#Creating the dependent and independent variables with their labels
X_train, X_test, y_train, y_test = train_test_split(data.drop('target', 1), data['target'], test_size = .2, random_state=10) #split the data
X_train.shape, y_train.shape, X_test.shape, y_test.shape     # 303 rows

#Implementing Oversampling for handling Imbalanced data
from imblearn.combine import SMOTETomek
smk = SMOTETomek(random_state=69)
X_train, y_train = smk.fit_sample(X_train, y_train)
X_test, y_test = smk.fit_sample(X_test, y_test)
X_train.shape, y_train.shape, X_test.shape, y_test.shape


#Changing the column names to a more clearer name
data.columns = ['age', 'sex', 'chest_pain_type', 'resting_blood_pressure', 'cholesterol', 'fasting_blood_sugar', 'rest_ecg', 'max_heart_rate_achived',
       'exercise_induced_angina', 'st_depression', 'st_slope', 'num_major_vessels', 'thalassemia', 'target']
data.columns  # columns are now changed to a meaningful set of columns


data.sample(10)

data.dtypes

#Exploratory Data Analysis

plt.plot(data['age'].value_counts().sort_index())
plt.figure(figsize=(15,4))
plt.show()


sns.pairplot(data)




































