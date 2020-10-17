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


cancer_data = pd.read_csv("breast-cancer.csv")
#drop unnamed column that has all missing values
cancer_data = cancer_data.dropna(axis=1)


#encode the diagnosis column to 1/0 from M/B
labelencoder_Y = preprocessing.LabelEncoder()
#encode the values of the second column
cancer_data.iloc[:,1] = labelencoder_Y.fit_transform(cancer_data.iloc[:,1].values)
#Remove unnecessary id column
cancer_data.drop("id", axis='columns', inplace=True)


#Split datasets into x and y
X = cancer_data.iloc[:,1:]
Y = cancer_data.iloc[:,0]


#scale input data - bring all data to similar scale
X = preprocessing.scale(X)


#split input into training and testing as well as output
#splitting with 85% training and 20% testing
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2)


#define a sequence of layers
model = Sequential()
#an arbritary amount of neurons (15), input_shape = no of features, relu performs more better than relu for hidden layers
model.add(Dense(15, input_shape=(30,), activation='relu'))
#output layer must be sigmoid cuz it needs to classify between 2 classes (0 or 1 - benign or malignant)
#we use only 1 neuron cuz it will only have one final output (1 or 0)
model.add(Dense(1, activation='sigmoid'))

#compile model - binary classification problem (2 class problem)
#adam is an on optimizer than combines both momentum and
model.compile(loss='binary_crossentropy', optimizer=Adam(lr=0.001), metrics=['accuracy'])


#early stopping monitors the training epochs and stops the training b4 any overfitting
earlystopper = EarlyStopping(monitor='val_loss', min_delta=0, patience=15, verbose=1, mode='auto')


#train model for 2000 epochs
history = model.fit(X_train, y_train, epochs=2000, validation_split=0.15, verbose=1, callbacks=[earlystopper])
history_performance = history.history


#calculate loss and accuracy of testing data
#correct/total
loss, accuracy = model.evaluate(X_test, y_test)
print("Test Loss:", loss)
print("Test Accuracy:", accuracy)


#Creating the ROC curve to visualize sensitivity n specificity
from sklearn.metrics import roc_curve    #roc curve and ared under curve
from sklearn.metrics import auc

y_test_pred = model.predict(X_test)
#calculate false positives and true positives
fps, tps, thresholds = roc_curve(y_test, y_test_pred)

auc_keras = auc(fps, tps)
print("Testing data AUC", auc_keras)





# %%
