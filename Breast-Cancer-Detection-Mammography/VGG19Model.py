from keras.applications import VGG19
from keras import models
from keras import layers
from keras import optimizers

#VGG19 - a deep CNN that achieves high accuracy with imagenet
def finetuned_vgg19():
    IMAGE_SIZE = 224
    
    #load pretraind vgg19
    pretrained_vgg = VGG19(
        weights='imagenet',
        #exclude top cuz we'll finetune it to suit our model
        include_top = False,
        #3 input channels is a must
        input_shape = (IMAGE_SIZE, IMAGE_SIZE, 3) 
    )
    
    #freeze previous "general" layers except last 4
    for layer in pretrained_vgg.layers[:-4]:
        layer.trainable = False
        
    #Create our fine=tuned model
    model = models.Sequential()
    
    #start off with our vgg19
    model.add(pretrained_vgg)
    
    #add new layers for finetuning
    model.add(layers.Flatten())
    model.add(layers.Dense(1024, activation='relu'))
    model.add(layers.Dropout(0.8))
    model.add(layers.Dense(2, activation='softmax'))
    
    return model

