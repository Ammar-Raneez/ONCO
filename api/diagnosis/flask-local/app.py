# This is a local tester for the diagnosis applications

# Import Libraries
import glob
import os
import re
import sys
import uuid

import cv2
import tensorflow as tf
from flask import Flask, jsonify, redirect, render_template, request, url_for
from pyrebase import pyrebase

from breastDiagModule import (calculatePredictionPercentBreast, model_predictBreast)
from lungDiagModule import (calculatePredictionPercentLung, getImageUrlLung, model_predictLung, storeGradCamImageLung)
from skinDiagModule import model_predict_skin, uploadSkinImg

# Defining the flask app
app = Flask(__name__)

# Initializing Firebase App (firebase cloud storage stuff to store the image to cloud)
firebase_config = {
    "apiKey": "AIzaSyCTCf6EWg_Mthy590c8JpkX5CsOdIlpEA4",
    "authDomain": "onco-127df.firebaseapp.com",
    "projectId": "onco-127df",
    "databaseURL": "https://onco-127df-default-rtdb.firebaseio.com",
    "storageBucket": "onco-127df.appspot.com",
    "messagingSenderId": "425803825049",
    "appId": "1:425803825049:web:3f261cd2ecf11241065d08",
    "measurementId": "G-S3DZNYJLXT"
}

firebase = pyrebase.initialize_app(firebase_config)
firebase_storage = firebase.storage()

# Model paths
LUNG_DIAGNOSIS_MODEL_PATH = "lung_model.h5"
SKIN_DIAGNOSIS_MODEL_PATH = "skin_model.hdf5"
BREAST_DIAGNOSIS_MODEL_PATH = "breast_model.h5"

# Loading all the models
lung_diag_model = tf.keras.models.load_model(LUNG_DIAGNOSIS_MODEL_PATH)
skin_diag_model = tf.keras.models.load_model(SKIN_DIAGNOSIS_MODEL_PATH)
breast_diag_model = tf.keras.models.load_model(BREAST_DIAGNOSIS_MODEL_PATH)

# Index route
@app.route('/', methods=['GET', 'POST'])
def index():
    return jsonify(
        message = "Hello World"
    )

# Lung Cancer Diagnosis route
@app.route('/lung-cancer/diagnosis', methods=['GET', 'POST'])
def lungCancerDiagnosis():
    if request.method == 'POST':
        # Get the file from post request
        f = request.files['file']
        # Save the file to ./uploads
        file_path = "uploads/" + str(uuid.uuid4()) + ".jpg"
        f.save(file_path)

        # Storing the image into firebase
        image_fileName = storeGradCamImageLung(file_path, lung_diag_model, firebase_storage)
        # Getting the prediction percentage value
        prediction_percentage = calculatePredictionPercentLung(file_path, lung_diag_model)
        # Getting the superimposed image download URL link
        image_download_Url = getImageUrlLung(image_fileName, firebase, firebase_storage)
        # Make prediction
        prediction = model_predictLung(file_path, lung_diag_model)

        # These are the prediction categories 
        CATEGORIES = ['CANCER', 'NORMAL']
        # getting the prediction result from the categories
        output = CATEGORIES[int(round(prediction[0][0]))]

        # returning the result
        return jsonify(
            result = output,
            imageUrl = image_download_Url,
            percentage = prediction_percentage
        )

    # if not a 'POST' request we then return None
    return None 


# Skin Cancer Diagnosis route
@app.route('/skin-cancer/diagnosis', methods=['GET', 'POST'])
def skinCancerDiagnosis():
    if request.method == 'POST':
        f = request.files['file']
        fileName = str(uuid.uuid4())
        file_path = "uploads/" + fileName + ".jpg"
        f.save(file_path)

        prediction = model_predict_skin(file_path, skin_diag_model)
        # getting download image URL
        image_download_Url = uploadSkinImg(fileName, firebase_storage, firebase)
        
        INDEX_TO_TYPE = {
            0: 'Melanocytic nevi',
            1: 'Melanoma',
            2: 'Benign keratosis-like lesions ',
            3: 'Basal cell carcinoma',
            4: 'Actinic keratoses',
            5: 'Vascular lesions',
            6: 'Dermatofibroma'
        }
        result_string = ""
        for i in range(len(prediction.flat)):
            result_string += str(round(prediction.flat[i], 2)) + f"% {INDEX_TO_TYPE[i]} \n"

        return jsonify(
            result_string = result_string,
            imageDownloadURL = image_download_Url,
        )

    return None

# Breast Cancer Diagnosis route
@app.route('/breast-cancer/diagnosis', methods=['GET', 'POST'])
def breastCancerDiagnosis():
    if request.method == 'POST':
        f = request.files['file']
        file_path = "uploads/" + str(uuid.uuid4()) + ".jpg"
        f.save(file_path)

        prediction_percentage = calculatePredictionPercentBreast(file_path, breast_diag_model)
        image_download_Url = "https://www.gettingImageFromAzureStorage.com"
        prediction = model_predictBreast(file_path, breast_diag_model)

        CATEGORIES = ['CANCER', 'NORMAL']
        output = CATEGORIES[int(prediction[0][0])]
        
        return jsonify(
            result = output,
            imageUrl = image_download_Url,
            percentage = prediction_percentage
        )

    return None     


# Running the main application
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80, debug=False)
