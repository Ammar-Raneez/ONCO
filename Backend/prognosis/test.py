import requests

LUNG_CANCER_PROGNOSIS_URL = 'https://onco-prognosis-backend.herokuapp.com/prognosis_lung'  # localhost and the defined port + endpoint
BREAST_CANCER_PROGNOSIS_URL = 'https://onco-prognosis-backend.herokuapp.com/prognosis_breast'  # localhost and the defined port + endpoint

lung_cancer_prognosis_body = {
    "Age": 44,
    "Gender": 1,
    "AirPollution": 5.5,
    "Alcoholuse": 5.5,
    "DustAllergy": 5.5,
    "OccuPationalHazards": 5.5,
    "GeneticRisk": 5.3,
    "chronicLungDisease": 1.3,
    "BalancedDiet": 1.3,
    "Obesity": 1.3,
    "Smoking": 5.6,
    "PassiveSmoker": 1.6,
    "ChestPain": 1.6,
    "CoughingofBlood": 1.8,
    "Fatigue": 5.8,
    "WeightLoss": 1.7,
    "ShortnessofBreath": 1.7,
    "Wheezing": 5.7,
    "SwallowingDifficulty": 1.1,
    "ClubbingofFingerNails": 1.2,
    "FrequentCold": 5.9,
    "DryCough": 1.0,
    "Snoring": 5.4,
}

breast_cancer_prognosis_body = {
    "radius_mean": 116, 
    "texture_mean": 21.37, 
    "perimeter_mean": 17.44,
    "compactness_mean": 137.5, 
    "concavity_mean": 1373, 
    "concave points_mean": 0.08836,
    "fractal_dimension_mean": 0.1189,
    "radius_se": 0.1255, 
    "texture_se": 0.0818,
    "perimeter_se": 0.2333,
    "compactness_se": 0.6105,
    "concavity_se": 0.0601,
    "concave points_se": 0.5854,
    "symmetry_se": 3.928,
    "fractal_dimension_se": 24.9,
    "compactness_worst": 0.033,
    "concavity_worst": 0.01805,
    "concave points_worst": 0.005039,
    "symmetry_worst": 0.03449,
    "fractal_dimension_worst": 159.1,
    "tumor_size": 2.5,
    "positive_axillary_lymph_node": 0
}

response = requests.post(LUNG_CANCER_PROGNOSIS_URL, data=lung_cancer_prognosis_body)
print(response.json())

response = requests.post(BREAST_CANCER_PROGNOSIS_URL, data=breast_cancer_prognosis_body)
print(response.json())
