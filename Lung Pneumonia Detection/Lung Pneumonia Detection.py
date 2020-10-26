# # Lung Pneumonia Detection

import os
os.listdir('../../../../chest_xray')

# ## Importing libraries


from keras.layers import Input, Lambda, Dense, Flatten 
from keras.models import Model
from keras.applications.vgg16 import VGG16
from keras.applications.vgg16 import preprocess_input
from keras.preprocessing import image
from keras.preprocessing.image import ImageDataGenerator
from keras.models import Sequential
import numpy as np
from glob import glob
import matplotlib.pyplot as plt


# ## Re-sizing all the images


IMAGE_SIZE = [224, 224]

train_path = '../../../../chest_xray/train'
test_path = '../../../../chest_xray/test'


# ## Using VGG16 to create the model



vgg = VGG16(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top = False)


# ### Don't train existing weights


for layer in vgg.layers:
    layer.trainable = False


# ### Getting the number of folders which are my output classes


folders = glob(train_path + '/*')
folders


# ### Creating a flatten layer to flatten the vgg output what ever we got 

x = Flatten()(vgg.output)


# ### Adding our last layer



prediction = Dense(len(folders), activation='softmax')(x)

# ### Creating a model object


model = Model(inputs=vgg.input, outputs=prediction)


# ### View the structure of the model


model.summary()



# ### Telling the model what cost and optimization method to use



model.compile(
    loss='categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)

# ### Use the Image Data Generator to import the images from the dataset


train_datagen = ImageDataGenerator(rescale=1./255, shear_range=0.2, zoom_range=0.2, horizontal_flip=True)
test_datagen = ImageDataGenerator(rescale=1./255)


training_set = train_datagen.flow_from_directory(train_path, target_size=(224,224), batch_size=32, class_mode='categorical')



testing_set = test_datagen.flow_from_directory(test_path, target_size=(224,224), batch_size=32, class_mode='categorical')

# ### Fit the model 



result = model.fit_generator(
    training_set,
    validation_data=testing_set,
    epochs=5,
    steps_per_epoch=len(training_set),
    validation_steps=len(testing_set)
)
# val_accuracy: 0.9135
# accuracy: 0.9680

# ### Plot the loss


plt.plot(result.history['loss'], label='train loss')
plt.plot(result.history['val_loss'], label='val loss')
plt.legend()
plt.show()
plt.savefig('LossVal_loss')


# ### Plot the accuracy



plt.plot(result.history['accuracy'], label='train acc')
plt.plot(result.history['val_accuracy'], label='val acc')
plt.legend()
plt.show()
plt.savefig('AccVal_acc')

result.history


# ### Saving the model which used VGG16


import tensorflow as tf
from keras.models import load_model

model.save('model_vgg16.h5')


# ## Using Xception to create the model



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
    validation_data=testing_set,
    epochs=5,
    steps_per_epoch=len(training_set),
    validation_steps=len(testing_set)
)
# val_accuracy: 0.8782
# accuracy: 0.9479

# plot the loss
plt.plot(result2.history['loss'], label='train loss')
plt.plot(result2.history['val_loss'], label='val loss')
plt.legend()
plt.show()
plt.savefig('LossVal_loss')


# plot the accuaracy
plt.plot(result2.history['accuracy'], label='train acc')
plt.plot(result2.history['val_accuracy'], label='val acc')
plt.legend()
plt.show()
plt.savefig('AccVal_acc')

# ## Using ResNet50 to create the model


from keras.applications.resnet50 import ResNet50



resnet = ResNet50(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top = False)


for layer in resnet.layers:
    layer.trainable = False



x3 = Flatten()(resnet.output)


prediction = Dense(len(folders), activation='softmax')(x3)



model3 = Model(inputs=resnet.input, outputs=prediction)



model3.summary()


model3.compile(
    loss='categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)



result3 = model3.fit_generator(
    training_set,
    validation_data=testing_set,
    epochs=5,
    steps_per_epoch=len(training_set),
    validation_steps=len(testing_set)
)
# val_accuracy: 0.8301
# accuracy: 0.8915


# plot the loss
plt.plot(result3.history['loss'], label='train loss')
plt.plot(result3.history['val_loss'], label='val loss')
plt.legend()
plt.show()
plt.savefig('LossVal_loss')



# plot the accuaracy
plt.plot(result3.history['accuracy'], label='train acc')
plt.plot(result3.history['val_accuracy'], label='val acc')
plt.legend()
plt.show()
plt.savefig('AccVal_acc')


# ### Out of the 3 models trained VGG16 gave the best result hence VGG16 model is saved

# ## Using the saved model for prediction



from keras.models import load_model
from keras.preprocessing import image
from keras.applications.vgg16 import preprocess_input
import numpy as np




img = image.load_img('../../../../chest_xray/val/PNEUMONIA/person1946_bacteria_4874.jpeg', target_size=(224, 224))
x = image.img_to_array(img)  # convert to array
x = np.expand_dims(x, axis=0) # expanding the dimensions
img_data = preprocess_input(x) # preprocess the image

classes = model.predict(img_data)  # predict

import cv2

CATRGORIES = ["Pneumonia", "Normal"]

def prepare(filepath):
    IMG_SIZE = 224
    img_array = cv2.imread(filepath)
    new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE), 3)
    return new_array.reshape(1, 224, 224, 3)

load_modal = tf.keras.models.load_model('model_vgg16.h5')





predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1946_bacteria_4874.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])




predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1946_bacteria_4875.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])





predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1946_bacteria_4875.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])




predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1947_bacteria_4876.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])



predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1950_bacteria_4881.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])





predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1951_bacteria_4882.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])



predict = load_modal.predict([prepare('../../../../chest_xray/val/PNEUMONIA/person1954_bacteria_4886.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])




predict = load_modal.predict([prepare('../../../../chest_xray/val/NORMAL/NORMAL2-IM-1436-0001.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])



predict = load_modal.predict([prepare('../../../../chest_xray/val/NORMAL/NORMAL2-IM-1430-0001.jpeg')])
print(CATRGORIES[int(round(predict[0][0]))])

