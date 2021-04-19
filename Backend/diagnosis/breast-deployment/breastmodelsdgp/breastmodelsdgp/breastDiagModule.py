import cv2
import numpy as np
class BreastDiagModule:# Predict using the model
    def preprocess(self, img_array, model):
        IMG_SIZE = 100
        img = cv2.imdecode(image_array, cv2.IMREAD_UNCHANGED)
        new_arr = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
        new_arr = new_arr.reshape(-1, IMG_SIZE, IMG_SIZE, 1)
        return new_arr

    def model_predict_breast(self, img_array, model):
        new_arr = self.preprocess()
        prediction = model.predict([new_arr])
        return prediction
