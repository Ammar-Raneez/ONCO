from keras.preprocessing.image import ImageDataGenerator
from utils import *

#Data generators for all sets
def train_datagenerator(train_batchsize=20):
    #Train Data generator with Data Augmentation
    train_datagen = ImageDataGenerator(rescale=1./255)
    
    train_generator = train_datagen.flow_from_directory(
        TRAIN_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=TRAIN_BATCH,
        class_mode='categorical'
    )
    
    return train_generator


def validation_datagenerator(valid_batchsize=20):
    #Validation Data generator, Data Augmentation not needed
    validation_datagen = ImageDataGenerator(rescale=1./255)

    validation_generator = validation_datagen.flow_from_directory(
        VALIDATION_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=VALID_BATCH,
        class_mode='categorical',
        shuffle=False
    )
    
    return validation_generator

def test_datagenerator():
    #Testing Data generator, Data Augmentation not needed
    test_datagen = ImageDataGenerator(rescale=1./255)
    
    test_generator = test_datagen.flow_from_directory(
        TEST_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=TEST_BATCH,
        class_mode='categorical',
        shuffle=False
    )
    
    return test_generator

