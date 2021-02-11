#!/usr/bin/env python
# coding: utf-8

# In[1]:


from flask import Flask
from flask_cors import CORS
from flask_restful import Api, Resource, reqparse
from ChatbotFunctions import ChatbotFunctions


# In[2]:


app = Flask(__name__)
chatbot_functions = ChatbotFunctions()
app.config['CORS_HEADERS'] = 'Content-Type'
CORS(app)
api = Api(app)


# In[3]:


model = chatbot_functions.create_model()


# In[4]:


class ChatbotChat(Resource):
    username = ""
    def __init__(self, username):
        self.username = username

    @staticmethod
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('UserIn')
        args = parser.parse_args()
        
        user_input_array = np.fromiter(args.values(), dtype=float)
        chatbot_response = {'Chatbot Response' : chatbot_functions.chat(self.username, user_input_array)}
        
        return chatbot_response, 200


# In[5]:


api.add_resource(ChatbotChat, '/chatbot-predict')


# In[12]:


if __name__ == '__main__':
    app.run(host="0.0.0.0", port=80)

