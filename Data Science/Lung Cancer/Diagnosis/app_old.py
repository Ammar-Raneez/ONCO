#!/usr/bin/env python
# coding: utf-8

# # Serving the lung cancer detection modal

# ### Importing libraries

# In[2]:


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


# ### Defining the flask app

# In[3]:


app = Flask(__name__)


# ### Loading your saved modal

# In[4]:


MODEL_PATH = "model_vgg16.h5"
model = tf.keras.models.load_model('model_vgg16.h5')
print('Model loaded')


# ### Predict using the model

# In[5]:


def model_predict(img_path, model):
    IMG_SIZE = 224
    img_array = cv2.imread(img_path)
    new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE), 3)
    new_array = new_array.reshape(1, 224, 224, 3)
    prediction = model.predict([new_array])
    return prediction


# ### Defining the index route

# In[6]:


@app.route('/', methods=['GET'])
def index():
    return jsonify(
        message = "Hello World"
    )



# ### Defining the predict route

# In[7]:


@app.route('/predict', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        # Get the file from post request
        f = request.files['file']

        # Save the file to ./uploads
        basepath = os.path.dirname(__file__)
        file_path = os.path.join( basepath, 'uploads', secure_filename(f.filename) )
        f.save(file_path)

        # Make prediction
        prediction = model_predict(file_path, model)

        # These are the prediction categories 
        CATEGORIES = ['CANCER', 'NORMAL']
        
        # getting the prediction result from the categories
        result = CATEGORIES[int(round(prediction[0][0]))]
        
        # returning the result
        return result
    
    # if not a 'POST' request we then return None
    return None


# ### Running the main application

# In[9]:


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)

  


# In[ ]:




