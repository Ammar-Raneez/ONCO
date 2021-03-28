import os
import numpy as np
import tensorflow as tf
from .lungDiagModule import LungDiagModule

lungDiagModule = LungDiagModule()

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
LUNG_MODEL_PATH = os.path.join(scriptdir, 'lung_model.h5')

# Calculate Prediction Percentage
def calculate_prediction_percent_lung(prediction):
    return str(np.amax(prediction[0][1] * 100))

def construct_lung_output(prediction, image_url):
    CATEGORIES = ['CANCER', 'NORMAL']

    # getting the results
    return CATEGORIES[int(round(prediction[0][0]))], calculate_prediction_percent_lung(prediction), image_url

def model_predict(image_array, model):
    lung_model = tf.keras.models.load_model(LUNG_MODEL_PATH)
    image_url = lungDiagModule.store_gramcam_image(image_array, lung_model)
    prediction = lungDiagModule.model_predict_lung(image_array, lung_model)
    return construct_lung_output(prediction, image_url)

def upload(image_array, which_model):        
    prediction, prediction_percentage, image_url = model_predict(image_array, which_model)
    return prediction, prediction_percentage, image_url
