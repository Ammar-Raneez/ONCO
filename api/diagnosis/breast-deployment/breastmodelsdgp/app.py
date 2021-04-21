import os
import numpy as np
import tensorflow as tf
from .breastDiagModule import BreastDiagModule

breastDiagModule = BreastDiagModule()

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
BREAST_MODEL_PATH = os.path.join(scriptdir, 'breast_model.h5')

# Calculate Prediction Percentage of result (cancer / normal percentage)
def calculate_prediction_percent_breast(prediction, result):
    return str(np.amax(prediction[0][0] * 100))

def construct_breast_output(prediction, image_url):
    result = int(prediction[0][0])
    CATEGORIES = ['CANCER', 'NORMAL']

    # getting the results
    return CATEGORIES[result], calculate_prediction_percent_breast(prediction, result), image_url

def model_predict(image_array, model):
    breast_model = tf.keras.models.load_model(BREAST_MODEL_PATH)
    image_url = breastDiagModule.store_gramcam_image(image_array, breast_model)
    prediction = breastDiagModule.model_predict_breast(image_array, breast_model)
    return construct_breast_output(prediction, image_url)

def upload(image_array, which_model):
    prediction, prediction_percentage, image_url = model_predict(image_array, which_model)
    return prediction, prediction_percentage, image_url