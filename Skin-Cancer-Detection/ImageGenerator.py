#!/usr/bin/env python
# coding: utf-8

# In[2]:


from utils import *

def train_generator(train_batchsize=64):
    train_datagen = ImageDataGenerator(
        rescale=1/255,
        rotation_range=0.2,
        vertical_flip=True,
        horizontal_flip=True
    )
    
    train_generator = train_datagen.flow_from_directory(
        TRAIN_FOLDER,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=train_batchsize,
        class_mode='categorical'
    )
    
    return train_generator

def test_generator():
    test_datagen = ImageDataGenerator(rescale=1/255)
    
    test_generator = test_datagen.flow_from_directory(
        TEST_FOLDER,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        class_mode='categorical',
        shuffle=False
    )

