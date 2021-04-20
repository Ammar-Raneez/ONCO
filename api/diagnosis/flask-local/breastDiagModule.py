import glob
import os
import re
import sys
import uuid

import cv2
import matplotlib.cm as cm
import numpy as np
import tensorflow as tf
from tensorflow import keras

# Predict using the model
def model_predictBreast(img_path, model):
    IMG_SIZE = 100
    img_arr = cv2.imread(img_path, cv2.IMREAD_GRAYSCALE)
    new_arr = cv2.resize(img_arr, (IMG_SIZE, IMG_SIZE))
    new_arr = new_arr.reshape(-1, IMG_SIZE, IMG_SIZE, 1)
    prediction = model.predict([new_arr])
    return prediction

# Calculate Prediction Percentage
def calculatePredictionPercentBreast(image_path, model):
    prediction = model_predictBreast(image_path, model)

    result = int(prediction[0][0])
    # result = 0 --> Cancer
    # result = 1 --> Normal
    if(result == 0):
        return str(round(np.amax(prediction[0][0] * 100), 1))
    return str(100 - round(np.amax(prediction[0][0] * 100), 1))