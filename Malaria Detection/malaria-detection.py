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


# Use the Image Data Generator to import the images from the dataset'
train_datagen = ImageDataGenerator(rescale=1./255,
                                  shear_range=0.2,
                                   zoom_range=0.2,
                                   horizontal_flip=True
                                  )

# scaling down all my images by turning all the pixel values from 0 to 1
test_datagen = ImageDataGenerator(rescale=1./255)

training_set = train_datagen.flow_from_directory('cell_images/Train/',
                                                target_size = (224, 224),
                                                batch_size=32,
                                                class_mode='categorical')
# class_mode is set to categorical because it has 2 classes 'Parasitized' and 'Uninfected'

test_set = test_datagen.flow_from_directory('cell_images/Test/',
                                                target_size = (224, 224),
                                                batch_size=32,
                                                class_mode='categorical')




# Fit the model
result = model.fit_generator(
    training_set,
    validation_data=test_set,
    epochs=10,
    steps_per_epoch=len(training_set),
    validation_steps = len(test_set)
)



# Plotting the loss values with the validation loss values
plt.plot(result.history['loss'], label='train loss')
plt.plot(result.history['val_loss'], label='val loss')
plt.legend()
plt.show()


# Plotting the accuracy values with the validation accuracy values
plt.plot(result.history['accuracy'], label='train acc')
plt.plot(result.history['val_accuracy'], label='val acc')
plt.legend()
plt.show()


# USING XCEPTION TO CREATE THE MODEL
from keras.applications.xception import Xception

xcep = Xception(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top = False)

for layer in xcep.layers:
    layer.trainable = False

x2 = Flatten()(xcep.output)

prediction = Dense(len(folders), activation='softmax')(x2)

model2 = Model(inputs=xcep.input, outputs=prediction)

model2.summary()

model2.compile(
    loss='categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)

result2 = model2.fit_generator(
    training_set,
    validation_data=test_set,
    epochs=20,
    steps_per_epoch=len(training_set),
    validation_steps=len(test_set)
)

# result for the 10 epoch
# loss: 0.5618 - accuracy: 0.9390 - val_loss: 0.7285 - val_accuracy: 0.9200

# result for the 20 epoch
# loss: 0.5789 - accuracy: 0.9420 - val_loss: 0.7598 - val_accuracy: 0.9300


plt.plot(result.history['loss'], label='train loss')
plt.plot(result.history['val_loss'], label='val loss')
plt.legend()
plt.show()
plt.savefig('LossVal_loss')



plt.plot(result.history['accuracy'], label='train acc')
plt.plot(result.history['val_accuracy'], label='val acc')
plt.legend()
plt.show()
plt.savefig('AccVal_acc')



# USING ResNet50 CREATE THE MODEL
from keras.applications.resnet50 import ResNet50

resNet = ResNet50(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top = False)

for layer in resNet.layers:
    layer.trainable = False

x3 = Flatten()(resNet.output)

prediction = Dense(len(folders), activation='softmax')(x3)

model3 = Model(inputs=resNet.input, outputs=prediction)

model3.summary()

model3.compile(
    loss='categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)

result3 = model3.fit_generator(
    training_set,
    validation_data=test_set,
    epochs=10,
    steps_per_epoch=len(training_set),
    validation_steps=len(test_set)
)

# The result from this model
# loss: 0.6916 - accuracy: 0.6479 - val_loss: 1.5950 - val_accuracy: 0.5020




































    

