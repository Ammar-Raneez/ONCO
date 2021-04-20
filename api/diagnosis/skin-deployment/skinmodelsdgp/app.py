import os
import logging
import numpy as np
import tensorflow as tf
from .skinDiagModule import SkinDiagModule

skinDiagModule = SkinDiagModule()

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
SKIN_MODEL_PATH = os.path.join(scriptdir, 'skin_model.hdf5')

def construct_skin_output(predictions):
    INDEX_TO_TYPE = {
        0: 'Melanocytic nevi',
        1: 'Melanoma',
        2: 'Benign keratosis-like lesions ',
        3: 'Basal cell carcinoma',
        4: 'Actinic keratoses',
        5: 'Vascular lesions',
        6: 'Dermatofibroma'
    }

    prediction_percentage = np.amax(predictions)
    prediction = INDEX_TO_TYPE[np.argmax(predictions)]

    result_string = ""
    for i in range(len(predictions.flat)):
        result_string += str(round(predictions.flat[i], 2)) + f"% {INDEX_TO_TYPE[i]} \n"
    return result_string, str(prediction), str(round(prediction_percentage, 2))

def model_predict(image_array, model):
    if model == "skin":
        skin_model = tf.keras.models.load_model(SKIN_MODEL_PATH)
        predictions = skinDiagModule.model_predict_skin(image_array, skin_model)
        return construct_skin_output(predictions)

def upload(image_array, which_model):        
    result_string, prediction, prediction_percentage = model_predict(image_array, which_model)
    return result_string, prediction, prediction_percentage
