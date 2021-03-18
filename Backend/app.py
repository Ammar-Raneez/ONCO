# //// MAIN BACKEND SERVER ////

# Import Libraries
import glob, os, re, sys, uuid, cv2
import tensorflow as tf
from flask import Flask, jsonify, redirect, render_template, request, url_for
from pyrebase import pyrebase
from lungDiagModule import storeGradCamImageLung, calculatePredictionPercentLung, getImageUrlLung, model_predictLung

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
LUNG_DIAGNOSIS_MODEL_PATH = "models/lungDiag.h5"
SKIN_DIAGNOSIS_MODEL_PATH = ""
BREAST_DIAGNOSIS_MODEL_PATH = ""

# Loading all the models
lung_diag_model = tf.keras.models.load_model('lungDiag.h5')
skin_diag_model = tf.keras.models.load_model('')
breast_diag_model = tf.keras.models.load_model('')
print("Loaded Models . . .")

# Index route
@app.route('/', methods=['GET', 'POST'])
def index():
    return jsonify(
        message = "Hello World"
    )

# Index route
@app.route('/lung-cancer/diagnosis', methods=['GET', 'POST'])
def lungCancerDiagnosis():
    if request.method == 'POST':
        # Get the file from post request
        f = request.files['file']

        # Save the file to ./uploads
        file_path = "uploads/" + str(uuid.uuid4()) + ".jpg"
        print(file_path)
        f.save(file_path)

        # Storing the image into firebase
        image_fileName = storeGradCamImageLung(file_path, lung_diag_model, firebase_storage);
        print("Storing image into firebase . . .")
        
        # Getting the prediction percentage value
        prediction_percentage = calculatePredictionPercentLung(file_path, lung_diag_model)
        
        # Getting the superimposed image download URL link
        image_download_Url = getImageUrlLung(image_fileName, firebase, firebase_storage);
        
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
