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
