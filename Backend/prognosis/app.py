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

        print(prognosis_input)

        out = {'Prediction': LUNG_PROGNOSIS_MODEL.predict([prognosis_input])[0]}

        print(out)

        return out, 200  # returns 200 Status Code if successful with the Output


# ### Creating a class which is responsible for the prognosis of Breast Cancer

class BreastCancerPrognosis(Resource):

    @staticmethod
    def post():
        parser = reqparse.RequestParser()
        parser.add_argument('radius_mean')
        parser.add_argument('texture_mean')
        parser.add_argument('perimeter_mean')
        parser.add_argument('compactness_mean')
        parser.add_argument('concavity_mean')
        parser.add_argument('concave points_mean')
        parser.add_argument('fractal_dimension_mean')
        parser.add_argument('radius_se')
        parser.add_argument('texture_se')
        parser.add_argument('perimeter_se')
        parser.add_argument('compactness_se')
        parser.add_argument('concavity_se')
        parser.add_argument('concave points_se')
        parser.add_argument('symmetry_se')
        parser.add_argument('fractal_dimension_se')
        parser.add_argument('compactness_worst')
        parser.add_argument('concavity_worst')
        parser.add_argument('concave points_worst')
        parser.add_argument('symmetry_worst')
        parser.add_argument('fractal_dimension_worst')
        parser.add_argument('tumor_size')
        parser.add_argument('positive_axillary_lymph_node')

        args = parser.parse_args()  # creates dictionary
        prognosis_input = np.fromiter(args.values(), dtype=float)  # convert input to array

        print(prognosis_input)

        out = {'Prediction': BREAST_PROGNOSIS_MODEL.predict([prognosis_input])[0]}

        print(out)

        return out, 200  # returns 200 Status Code if successful with the Output


# ### Adding the predict class as a resource to the API

API.add_resource(BreastCancerPrognosis, '/prognosis_breast')
API.add_resource(LungCancerPrognosis, '/prognosis_lung')

# Running the Main Application
if __name__ == "__main__":
    APP.run(debug=True)
