from utils import *
from ImageSplit import *
from keras.utils.np_utils import to_categorical
from keras.applications import InceptionV3
from keras import models, layers

#Normalize (Rescale data to same range)
X_train, X_test = X_train/255, X_test/255

#one hot encode the labels
y_train = to_categorical(y_train, num_classes= 2)

def fine_tuned_inception():
    pt_inception = InceptionV3(
        include_top=False,
        weights='imagenet',
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    )
    
    for layer in pt_inception.layers[:-4]:
        layer.trainable = False
        
    ft_inception = models.Sequential()
    ft_inception.add(pt_inception)
    ft_inception.add(layers.Flatten())
    ft_inception.add(layers.Dense(1024, activation='relu'))
    ft_inception.add(layers.Dropout(0.8))
    ft_inception.add(layers.Dense(2, activation='softmax'))
    
    return ft_inception


#InceptionV3 model
#Accuracy ==> 84.2
#Precision ==> 83%, 86%
#Recall ==> 89%, 78%