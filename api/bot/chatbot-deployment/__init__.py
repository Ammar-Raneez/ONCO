import azure.functions as func
from .ChatbotFunctions import ChatbotFunctions
import logging

chatbot_functions = ChatbotFunctions()

def main(req: func.HttpRequest) -> func.HttpResponse:
    req_body = req.get_json()
    user_input = req_body.get('UserIn')
    logging.info(user_input)
    response = chatbot_functions.chat(user_input)

    return func.HttpResponse(response, status_code=200)
