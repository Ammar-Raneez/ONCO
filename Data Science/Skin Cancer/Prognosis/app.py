from flask import Flask
from flask_restful import reqparse
from mrat_rest import MelanomaRiskAssessmentTool

app = Flask('onco_cancer_prognosis')
mrat = MelanomaRiskAssessmentTool()

@app.route('/skin_cancer_prognosis', methods=['POST'])
def skin_cancer_prognosis():
    parser = reqparse.RequestParser()
    parser.add_argument('age')
    parser.add_argument('gender')
    parser.add_argument('sunburn')
    parser.add_argument('complexion')
    parser.add_argument('big-moles')
    parser.add_argument('small-moles')
    parser.add_argument('freckling')
    parser.add_argument('damage')
    parser.add_argument('tan')

    args = parser.parse_args()
    out = mrat.getAbsoluteRisk(args)
    return out

# Running the Main Application
if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=False)
