import os
import numpy as np
import logging
import tensorflow as tf
from .lungDiagModule import LungDiagModule

lungDiagModule = LungDiagModule()

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
LUNG_MODEL_PATH = os.path.join(scriptdir, 'lung_model.h5')

# Get image download URL based on the image file name
def get_firebase_image(image_name, image_stream, firebase_storage, firebase):
    lung_model = tf.keras.models.load_model(LUNG_MODEL_PATH)
    lungDiagModule.store_gramcam_image(image_stream, lung_model, firebase_storage)

    auth = firebase.auth()
    e = "onconashml@gmail.com"
    p = "onconashml12345"
    user = auth.sign_in_with_email_and_password(e, p)
    url = firebase_storage.child(image_name).get_url(user["idToken"])
    return url

def upload(image_array, which_model):        
    prediction, prediction_percentage = model_predict(image_array, which_model)
    return prediction, prediction_percentage

# Calculate Prediction Percentage
def calculate_prediction_percent_lung(prediction):
    return str(np.amax(prediction[0][1] * 100))

def construct_lung_output(prediction):
    CATEGORIES = ['CANCER', 'NORMAL']

    # getting the prediction result from the categories
    return CATEGORIES[int(round(prediction[0][0]))], calculate_prediction_percent_lung(prediction)

def model_predict(image_array, model):
    if model == "lung":
        lung_model = tf.keras.models.load_model(LUNG_MODEL_PATH)
        prediction = lungDiagModule.model_predict_lung(image_array, lung_model)
        return construct_lung_output(prediction)