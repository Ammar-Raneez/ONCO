#
# The dataset used for this model can be found from the link below
# https://www.kaggle.com/iarunava/cell-images-for-detecting-malaria
#

# MALARIA DETECTION
#
#   This Model is made with a Dataset containing images of blood samples.
#   The user is required to upload an image of the blood sample.
#   The result will be classified into either infected or non infected.
#

# Importing the libraries

from keras.layers import Input, Lambda, Dense, Flatten
from keras.models import Model
from keras.applications.vgg19 import VGG19
from keras.preprocessing import image
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
import numpy as np
from glob import glob
import matplotlib.pyplot as plt

# re-size all the images
IMAGE_SIZE = [224, 224]
