import os
import nltk
import numpy
import logging
import random
import json
# import tflearn
from tensorflow import keras
from nltk.stem.wordnet import WordNetLemmatizer
from nltk.stem.snowball import SnowballStemmer

scriptpath = os.path.abspath(__file__)
scriptdir = os.path.dirname(scriptpath)
INTENT_PATH = os.path.join(scriptdir, 'intents.json')
MODEL_PATH = os.path.join(scriptdir, 'chatbot.h5')
with open(INTENT_PATH) as intents:
    intent_data = json.load(intents)

class ChatbotFunctions:
    #Store the entire chat between user and bot
    user_messages = []
    bot_messages = []
    
    stemmer = None
    lemmatizer = None 
    context = None
    all_words = [] 
    all_labels = []
    all_patterns = [] 
    all_responses = []
    training = []
    output = []

    def __init__(self):
        self.stemmer = SnowballStemmer("english")
        self.lemmatizer = WordNetLemmatizer()

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
        
    def create_training_and_test(self):
        self.prep_data()
        out_empty = [0 for _ in range(len(self.all_labels))]
        for index, pattern in enumerate(self.all_patterns):
            bag = []
            words = [self.lemmatizer.lemmatize(word.lower()) for word in pattern]
            words = [self.stemmer.stem(word.lower()) for word in words]
            for word in self.all_words:
                if word in words:
                    bag.append(1)
                else:
                    bag.append(0)
            output_row = out_empty[:]
            output_row[self.all_labels.index(self.all_responses[index])] = 1
            self.training.append(bag)
            self.output.append(output_row)
        self.training = numpy.array(self.training)
        self.output = numpy.array(self.output)

    def create_model(self, retrain = True):
        self.create_training_and_test()
        model = keras.models.Sequential()
        model.add(keras.layers.Input(shape=[None, len(self.training[0])]))
        model.add(keras.layers.Dense(8, activation='relu'))
        model.add(keras.layers.Dense(8, activation='relu'))
        model.add(keras.layers.Dense(len(self.output[0]), activation='softmax'))

        # net = tflearn.input_data(shape=[None, len(self.training[0])])
        # net = tflearn.fully_connected(net, 8)
        # net = tflearn.fully_connected(net, 8)
        # net = tflearn.fully_connected(net, len(self.output[0]), activation='softmax')
        # net = tflearn.regression(net)
        # model = tflearn.DNN(net)
        
        if not retrain:
            model.load(MODEL_PATH)
        else:
            model.compile(optimizer=keras.optimizers.Adam(lr=1e-5), metrics=['accuracy'], loss='sparse_categorical_crossentropy')
            model.fit(self.training, self.output, epochs=1000, batch_size=8, verbose=1)
            # model.fit(X_inputs=self.training, Y_targets=self.output, n_epoch=1000, batch_size=8, show_metric=True)
            model.save(MODEL_PATH)
        return model

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
    
    def chat(self, user_input, model):          
        default_responses = [
        "Sorry, can't understand you, I am not perfect :'(", "Please give me more info :(", "Not sure I understand :(",
        "Please be more specific", "Please provide me more information"
        ]

        bag = self.bag_of_words(user_input)
        results = model.predict([bag])[0]
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