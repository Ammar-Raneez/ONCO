import os
from utils import *
from ImageGenerator import *
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from PIL import Image
from ImageSplit import *
from keras.utils.np_utils import to_categorical

#Normalize (Rescale data to same range)
X_train, X_test = X_train/255, X_test/255

#one hot encode the labels
y_train = to_categorical(y_train, num_classes= 2)
y_train

#the model
from keras.applications import VGG16
from keras import models, layers

def fine_tuned_vgg():
    pt_vgg = VGG16(
        include_top=False,
        weights='imagenet',
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    )
    
    for layer in pt_vgg.layers[:-4]:
        layer.trainable = False
        
    ft_vgg = models.Sequential()
    ft_vgg.add(pt_vgg)
    ft_vgg.add(layers.Flatten())
    ft_vgg.add(layers.Dense(1024, activation='relu'))
    ft_vgg.add(layers.Dropout(0.8))
    ft_vgg.add(layers.Dense(2, activation='softmax'))
    
    return ft_vgg

#VGG16 model
#Accuracy ==> 85.6
#Sensitivity ==> 87.1
#Specificity ==> 83.8