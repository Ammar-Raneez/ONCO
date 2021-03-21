import logging
import azure.functions as func
from .app import upload

def main(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    which_model = req.params.get('model')
    prediction = upload("", which_model)
    return func.HttpResponse(f"Hello, {prediction}", status_code = 200)
