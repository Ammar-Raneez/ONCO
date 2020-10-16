# COVID-19 Classifier from X-Ray Images

## Tasks to complete
# 1. Exploratory Data Analysis
# 2. Image augumentation
# 3. Base CNN model accuracy calculation
# 4. Base CNN model with lower imbalance data
# 5. RESNET 50 model accuracy calculation
# 6. EfficientNet B4 accuracy calculation
# 7. AUC Score comparision
# 8. Final result

## Importing libraries
import numpy as np      # linear algebra
import pandas as pd     # data processing, CSV file I/O (e.g. pd.read_csv)
import matplotlib.pyplot as plt
import seaborn as sns

from PIL import Image
import warnings
warnings.filterwarnings('ignore')

from sklearn.utils import shuffle

from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
from keras.layers import Conv2D, MaxPooling2D, Dense, Dropout, Flatten
from keras.optimizers import Adam
from keras.losses import binary_crossentropy
from keras.callbacks import LearningRateScheduler
from keras.metrics import *


ACCURACY_LIST = []
from keras.applications.resnet50 import ResNet50
from keras.layers import GlobalMaxPooling2D
from keras.models import Model

from keras import backend as K

# Get reproducible results
from numpy.random import seed
seed(1)
import tensorflow as tf
tf.random.set_seed(1)

import os


## Reading the csv files
metadata = pd.read_csv('Chest_xray_Corona_Metadata.csv')
summary = pd.read_csv('Chest_xray_Corona_dataset_Summary.csv')

metadata.sample(10)   # reads randomly 10 data samples

train_data = metadata[metadata['Dataset_type'] == 'TRAIN'] # Extracting all the 'Train' data
test_data = metadata[metadata['Dataset_type'] == 'TEST']   # Extarcting all the 'Test' data

print(f"Shape of train data : {train_data.shape}")  # training data 5286 rows
print(f"Shape of test data : {test_data.shape}")    # testing data 624 rows
test_data.sample(10)

## c
# Null value calculation
print(f"Count of null values in train :\n{train_data.isnull().sum()}")
print(f"Count of null values in test :\n{test_data.isnull().sum()}")

# Substitute null values with string unknown
train_fill = train_data.fillna('unknown')  # train_fill contains new train data with null replace to 'unknown'
test_fill = test_data.fillna('unknown')    # test_fill contains new test data with null replace to 'unknown'

train_fill.sample(10)  # displaying the train_fill data

# Count plot for 3 attributes with the addition of "unknown"
targets = ['Label', 'Label_2_Virus_category', 'Label_1_Virus_category']

fig, ax = plt.subplots(2, 2, figsize=(20, 10))
sns.countplot(x=targets[0], data=train_fill, ax=ax[0, 0]) # this targets the feature 'label'
sns.countplot(x=targets[1], data=train_fill, ax=ax[0, 1]) # this targets the feature 'Label_2_Virus_category'
sns.countplot(x=targets[2], data=train_fill, ax=ax[1, 0]) # this targets the feature 'Label_1_Virus_category'
plt.show()

# Pie chart representation of Label_2_Virus_category values

colors = ['#ff5733', '#33ff57']   # colors for the representation used
explode = [0.02, 0.02]            # Giving the shape for the pie chart

values = ['unknown', 'other']

# getting the percentage of "unknown" and not unknown values from the 'Label_2_Virus_category' feature from the data
percentages = [100 * (train_fill[train_fill[targets[1]] == 'unknown'].shape[0]) / train_fill.shape[0],
              100 * (train_fill[train_fill[targets[1]] != 'unknown'].shape[0]) / train_fill.shape[0]]

fig1, ax1 = plt.subplots(figsize=(7, 7))   # setting the chart size

# plotting the pie chart
plt.pie(percentages, colors=colors, labels=values,
        autopct='%1.1f%%', startangle=0, explode=explode)

fig = plt.gcf()
centre_circle = plt.Circle((0,0),0.70,fc='white')
fig.gca().add_artist(centre_circle)

ax1.axis('equal')
plt.tight_layout()
plt.title('Percentage of "unknown" values present in Label_2_Virus_category')
plt.show()








