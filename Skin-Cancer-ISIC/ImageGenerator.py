from utils import *
from keras.preprocessing.image import ImageDataGenerator

def train_generator():
    train_datagen = ImageDataGenerator(
        rescale=1/255,
        rotation_range=0.2,
        shear_range=0.2,
        zoom_range = 0.2,
        horizontal_flip=True
    )
    
    train_generator = train_datagen.flow_from_directory(
        TRAIN_DATASET,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=BATCH_SIZE,
        class_mode='categorical'
    )
    
    return train_generator

def test_generator():
    test_datagen = ImageDataGenerator(
        rescale=1/255,
        rotation_range=0.2,
        shear_range=0.2,
        zoom_range = 0.2,
        horizontal_flip=True
    )
    
    test_generator = test_datagen.flow_from_directory(
        TEST_DATASET,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=BATCH_SIZE,
        class_mode='categorical',
    )

