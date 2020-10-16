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

## Exploratory Data Analysis
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

# Count plot for 3 target variables without the "unknown" used instead of the NaN value present(so NaN value are present)
fig, ax = plt.subplots(2, 2, figsize=(20, 10))
sns.countplot(x=targets[0], data=train_data, ax=ax[0, 0]) # this targets the feature 'label'
sns.countplot(x=targets[1], data=train_data, ax=ax[0, 1]) # this targets the feature 'Label_2_Virus_category'
sns.countplot(x=targets[2], data=train_data, ax=ax[1, 0]) # this targets the feature 'Label_1_Virus_category'
plt.show()

# Displaying the results.

print(f"Label = Normal Cases : {train_data[train_data['Label'] == 'Normal'].shape[0]}") # normal cases

print(f"""Label = Pnemonia + Label_2_Virus_category = COVID-19 cases : {train_data[(train_data['Label'] == 'Pnemonia')
      & (train_data['Label_2_Virus_category'] == 'COVID-19')].shape[0]}""")     # Pnemonia and COVID-19 cases

print(f"""Label = Normal + Label_2_Virus_category = COVID-19 cases : {train_data[(train_data['Label'] == 'Normal')
      & (train_data['Label_2_Virus_category'] == 'COVID-19')].shape[0]}""")     # Normal and COVID-19 cases


## Analysis of Image files

# setting the path of the test and the train dataset folders from my local pc in root folder
TEST_FOLDER = 'dataset/test'
TRAIN_FOLDER = 'dataset/train'

# Taking sample train images from the folder location specified
sample_train_images = list(os.walk(TRAIN_FOLDER))[0][2][:8]
sample_train_images = list(map(lambda x: os.path.join(TRAIN_FOLDER, x), sample_train_images))

# Taking sample test images from the folder location specified
sample_test_images = list(os.walk(TEST_FOLDER))[0][2][:8]
sample_test_images = list(map(lambda x: os.path.join(TEST_FOLDER, x), sample_test_images))  # Taking sample test images

# Plotting the sample training data (train images)
plt.figure(figsize=(20, 20))

for iterator, filename in enumerate(sample_train_images):
    image = Image.open(filename)
    plt.subplot(4, 2, iterator+1)
    plt.axis('off')
    plt.imshow(image)


plt.tight_layout()

# Plotting the sample test data (test images)
plt.figure(figsize=(20, 20))

for iterator, filename in enumerate(sample_test_images):
    image = Image.open(filename)
    plt.subplot(4, 2, iterator+1)
    plt.axis('off')
    plt.imshow(image)


plt.tight_layout()


## Image Histograms

# Plot black/white image histograms of "Label_2_Virus_category" type "COVID-19" patients
fig, ax = plt.subplots(4, 2, figsize=(20, 20))

covid19_type_file_paths = train_data[train_data['Label_2_Virus_category'] == 'COVID-19']['X_ray_image_name'].values
sample_covid19_file_paths = covid19_type_file_paths[:4]
sample_covid19_file_paths = list(map(lambda x: os.path.join(TRAIN_FOLDER, x), sample_covid19_file_paths))

for row, file_path in enumerate(sample_covid19_file_paths):
    image = plt.imread(file_path)
    ax[row, 0].imshow(image)
    ax[row, 1].hist(image.ravel(), 256, [0,256])
    ax[row, 0].axis('off')
    if row == 0:
        ax[row, 0].set_title('Images')
        ax[row, 1].set_title('Histograms')
fig.suptitle('Label 2 Virus Category = COVID-19', size=16)
plt.show()

# Plot black/white image histograms of Label type "Normal" patients
fig, ax = plt.subplots(4, 2, figsize=(20, 20))

other_type_file_paths = train_data[train_data['Label'] == 'Normal']['X_ray_image_name'].values
sample_other_file_paths = other_type_file_paths[:4]
sample_other_file_paths = list(map(lambda x: os.path.join(TRAIN_FOLDER, x), sample_other_file_paths))

for row, file_path in enumerate(sample_other_file_paths):
    image = plt.imread(file_path)
    ax[row, 0].imshow(image)
    ax[row, 1].hist(image.ravel(), 256, [0,256])
    ax[row, 0].axis('off')
    if row == 0:
        ax[row, 0].set_title('Images')
        ax[row, 1].set_title('Histograms')
fig.suptitle('Label = Normal', size=16)
plt.show()

## Image Agumentation

# Sort out the file names to be worked on
# Generate the final train data from original train data with conditions refered from EDA inference
# We are classifying 'normal' and '(Pnemonia & COVID-19)'
final_train_data = train_data[(train_data['Label'] == 'Normal') |
                              ((train_data['Label'] == 'Pnemonia') & (train_data['Label_2_Virus_category'] == 'COVID-19'))]


# Create a target attribute where value = positive if 'Pnemonia + COVID-19' or value = negative if 'Normal'
final_train_data['target'] = ['negative' if holder == 'Normal' else 'positive' for holder in final_train_data['Label']]

final_train_data = shuffle(final_train_data, random_state=1)

final_validation_data = final_train_data.iloc[1000:, :]
final_train_data = final_train_data.iloc[:1000, :]

print(f"Final train data shape : {final_train_data.shape}")
final_train_data.sample(10)

# We perform Image Agumentation 

# train_image_generator
train_image_generator = ImageDataGenerator(
    rescale=1./255,
    featurewise_center=True,
    featurewise_std_normalization=True,
    rotation_range=90,
    width_shift_range=0.15,
    height_shift_range=0.15,
    horizontal_flip=True,
    zoom_range=[0.9, 1.25],
    brightness_range=[0.5, 1.5]
)

# test_image_generator
test_image_generator = ImageDataGenerator(
    rescale=1./255
)

train_generator = train_image_generator.flow_from_dataframe(
    dataframe=final_train_data,
    directory=TRAIN_FOLDER,
    x_col='X_ray_image_name',
    y_col='target',
    target_size=(224, 224),
    batch_size=8,
    seed=2020,
    shuffle=True,
    class_mode='binary'
)

validation_generator = train_image_generator.flow_from_dataframe(
    dataframe=final_validation_data,
    directory=TRAIN_FOLDER,
    x_col='X_ray_image_name',
    y_col='target',
    target_size=(224, 224),
    batch_size=8,
    seed=2020,
    shuffle=True,
    class_mode='binary'
)

test_generator = test_image_generator.flow_from_dataframe(
    dataframe=test_data,
    directory=TEST_FOLDER,
    x_col='X_ray_image_name',
    target_size=(224, 224),
    shuffle=False,
    batch_size=16,
    class_mode=None
)













