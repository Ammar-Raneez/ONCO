from utils import *
from ImageSplit import *
from keras.utils.np_utils import to_categorical
from keras.applications import InceptionResNetV2
from keras import models, layers

#Normalize (Rescale data to same range)
X_train, X_test = X_train/255, X_test/255

#one hot encode the labels
y_train = to_categorical(y_train, num_classes= 2)

def fine_tuned_ir():
    pt_ir = InceptionResNetV2(
        include_top=False,
        weights='imagenet',
        input_shape=(IMAGE_SIZE, IMAGE_SIZE, 3),
    )
    
    for layer in pt_ir.layers[:-4]:
        layer.trainable = False
        
    ft_ir = models.Sequential()
    ft_ir.add(pt_ir)
    ft_ir.add(layers.Flatten())
    ft_ir.add(layers.Dense(1024, activation='relu'))
    ft_ir.add(layers.Dropout(0.8))
    ft_ir.add(layers.Dense(2, activation='softmax'))
    
    return ft_ir


#InceptionResnetV2 model
#Accuracy ==> 84.2
#Precision ==> 86%, 82%
#Recall ==> 85%, 83%