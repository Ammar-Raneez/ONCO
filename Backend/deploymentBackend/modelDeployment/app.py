import sys
import os
import glob
import re

# scriptpath = os.path.abspath(__file__)
# scriptdir = os.path.dirname(scriptpath)
# MODEL_PATH = os.path.join(scriptdir, 'densenet121ML.h5')
# model = tf.keras.models.load_model(MODEL_PATH)
# print('Model loaded')

def model_predict(image_path, model):
    if model == "skin":
        return "skin"
    elif model == "breast":
        return "breast"
    return "lung"

def upload(image_path, which_model):        
    prediction = model_predict(image_path, which_model)
    return prediction

# if __name__ == '__main__':
#     upload(sys.argv[1], sys.argv[2])