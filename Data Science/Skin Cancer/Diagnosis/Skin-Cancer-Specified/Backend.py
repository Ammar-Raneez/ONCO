import glob
import math
import os
import re
import sys

import numpy as np
import tensorflow as tf
from flask import Flask, redirect, render_template, request, url_for
from werkzeug.utils import secure_filename

from Functions import Functions

app = Flask(__name__)
functions = Functions()

MODEL_PATH = "ph2_weights.hdf5"
model = tf.keras.models.load_model(MODEL_PATH)
print('Model loaded')

def model_predict(image_path, model):
    image_array = functions.preprocess(image_path)
    y_pred = model.predict(image_array)
    #for percentages
    return y_pred * 100

app = Flask(__name__)
functions = Functions()

@app.route('/skin-diagnosis', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        f = request.files['file']

        basepath = os.path.dirname(__file__)
        file_path = os.path.join( basepath, 'uploads', secure_filename(f.filename))
        file_path = file_path.replace("\\", "/")
        f.save(file_path)
        print(file_path)
        
        prediction = model_predict(file_path, model)
        
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
        return result_string
    
    # if not a 'POST' request we then return None
    return None


# ### Running the main application
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)
