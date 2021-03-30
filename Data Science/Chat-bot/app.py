from flask import Flask
import numpy as np
from flask_cors import CORS
from flask_restful import Api, Resource, reqparse
from ChatbotFunctions import ChatbotFunctions

app = Flask(__name__)
chatbot_functions = ChatbotFunctions()
app.config['CORS_HEADERS'] = 'Content-Type'
CORS(app)
api = Api(app)
model = chatbot_functions.create_model(True)

class ChatbotChat(Resource):
    @staticmethod
    def post():
        parser = reqparse.RequestParser()
        parser.add_argument('UserIn')
        args = parser.parse_args()
        print(args['UserIn'])
        chatbot_response = {'Chatbot Response' : chatbot_functions.chat( args['UserIn'], model)}
        return chatbot_response, 200

api.add_resource(ChatbotChat, '/chatbot-predict')

if __name__ == '__main__':
        app.run(host="0.0.0.0", port=80)
