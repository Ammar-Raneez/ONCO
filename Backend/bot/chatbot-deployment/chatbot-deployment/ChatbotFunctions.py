import os
import nltk
import numpy
from tensorflow import keras
import random
import json
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.stem.snowball import SnowballStemmer

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
INTENTS_PATH = os.path.join(scriptdir, 'intents.json')
MODEL_PATH = os.path.join(scriptdir, 'chatbot.h5')

with open(INTENTS_PATH) as intents:
    intent_data = json.load(intents)

class ChatbotFunctions:  
    stemmer = None
    lemmatizer = None 
    context = None
    model = None
    all_words = [] 
    all_labels = []
    all_patterns = [] 
    all_responses = []
    training = []
    output = []

    def __init__(self):
        self.stemmer = SnowballStemmer("english")
        self.lemmatizer = WordNetLemmatizer()
        self.prep_data()
        self.model = keras.models.load_model(MODEL_PATH)

    def prep_data(self):
        for intent in intent_data['intents']:
            for pattern in intent['patterns']:
                words = nltk.word_tokenize(pattern)
                self.all_words.extend(words)
                self.all_patterns.append(words)
                self.all_responses.append(intent['tag'])
            if intent['tag'] not in self.all_labels:
                self.all_labels.append(intent['tag'])

        self.all_words = [self.lemmatizer.lemmatize(word.lower()) for word in self.all_words]
        self.all_words = [self.stemmer.stem(word.lower()) for word in self.all_words]
        self.all_words = sorted(list(set(self.all_words)))
        self.all_labels = sorted(self.all_labels)

    def bag_of_words(self, text):
        bag = [0 for _ in range(len(self.all_words))]                  
        text_words = nltk.word_tokenize(text)
        text_words = [self.lemmatizer.lemmatize(word.lower()) for word in text_words]
        text_words = [self.stemmer.stem(word.lower()) for word in text_words]
        for wrd in text_words:
            for index, word in enumerate(self.all_words):
                if word == wrd:
                    bag[index] = 1
        return numpy.array(bag)
    
    def chat(self, user_input):          
        default_responses = [
        "Sorry, can't understand you, I am not perfect :'(", "Please give me more info :(", "Not sure I understand :(",
        "Please be more specific", "Please provide me more information"
        ]

        bag = self.bag_of_words(user_input)
        bag = bag.reshape(1, -1)
        results = self.model.predict([bag])[0]
        result_index = numpy.argmax(results)
        result_tag = self.all_labels[result_index]

        if results[result_index] > 0.8:
            if result_tag == 'goodbye' or result_tag == 'thanks':
                responses = intent_data['intents'][1]['responses'] if result_tag == 'goodbye' else intent_data['intents'][5]['responses']
                return random.choice(responses) + "\n"

            for intent in intent_data['intents']:
                if intent['tag'] == result_tag:
                    if 'context_filter' not in intent or 'context_filter' in intent and intent['context_filter'] == self.context:
                        responses = intent['responses']
                        if 'context' in intent:
                            self.context = intent['context']
                        else:
                            self.context = None
                        return random.choice(responses) + "\n"
                    elif intent.get('direct_access'):
                        responses = intent['responses']
                        return random.choice(responses) + "\n"
                    return random.choice(default_responses) + "\n"
                
        return random.choice(default_responses) + "\n"
