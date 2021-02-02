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
from keras.applications import ResNet50V2
from keras import models, layers

def fine_tuned_resnet():
    pt_resnet = ResNet50V2(
        include_top=False,
        weights='imagenet',
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    )
    
    for layer in pt_resnet.layers[:-4]:
        layer.trainable = False
        
    ft_resnet = models.Sequential()
    ft_resnet.add(pt_resnet)
    ft_resnet.add(layers.Flatten())
    ft_resnet.add(layers.Dense(1024, activation='relu'))
    ft_resnet.add(layers.Dropout(0.8))
    ft_resnet.add(layers.Dense(2, activation='softmax'))
    
    return ft_resnet

#Resnet50V2 model
#Accuracy ==> 85.4
#Sensitivity ==> 85.8
#Specificity ==> 84.9