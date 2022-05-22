import uuid

import cv2
import matplotlib.cm as cm
import numpy as np
import tensorflow as tf
from tensorflow import keras

def get_img_array(img_path, size):
    img = keras.preprocessing.image.load_img(img_path, target_size=size)
    array = keras.preprocessing.image.img_to_array(img)
    array = np.expand_dims(array, axis=0)
    return array

def make_gradcam_heatmap(img_array, model, last_conv_layer_name, classifier_layer_names):
  
    last_conv_layer = model.get_layer(last_conv_layer_name)
    last_conv_layer_model = keras.Model(model.inputs, last_conv_layer.output)

    classifier_input = keras.Input(shape=last_conv_layer.output.shape[1:])
    x = classifier_input
    for layer_name in classifier_layer_names:
        x = model.get_layer(layer_name)(x)
    classifier_model = keras.Model(classifier_input, x)

    with tf.GradientTape() as tape:
        last_conv_layer_output = last_conv_layer_model(img_array)
        tape.watch(last_conv_layer_output)
        preds = classifier_model(last_conv_layer_output)
        top_pred_index = tf.argmax(preds[0])
        top_class_channel = preds[:, top_pred_index]

    grads = tape.gradient(top_class_channel, last_conv_layer_output)

    pooled_grads = tf.reduce_mean(grads, axis=(0, 1, 2))

    last_conv_layer_output = last_conv_layer_output.numpy()[0]
    pooled_grads = pooled_grads.numpy()
    for i in range(pooled_grads.shape[-1]):
        last_conv_layer_output[:, :, i] *= pooled_grads[i]

    heatmap = np.mean(last_conv_layer_output, axis=-1)

    heatmap = np.maximum(heatmap, 0) / np.max(heatmap)
    return heatmap

def storeGradCamImageLung(local_target_image_path, model, firebase_storage):
    img_size = (224, 224)
    preprocess_input = keras.applications.xception.preprocess_input
    decode_predictions = keras.applications.xception.decode_predictions

    last_conv_layer_name = "block5_pool"
    classifier_layer_names = [
        "flatten",
        "dense",
    ]

    img_path = local_target_image_path

    img_array = preprocess_input(get_img_array(img_path, size=img_size))
    
    heatmap = make_gradcam_heatmap(
        img_array, model, last_conv_layer_name, classifier_layer_names
    )

    img = keras.preprocessing.image.load_img(img_path)
    img = keras.preprocessing.image.img_to_array(img)
    
    heatmap = np.uint8(255 * heatmap)

    jet = cm.get_cmap("jet")

    jet_colors = jet(np.arange(256))[:, :3]
    jet_heatmap = jet_colors[heatmap]
    
    jet_heatmap = keras.preprocessing.image.array_to_img(jet_heatmap)
    jet_heatmap = jet_heatmap.resize((img.shape[1], img.shape[0]))
    jet_heatmap = keras.preprocessing.image.img_to_array(jet_heatmap)

    superimposed_img = jet_heatmap * 0.4 + img
    superimposed_img = keras.preprocessing.image.array_to_img(superimposed_img)
    
    extension = ".jpg"
    generateImageName = str(uuid.uuid4())
    fileName = generateImageName + extension
    folderName = "superimposedImages"
    save_local_path = "superimposedImages/" + generateImageName + extension
    superimposed_img.save(save_local_path)

    firebase_storage.child(folderName + "/" + fileName).put(save_local_path)
    
    return save_local_path


# Predict using the model
def model_predictLung(img_path, model):
    IMG_SIZE = 224
    img_array = cv2.imread(img_path)
    new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE), 3)
    new_array = new_array.reshape(1, 224, 224, 3)
    prediction = model.predict([new_array])
    return prediction

# Calculate Prediction Percentage
def calculatePredictionPercentLung(image_path, model):
    prediction = model_predictLung(image_path, model)
    return str(np.amax(prediction[0][1] * 100))

# Get image download URL based on the image file name
def getImageUrlLung(imagePathName, firebase, firebase_storage):
    auth = firebase.auth()
    e = "onconashml@gmail.com"
    p = "onconashml12345"
    user = auth.sign_in_with_email_and_password(e, p)
    url = firebase_storage.child(imagePathName).get_url(user["idToken"])
    return url
    