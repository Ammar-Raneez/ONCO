#!/usr/bin/env python
# coding: utf-8

# # Backend for Skin Cancer detection Modal

# In[4]:


# Importing libraries
import sys
import os
import glob
import re
import numpy as np

from flask import Flask, redirect, url_for, request, render_template, jsonify
from werkzeug.utils import secure_filename

from keras.models import load_model
from keras.preprocessing import image
from keras.applications.vgg16 import preprocess_input
import numpy as np
import cv2
import tensorflow as tf

import numpy as np
from tensorflow import keras
from IPython.display import Image
import matplotlib.pyplot as plt
import matplotlib.cm as cm
import uuid
from pyrebase import pyrebase

from Functions import Functions


# In[5]:


# Defining the flask app
app = Flask(__name__)
functions = Functions()


# In[6]:


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


# In[7]:


# Loading your saved modal
MODEL_PATH = "ph2_weights.hdf5"
model = tf.keras.models.load_model(MODEL_PATH)
print('Model loaded . . .')


# In[8]:


# Predict using the model
def model_predict(img_path, model):
    image_array = functions.preprocess(image_path)
    y_pred = model.predict(image_array)
    #for percentages
    return y_pred * 100


# In[73]:


# upload image to firebase storage
def uploadSkinImg(file):
    # Save the image to firebase cloud storage
    extension = ".jpg"
    generateImageName = str(uuid.uuid4())
    fileName = generateImageName + extension
    folderName = "superimposedImages"
    save_local_path = "superimposedImages/" + generateImageName + extension
    file.save(save_local_path)

    # storing the image from local path to the firebase cloud storage
    firebase_storage.child(folderName + "/" + fileName).put(save_local_path)
    
    # get the downloadable url and return it
    auth = firebase.auth()
    email = "onconashml@gmail.com"
    password = "onconashml12345"
    user = auth.sign_in_with_email_and_password(email, password)
    url = firebase_storage.child(save_local_path).get_url(user["idToken"])
    print(url)
    return url
    


# In[71]:


@app.route('/skin-diagnosis', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        
        f = request.files['file']

        # Save the file to ./uploads
        file_path = "./uploads/"+f.filename
        print(file_path)
        f.save(file_path)

        
        prediction = model_predict(file_path, model)
        
        image_download_Url = uploadSkinImg(f)
        
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

#         result = str(np.amax(prediction)) + f"% {INDEX_TO_TYPE[np.argmax(prediction)]}"
        return jsonify(
            result_string = result_string,
            imageDownloadURL = image_download_Url,
        )
    
    # if not a 'POST' request we then return None
    return None


# In[72]:


# ### Running the main application
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)


# In[ ]:




