import numpy as np 
import pandas as pd 
from keras import layers, models
from keras.applications import InceptionV3

from utils import *
from ImageGenerator import *


def finetuned_inception():
    pt_inception = InceptionV3(
        include_top=False,
        weights='imagenet',
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    )
        
    for layer in pt_inception.layers[:-4]:
        layer.trainable = False
        
    ft_inception = models.Sequential()
    ft_inception.add(pt_inception)
    ft_inception.add(layers.Flatten())
    ft_inception.add(layers.Dense(1024, activation='relu'))
    ft_inception.add(layers.Dropout(0.8))
    ft_inception.add(layers.Dense(9, activation='softmax'))
    
    return ft_inception

