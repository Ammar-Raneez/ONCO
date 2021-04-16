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

BREAST_PROGNOSIS_MODEL = joblib.load('Models/breast-cancer-prognosis-model.pkl')
LUNG_PROGNOSIS_MODEL = joblib.load('Models/lung-cancer-pred-model.pkl')


# ### Creating a class which is responsible for the prognosis of Lung Cancer

class LungCancerPrognosis(Resource):

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
        prognosis_input = np.fromiter(args.values(), dtype=float)  # convert input to array
        out = {'Prediction': LUNG_PROGNOSIS_MODEL.predict([prognosis_input])[0]}

        return out, 200  # returns 200 Status Code if successful with the Output

# Running the Main Application
if __name__ == "__main__":
    APP.run(debug=True)
