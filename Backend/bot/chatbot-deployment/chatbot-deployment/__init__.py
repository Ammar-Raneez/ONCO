import azure.functions as func
from .ChatbotFunctions import ChatbotFunctions

chatbot_functions = ChatbotFunctions()
model = chatbot_functions.create_model()

def main(req: func.HttpRequest) -> func.HttpResponse:
    req_body = req.get_json()
    user_input = req_body.get('UserIn')

    response = chatbot_functions.chat(user_input, model)

    return func.HttpResponse(response, status_code=200)
