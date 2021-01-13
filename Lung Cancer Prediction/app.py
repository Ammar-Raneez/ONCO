#!/usr/bin/env python
# coding: utf-8

# # Backend for Lung Prediction Model

# ### Importing Libraries

# In[5]:


# Make sure that all the following modules are already installed for use.
from flask import Flask
from flask_restful import Api, Resource, reqparse
import joblib
import numpy as np


# ### Creating an instance of the flask app and an API

# In[ ]:


APP = Flask(__name__)
API = Api(APP)


# ### Loading the trained model

# In[10]:


LUNG_PREDICTION_MODEL = joblib.load('lung-cancer-pred-model.pkl')


# ### Creating a class which is responsible for the prediction

# In[11]:


class Predict(Resource):

    @staticmethod
    def post():
        parser = reqparse.RequestParser()
        parser.add_argument('Age')
        parser.add_argument('Gender')
        parser.add_argument('AirPollution')
        parser.add_argument('Alcoholuse')
        parser.add_argument('DustAllergy')
        parser.add_argument('OccuPationalHazards')
        parser.add_argument('GeneticRisk')
        parser.add_argument('chronicLungDisease')
        parser.add_argument('BalancedDiet')
        parser.add_argument('Obesity')
        parser.add_argument('Smoking')
        parser.add_argument('PassiveSmoker')
        parser.add_argument('ChestPain')
        parser.add_argument('CoughingofBlood')
        parser.add_argument('Fatigue')
        parser.add_argument('WeightLoss')
        parser.add_argument('ShortnessofBreath')
        parser.add_argument('Wheezing')
        parser.add_argument('SwallowingDifficulty')
        parser.add_argument('ClubbingofFingerNails')
        parser.add_argument('FrequentCold')
        parser.add_argument('DryCough')
        parser.add_argument('Snoring')
        
        args = parser.parse_args()  # creates dictionary

        X_new = np.fromiter(args.values(), dtype=float)  # convert input to array

        out = {'Prediction': LUNG_PREDICTION_MODEL.predict([X_new])[0]}

        return out, 200


# ### Adding the predict class as a resource to the API

# In[ ]:


API.add_resource(Predict, '/predict')

if __name__ == '__main__':
    APP.run(debug=True, port=1080)


# ### Using the request module by first defining the URL to access and the body to send along with our HTTP request

# In[13]:


# import requests

# URL = 'http://127.0.0.1:1080/predict'  # localhost and the defined port + endpoint

# body = {
#     "Age": 44,
#     "Gender": 1,
#     "AirPollution": 5.5,
#     "Alcoholuse": 5.5,
#     "DustAllergy": 5.5,
#     "OccuPationalHazards": 5.5,
#     "GeneticRisk": 5.3,
#     "chronicLungDisease": 1.3,
#     "BalancedDiet": 1.3,
#     "Obesity": 1.3,
#     "Smoking": 5.6,
#     "PassiveSmoker": 1.6,
#     "ChestPain": 1.6,
#     "CoughingofBlood": 1.8,
#     "Fatigue": 5.8,
#     "WeightLoss": 1.7,
#     "ShortnessofBreath": 1.7,
#     "Wheezing": 5.7,
#     "SwallowingDifficulty": 1.1,
#     "ClubbingofFingerNails": 1.2,
#     "FrequentCold": 5.9,
#     "DryCough": 1.0,
#     "Snoring": 5.4,
# }

# response = requests.post(URL, data=body)
# response.json()


# In[ ]:




