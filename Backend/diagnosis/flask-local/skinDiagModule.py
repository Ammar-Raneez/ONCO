import cv2
import numpy as np


def load_img_data(size, image_path):   
        img_height, img_width = size, size
        images = []

        img = cv2.imread(image_path)
        img = cv2.resize(img, (img_height, img_width))
        img = img.astype(np.float32) / 255.
        images.append(img)

        images = np.stack(images, axis=0)
        return images
    
def preprocess(image_path):
    return load_img_data(128, image_path)

# upload image to firebase storage
def uploadSkinImg(imageName, firebase_storage, firebase):
    # Save the image to firebase cloud storage
    extension = ".jpg"
    fileName = imageName + extension
    folderName = "superimposedImages"
    save_local_path = "uploads/" + fileName

    # storing the image from local path to the firebase cloud storage
    firebase_storage.child(folderName + "/" + fileName).put(save_local_path)
    
    # get the downloadable url and return it
    auth = firebase.auth()
    e = "onconashml@gmail.com"
    p = "onconashml12345"
    user = auth.sign_in_with_email_and_password(e, p)
    url = firebase_storage.child(folderName + "/" + fileName).get_url(user["idToken"])
    print(url)
    return url

# Predict using the model
def model_predict_skin(image_path, model):
    image_array = preprocess(image_path)
    y_pred = model.predict(image_array)
    #for percentages
    return y_pred * 100
