#!/usr/bin/env python
# coding: utf-8

# In[1]:


import tensorflow as tf

import keras.backend as K
from keras.models import Sequential
from keras.layers import Dense
from keras.optimizers import Adam
from keras.callbacks import EarlyStopping
from keras.utils import to_categorical
import keras

from keras.layers import BatchNormalization
from keras.layers import Dropout
from keras import regularizers

import sklearn
from sklearn import preprocessing, datasets, metrics
from sklearn.model_selection import train_test_split

import numpy as np
import pandas as pd

import seaborn as sns
import matplotlib
from matplotlib import pyplot as plt
get_ipython().run_line_magic('matplotlib', 'inline')
get_ipython().run_line_magic('config', "InlineBackend.figure_format = 'retina'")


# In[2]:


#display top 5 rows of the csv file
heart_data = pd.read_csv("heart.csv")
heart_data.head()


# In[3]:


#checking for any null values
heart_data.isnull().sum()


# In[4]:


#Checking whether data is balanced
heart_data['target'].value_counts()


# In[5]:


#Data is pretty balanced
sns.countplot(heart_data['target'], label='count')


# In[6]:


#Checking datatypes - any non-numerical data must be encoded
heart_data.dtypes


# In[7]:


sns.pairplot(heart_data.iloc[:, -4:], hue='target')


# In[8]:


#Checking correlation between columns
heart_data.iloc[:,0:].corr()


# In[9]:


#heatmap that visualizes the correlation
plt.figure(figsize=(15, 15))
sns.heatmap(heart_data.iloc[:, 0:].corr(), annot=True, fmt='.0%')


# In[11]:


#splitting the csv data into inputs and labels
X = heart_data.iloc[:,0:-1]
y = heart_data.iloc[:,-1]
X


# In[12]:


X = X.values
y = y.values


# In[13]:


#split data into 75%, 25% train and test
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.25, random_state=0)


# In[14]:


#scale data to bring all values to same range
from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.fit_transform(X_test)

X_train


# In[15]:


def model(X_train, y_train):
    #Logistic Regression
    from sklearn.linear_model import LogisticRegression
    logistic_reg = LogisticRegression(random_state = 0)
    logistic_reg.fit(X_train, y_train)
    
    #Decision Tree
    from sklearn.tree import DecisionTreeClassifier
    decision_tree = DecisionTreeClassifier(criterion='entropy', random_state = 0)
    decision_tree.fit(X_train, y_train)
    
    #Support Vector Machines
    from sklearn import svm
    support_vm = svm.SVC(kernel='linear', C=1)
    support_vm.fit(X_train, y_train)
    
    #Random Forest
    from sklearn.ensemble import RandomForestClassifier
    random_for = RandomForestClassifier(n_estimators = 10, criterion='entropy', random_state = 0)
    random_for.fit(X_train, y_train)
    
    #Print model accuracy for the training data
    print("Logistic Regression Training Accuracy:", logistic_reg.score(X_train, y_train))
    print("Decision Tree Training Accuracy:", decision_tree.score(X_train, y_train))
    print("SVM Training Accuracy:", support_vm.score(X_train, y_train))
    print("Random Forest Training Accuracy:", random_for.score(X_train, y_train))
    
    return logistic_reg, decision_tree, support_vm, random_for


# In[16]:


#getting all of the models
all_models = model(X_train, y_train)


# In[17]:


#Test data on the confusion matrix
#Combines the Sensitivity, Specificity and the Positive/ Negative Predicted Value(PPV/ NPV)
from sklearn.metrics import confusion_matrix

models = ["Logistic Regression", "Decision Tree", "SVM", "Random Forest"]

for i in range(len(all_models)):
    print("Model:", models[i])
    model_cm = confusion_matrix(y_test, all_models[i].predict(X_test))
    
    model_TP = model_cm[0][0]
    model_TN = model_cm[1][1]
    model_FN = model_cm[1][0]
    model_FP = model_cm[0][1]
    
    print(model_cm)
    print("Testing Accuracy:", (model_TP + model_TN) / (model_TP + model_TN + model_FP + model_FN))
    print("Sensitivity:", (model_TP) / (model_TP + model_FN))
    print("Specificity:", (model_TN) / (model_TN + model_FP))
    print()


# In[18]:


from sklearn.metrics import classification_report
from sklearn.metrics import accuracy_score

for i in range(len(all_models)):
    print("Model:", models[i])
    print(classification_report(y_test, all_models[i].predict(X_test)))
    print(accuracy_score(y_test, all_models[i].predict(X_test)))
    print()


# In[19]:


#print predictions of the best classifier - random forest | decision tree as well
#however since random forest is an average of decision trees its better to pick
#randmom forests
predictions = all_models[-1].predict(X_test)
print(predictions)
print()
print(y_test)


# In[20]:


import pickle
with open("Best-Model-Random-Forest.pickle", "wb") as f:
    pickle.dump(all_models[-1], f)

