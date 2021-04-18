from flask import Flask
from flask_restful import reqparse

app = Flask('onco_cancer_prognosis')

@app.route('/skin_cancer_prognosis', methods=['POST'])
def skin_cancer_prognosis():
    pass

# Running the Main Application
if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
