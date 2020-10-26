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

# setting the train and test path files
train_path = 'cell_images/Train'
test_path = 'cell_images/Test'

# Add preprocessing layer to front
vgg = VGG19(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top=False)

# NOT training the existing the weights because the weights are already trained and this is the use of transfer learning
for layer in vgg.layers:
    layer.trainable = False

# Getting the number of classes from our dataset
folders = glob('cell_images/Train/*')
folders


# Flattening all the previous layers
x = Flatten()(vgg.output)


# Adding my 2 categories dense layers into the last layer of the vgg19 (The variable folders contain the location of my 2 categories)
prediction = Dense(len(folders), activation='softmax')(x) 

# softmax activation function is just like a sigmod activation function which will make your value fall between 0 to 1 



# create a model object
model = Model(inputs=vgg.input, outputs=prediction)


# view the structure of the model
model.summary()


# telling the model what loss and optimization functions has to be used along with the type of metrics
model.compile(
    loss = 'categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)


















    

