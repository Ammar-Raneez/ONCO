import math
import json
from mrat_constants import MRATConstants

class MelanomaRiskAssessmentTool:
    @staticmethod
    def getAbsoluteRisk(parameters, age, sex):
        sex = None
        if parameters['gender'] == 'Male':
            sex = 0
        elif (parameters['gender'] == 'Female'):
            sex = 1

        absolute_risk = 1
        if sex == 0:
            absolute_risk *= MRATConstants.SUNBURN[int(parameters['sunburn'] )]
            absolute_risk *= MRATConstants.MALE_COMPLEXION[int(parameters['complexion'] )]
            absolute_risk *= MRATConstants.BIG_MOLES[int(parameters['big-moles'] )]
            absolute_risk *= MRATConstants.MALE_SMALL_MOLES[int(parameters['small-moles'] )]
            absolute_risk *= MRATConstants.MALE_FRECKLING[int(parameters['freckling'] )]
            absolute_risk *= MRATConstants.DAMAGE[int(parameters['damage'] )]
        else:
            absolute_risk *= MRATConstants.TAN[int(parameters['tan'] )]
            absolute_risk *= MRATConstants.FEMALE_COMPLEXION[int(parameters['complexion'] )]
            absolute_risk *= MRATConstants.FEMALE_SMALL_MOLES[int(parameters['small-moles'] )]
            absolute_risk *= MRATConstants.FEMALE_FRECKLING[int(parameters['freckling'] )]

        # to get incidence values
        age_index = int((age - 20) / 5)
        t1 = age_index * 5 + 20
        t2 = t1 + 5
        incident_rate = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index]
        mortality_rate = MRATConstants.MORTALITY[sex][age_index]
        
        risk = incident_rate * absolute_risk * (1 - math.exp((age - t2) * (incident_rate * absolute_risk + mortality_rate))) / (incident_rate * absolute_risk + mortality_rate)
        if age != t1:
            h12 = MRATConstants.SEX[sex] * MRATConstants.INCIDENCE[sex][age_index + 1]
            h22 = MRATConstants.MORTALITY[sex][age_index + 1]
            risk += h12 * absolute_risk * math.exp((age - t2) * (incident_rate * absolute_risk + mortality_rate)) * (1 - math.exp((t1 - age) * (h12 * absolute_risk + h22))) / (h12 * absolute_risk + h22)
        risk = round(risk * 10000) / 100
        ratio = round((risk * 0.01) * 1000)