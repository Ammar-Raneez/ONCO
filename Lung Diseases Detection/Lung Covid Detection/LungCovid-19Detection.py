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
