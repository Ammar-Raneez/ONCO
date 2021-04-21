import math
import json
from Models.skin_cancer.mrat_constants import MRATConstants
import random

class MelanomaRiskAssessmentTool:

    def getAbsoluteRisk(self, req_params):

        age = int(req_params['age'])
        sex = None
        # assess male or female
        if req_params['gender'] == 'male':
            sex = 0
        elif req_params['gender'] == 'female':
            sex = 1

        risk = 1
        if sex == 0:
            risk *= MRATConstants.SUNBURN[int(req_params['sunburn'] )]
            risk *= MRATConstants.MALE_COMPLEXION[int(req_params['complexion'] )]
            risk *= MRATConstants.BIG_MOLES[int(req_params['big-moles'] )]
            risk *= MRATConstants.MALE_SMALL_MOLES[int(req_params['small-moles'] )]
            risk *= MRATConstants.MALE_FRECKLING[int(req_params['freckling'] )]
            risk *= MRATConstants.DAMAGE[int(req_params['damage'] )]
        else:
            risk *= MRATConstants.TAN[int(req_params['tan'] )]
            risk *= MRATConstants.FEMALE_COMPLEXION[int(req_params['complexion'] )]
            risk *= MRATConstants.FEMALE_SMALL_MOLES[int(req_params['small-moles'] )]
            risk *= MRATConstants.FEMALE_FRECKLING[int(req_params['freckling'] )]

        # to get incidence and mortality values
        age_index = int((age - 20) / 5)
        t1 = age_index * 5 + 20
        t2 = t1 + 5
        region_index = random.randint(0, len(MRATConstants.INCIDENCE[sex][age_index]))
        incident_rate = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index][region_index]
        mortality_rate = MRATConstants.MORTALITY[sex][age_index]
        absolute_risk = incident_rate * risk * (1 - math.exp((age - t2) * (incident_rate * risk + mortality_rate))) / (incident_rate * risk + mortality_rate)

        if age != t1:
            next_incident_rate = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index + 1][region_index]
            next_mortality_rate = MRATConstants.MORTALITY[sex][age_index + 1]
            absolute_risk += next_incident_rate * risk * math.exp((age - t2) * (incident_rate * risk + mortality_rate)) * (1 - math.exp((t1 - age) * (next_incident_rate * risk + next_mortality_rate))) / (next_incident_rate * absolute_risk + next_mortality_rate)
        absolute_risk = round(absolute_risk * 10000) / 100
        ratio = round((absolute_risk * 0.01) * 1000)

        results = {
            'absolute_risk': str(absolute_risk * 100.0) + "%",
            'result_string': f'A {absolute_risk * 100.0}% estimated risk of developing melanoma over the next 5 years.',
            'gender': str(req_params['gender']).lower(),
            'ratio': int(ratio),
            'status': 200
        }

        return results