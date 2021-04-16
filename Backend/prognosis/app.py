# Make sure that all the following modules are already installed for use.
from flask import Flask
from flask_cors import CORS
from flask_restful import Api, Resource, reqparse
import joblib
import numpy as np


# ### Creating an instance of the flask app and an API

APP = Flask(__name__)
APP.config['CORS_HEADERS'] = 'Content-Type'
CORS(APP)
API = Api(APP)


# ### Loading the trained model

BREAST_PROGNOSIS_MODEL= joblib.load('Models/breast-cancer-prognosis-model.pkl')
LUNG_PROGNOSIS_MODEL= joblib.load('Models/lung-cancer-pred-model.pkl')

# Running the Main Application
if __name__ == "__main__":
    APP.run(debug=True)