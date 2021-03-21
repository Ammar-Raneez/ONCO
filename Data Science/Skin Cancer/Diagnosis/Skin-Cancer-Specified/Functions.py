import cv2 
import numpy as np

class Functions:
    def load_img_data(self, size, image_path):   
        img_height, img_width = size, size
        images = []

        img = cv2.imread(image_path)
        img = cv2.resize(img, (img_height, img_width))
        img = img.astype(np.float32) / 255.
        images.append(img)

        images = np.stack(images, axis=0)
        return images
    
    def preprocess(self, image_path):
        return self.load_img_data(128, image_path)