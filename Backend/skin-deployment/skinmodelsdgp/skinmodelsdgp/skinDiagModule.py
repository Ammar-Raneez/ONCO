import cv2 
import numpy as np

class SkinDiagModule:
    def load_img_data(self, size, image_array):   
            img_height, img_width = size, size
            images = []
            #decode the image array so it can be preprocessed through opencv
            img = cv2.imdecode(image_array, cv2.IMREAD_UNCHANGED)
            img = cv2.resize(img, (img_height, img_width))
            img = img.astype(np.float32) / 255.
            images.append(img)

            images = np.stack(images, axis=0)
            return images
        
    def preprocess(self, image_array):
        return self.load_img_data(128, image_array)

    # Predict using the model
    def model_predict_skin(self, image_array, model):
        image_array = self.preprocess(image_array)
        y_pred = model.predict(image_array)
        #for percentages
        return y_pred * 100