#Data generator module 
#(aimed at a folder, keras takes care of using all the pictures in that folder as train/test/valid generators)
#basically keras uses all the pictures in that folder as train/test/valid datasets
from keras.preprocessing.image import ImageDataGenerator

IMAGE_SIZE = 224
TEST_BATCH = 16
TRAIN_BATCH = 9
EPOCHS = 30

TRAIN_DIR = 'proper-dataset/train/'
VALIDATION_DIR = 'proper-dataset/valid/'
TEST_DIR = 'proper-dataset/test/'

#Data generators for all sets
def train_datagenerator(train_batchsize=20):
    #Train Data generator with Data Augmentation
    train_datagen = ImageDataGenerator(
        rescale=1/255, 
        rotation_range=20,
        width_shift_range=0.2,
        height_shift_range=0.2,
        horizontal_flip=True,
        fill_mode='nearest'
    )
    
    train_generator = train_datagen.flow_from_directory(
        TRAIN_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=TRAIN_BATCH,
        class_mode='categorical'
    )
    
    return train_datagenerator


def validation_datagenerator(train_batchsize=20):
    #Validation Data generator, Data Augmentation not needed
    validation_datagen = ImageDataGenerator(rescale=1/255)

    validation_generator = validation_datagen.flow_from_directory(
        VALIDATION_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=VALIDATION_DIR,
        class_mode='categorical',
        shuffle=False
    )
    
    return validation_datagenerator

def test_datagenerator(train_batchsize=20):
    #Testing Data generator, Data Augmentation not needed
    test_datagen = ImageDataGenerator(rescale=1/255)
    
    test_generator = test_datagen.flow_from_directory(
        TEST_DIR,
        target_size=(IMAGE_SIZE, IMAGE_SIZE),
        batch_size=TEST_BATCH,
        class_mode='categorical',
        shuffle=False
    )
    
    return test_datagenerator

