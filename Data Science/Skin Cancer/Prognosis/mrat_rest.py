import math
import json
from mrat_constants import MRATConstants

class MelanomaRiskAssessmentTool:
    @staticmethod
    def getAbsoluteRisk(parameters, age):
        sex = None
        # assess male or female
        if parameters['gender'] == 'Male':
            sex = 0
        elif parameters['gender'] == 'Female':
            sex = 1

        risk = 1
        if sex == 0:
            risk *= MRATConstants.SUNBURN[int(parameters['sunburn'] )]
            risk *= MRATConstants.MALE_COMPLEXION[int(parameters['complexion'] )]
            risk *= MRATConstants.BIG_MOLES[int(parameters['big-moles'] )]
            risk *= MRATConstants.MALE_SMALL_MOLES[int(parameters['small-moles'] )]
            risk *= MRATConstants.MALE_FRECKLING[int(parameters['freckling'] )]
            risk *= MRATConstants.DAMAGE[int(parameters['damage'] )]
        else:
            risk *= MRATConstants.TAN[int(parameters['tan'] )]
            risk *= MRATConstants.FEMALE_COMPLEXION[int(parameters['complexion'] )]
            risk *= MRATConstants.FEMALE_SMALL_MOLES[int(parameters['small-moles'] )]
            risk *= MRATConstants.FEMALE_FRECKLING[int(parameters['freckling'] )]

        # to get incidence and mortality values
        age_index = int((age - 20) / 5)
        t1 = age_index * 5 + 20
        t2 = t1 + 5
        incident_rate = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index]
        mortality_rate = MRATConstants.MORTALITY[sex][age_index]
        absolute_risk = incident_rate * risk * (1 - math.exp((age - t2) * (incident_rate * risk + mortality_rate))) / (incident_rate * risk + mortality_rate)

        if age != t1:
            next_incident_rate = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index + 1]
            next_mortality_rate = MRATConstants.MORTALITY[sex][age_index + 1]
            absolute_risk += next_incident_rate * risk * math.exp((age - t2) * (incident_rate * risk + mortality_rate)) * (1 - math.exp((t1 - age) * (next_incident_rate * risk + next_mortality_rate))) / (next_incident_rate * absolute_risk + next_mortality_rate)
        absolute_risk = round(absolute_risk * 10000) / 100
        ratio = round((absolute_risk * 0.01) * 1000)