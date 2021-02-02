#!/usr/bin/env python
# coding: utf-8

# In[4]:


import os
import numpy as np
from PIL import Image
from utils import *

read = lambda imname: np.asarray(Image.open(imname).convert("RGB"))

# Load in training pictures 
img_benign = [read(os.path.join(TRAIN_BENIGN_FOLDER, filename)) for filename in os.listdir(TRAIN_BENIGN_FOLDER)]
X_benign = np.array(img_benign, dtype='uint8')

img_malignant = [read(os.path.join(TRAIN_MALIGNANT_FOLDER, filename)) for filename in os.listdir(TRAIN_MALIGNANT_FOLDER)]
X_malignant = np.array(img_malignant, dtype='uint8')

# Load in testing pictures
img_benign = [read(os.path.join(TEST_BENIGN_FOLDER, filename)) for filename in os.listdir(TEST_BENIGN_FOLDER)]
X_benign_test = np.array(img_benign, dtype='uint8')

img_malignant = [read(os.path.join(TEST_MALIGNANT_FOLDER, filename)) for filename in os.listdir(TEST_MALIGNANT_FOLDER)]
X_malignant_test = np.array(img_malignant, dtype='uint8')

# Create labels
y_benign = np.zeros(X_benign.shape[0])
y_malignant = np.ones(X_malignant.shape[0])

y_benign_test = np.zeros(X_benign_test.shape[0])
y_malignant_test = np.ones(X_malignant_test.shape[0])


# Merge data 
X_train = np.concatenate((X_benign, X_malignant), axis = 0)
y_train = np.concatenate((y_benign, y_malignant), axis = 0)

X_test = np.concatenate((X_benign_test, X_malignant_test), axis = 0)
y_test = np.concatenate((y_benign_test, y_malignant_test), axis = 0)

# Shuffle data
s = np.arange(X_train.shape[0])
np.random.shuffle(s)
X_train = X_train[s]
y_train = y_train[s]

s = np.arange(X_test.shape[0])
np.random.shuffle(s)
X_test = X_test[s]
y_test = y_test[s]

