# Backend for Skin Cancer detection Modal
# Importing libraries
import glob
import math
import os
import re
import sys
import uuid

import cv2
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import numpy as np
import tensorflow as tf
from flask import Flask, jsonify, redirect, render_template, request, url_for
from IPython.display import Image
from keras.applications.vgg16 import preprocess_input
from keras.models import load_model
from keras.preprocessing import image
from pyrebase import pyrebase
from tensorflow import keras
from werkzeug.utils import secure_filename

from Functions import Functions

# Defining the flask app
app = Flask(__name__)
functions = Functions()

# Initializing Firebase App
# firebase cloud storage stuff to store the image to cloud
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


# Loading your saved modal
MODEL_PATH = "ph2_weights.hdf5"
model = tf.keras.models.load_model(MODEL_PATH)
print('Model loaded...')

# Predict using the model
def model_predict(image_path, model):
    image_array = functions.preprocess(image_path)
    y_pred = model.predict(image_array)
    #for percentages
    return y_pred * 100


# upload image to firebase storage
def uploadSkinImg(imageName):
    # Save the image to firebase cloud storage
    extension = ".jpg"
    fileName = imageName + extension
    folderName = "superimposedImages"
    save_local_path = "uploads/" + fileName

    # storing the image from local path to the firebase cloud storage
    firebase_storage.child(folderName + "/" + fileName).put(save_local_path)
    
    # get the downloadable url and return it
    auth = firebase.auth()
    e = "onconashml@gmail.com"
    p = "onconashml12345"
    user = auth.sign_in_with_email_and_password(e, p)
    url = firebase_storage.child(folderName + "/" + fileName).get_url(user["idToken"])
    print(url)
    return url


# Defining the index route
@app.route('/', methods=['GET'])
def index():
    return jsonify(
        message = "Hello World"
    )   

# Skin Diagnosis Route
@app.route('/skin-diagnosis', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        
        # getting the image file
        f = request.files['file']

        # Save the file to ./uploads
        fileName = str(uuid.uuid4())
        file_path = "./uploads/" + fileName + ".jpg"
        print(file_path)
        f.save(file_path)

        # making prediction
        prediction = model_predict(file_path, model)
        
        # getting download image URL
        image_download_Url = uploadSkinImg(fileName)
        
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

        # returns the result
        return jsonify(
            result_string = result_string,
            imageDownloadURL = image_download_Url,
        )
    
    # if not a 'POST' request we then return None
    return None


# ### Running the main application
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)
