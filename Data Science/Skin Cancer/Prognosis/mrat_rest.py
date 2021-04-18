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

        r = 1
        if sex == 0:
            r *= MRATConstants.SUNBURN[int(parameters['sunburn'] )]
            r *= MRATConstants.MALE_COMPLEXION[int(parameters['complexion'] )]
            r *= MRATConstants.BIG_MOLES[int(parameters['big-moles'] )]
            r *= MRATConstants.MALE_SMALL_MOLES[int(parameters['small-moles'] )]
            r *= MRATConstants.MALE_FRECKLING[int(parameters['freckling'] )]
            r *= MRATConstants.DAMAGE[int(parameters['damage'] )]
        else:
            r *= MRATConstants.TAN[int(parameters['tan'] )]
            r *= MRATConstants.FEMALE_COMPLEXION[int(parameters['complexion'] )]
            r *= MRATConstants.FEMALE_SMALL_MOLES[int(parameters['small-moles'] )]
            r *= MRATConstants.FEMALE_FRECKLING[int(parameters['freckling'] )]