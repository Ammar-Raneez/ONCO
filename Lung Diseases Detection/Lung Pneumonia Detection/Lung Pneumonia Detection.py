# # Lung Pneumonia Detection

import os
os.listdir('../../../../chest_xray')


# ## Importing libraries

# In[9]:


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

# In[15]:


IMAGE_SIZE = [224, 224]

train_path = '../../../../chest_xray/train'
test_path = '../../../../chest_xray/test'


# ## Using VGG16 to create the model

# In[16]:


vgg = VGG16(input_shape=IMAGE_SIZE + [3], weights='imagenet', include_top = False)


# ### Don't train existing weights

# In[17]:


for layer in vgg.layers:
    layer.trainable = False


# ### Getting the number of folders which are my output classes

# In[18]:


folders = glob(train_path + '/*')
folders


# ### Creating a flatten layer to flatten the vgg output what ever we got 

# In[19]:


x = Flatten()(vgg.output)


# ### Adding our last layer

# In[20]:


prediction = Dense(len(folders), activation='softmax')(x)

# ### Creating a model object

# In[21]:


model = Model(inputs=vgg.input, outputs=prediction)


# ### View the structure of the model

# In[22]:


model.summary()



# ### Telling the model what cost and optimization method to use

# In[23]:


model.compile(
    loss='categorical_crossentropy',
    optimizer = 'adam',
    metrics = ['accuracy']
)

# ### Use the Image Data Generator to import the images from the dataset

# In[24]:


train_datagen = ImageDataGenerator(rescale=1./255, shear_range=0.2, zoom_range=0.2, horizontal_flip=True)
test_datagen = ImageDataGenerator(rescale=1./255)


# In[25]:


training_set = train_datagen.flow_from_directory(train_path, target_size=(224,224), batch_size=32, class_mode='categorical')


# In[26]:


testing_set = test_datagen.flow_from_directory(test_path, target_size=(224,224), batch_size=32, class_mode='categorical')

# ### Fit the model 

# In[28]:


result = model.fit_generator(
    training_set,
    validation_data=testing_set,
    epochs=5,
    steps_per_epoch=len(training_set),
    validation_steps=len(testing_set)
)
# val_accuracy: 0.9135
# accuracy: 0.9680


