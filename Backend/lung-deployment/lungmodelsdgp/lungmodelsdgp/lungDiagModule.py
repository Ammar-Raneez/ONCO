import glob
import os
import sys
import uuid
import cv2
import matplotlib.cm as cm
import numpy as np
import tensorflow as tf
from tensorflow import keras


class LungDiagModule:
    def get_img_array(self, img_path, size):
        # `img` is a PIL image of size 299x299
        img = keras.preprocessing.image.load_img(img_path, target_size=size)
        # `array` is a float32 Numpy array of shape (299, 299, 3)
        array = keras.preprocessing.image.img_to_array(img)
        # We add a dimension to transform our array into a "batch"
        # of size (1, 299, 299, 3)
        array = np.expand_dims(array, axis=0)
        return array

    def make_gradcam_heatmap(
        self, img_array, model, last_conv_layer_name, classifier_layer_names
    ):
        # First, we create a model that maps the input image to the activations
        # of the last conv layer
        last_conv_layer = model.get_layer(last_conv_layer_name)
        last_conv_layer_model = keras.Model(model.inputs, last_conv_layer.output)

        # Second, we create a model that maps the activations of the last conv
        # layer to the final class predictions
        classifier_input = keras.Input(shape=last_conv_layer.output.shape[1:])
        x = classifier_input
        for layer_name in classifier_layer_names:
            x = model.get_layer(layer_name)(x)
        classifier_model = keras.Model(classifier_input, x)

        # Then, we compute the gradient of the top predicted class for our input image
        # with respect to the activations of the last conv layer
        with tf.GradientTape() as tape:
            # Compute activations of the last conv layer and make the tape watch it
            last_conv_layer_output = last_conv_layer_model(img_array)
            tape.watch(last_conv_layer_output)
            # Compute class predictions
            preds = classifier_model(last_conv_layer_output)
            top_pred_index = tf.argmax(preds[0])
            top_class_channel = preds[:, top_pred_index]

        # This is the gradient of the top predicted class with regard to
        # the output feature map of the last conv layer
        grads = tape.gradient(top_class_channel, last_conv_layer_output)

        # This is a vector where each entry is the mean intensity of the gradient
        # over a specific feature map channel
        pooled_grads = tf.reduce_mean(grads, axis=(0, 1, 2))

        # We multiply each channel in the feature map array
        # by "how important this channel is" with regard to the top predicted class
        last_conv_layer_output = last_conv_layer_output.numpy()[0]
        pooled_grads = pooled_grads.numpy()
        for i in range(pooled_grads.shape[-1]):
            last_conv_layer_output[:, :, i] *= pooled_grads[i]

        # The channel-wise mean of the resulting feature map
        # is our heatmap of class activation
        heatmap = np.mean(last_conv_layer_output, axis=-1)

        # For visualization purpose, we will also normalize the heatmap between 0 & 1
        heatmap = np.maximum(heatmap, 0) / np.max(heatmap)
        return heatmap

    # Storing the Visualized GradCAM image to firebase storage
    def storeGradCamImageLung(self, local_target_image_path, model, firebase_storage):

        img_size = (224, 224)
        preprocess_input = keras.applications.xception.preprocess_input
        decode_predictions = keras.applications.xception.decode_predictions

        last_conv_layer_name = "block5_pool"
        classifier_layer_names = [
            "flatten",
            "dense",
        ]

        # The local path to our target image
        img_path = local_target_image_path

        # Prepare image
        img_array = preprocess_input(get_img_array(img_path, size=img_size))
        
        # Generate class activation heatmap
        heatmap = make_gradcam_heatmap(
            img_array, model, last_conv_layer_name, classifier_layer_names
        )

        # We load the original image
        img = keras.preprocessing.image.load_img(img_path)
        img = keras.preprocessing.image.img_to_array(img)
        
        # We rescale heatmap to a range 0-255
        heatmap = np.uint8(255 * heatmap)

        # We use jet colormap to colorize heatmap
        jet = cm.get_cmap("jet")

        # We use RGB values of the colormap
        jet_colors = jet(np.arange(256))[:, :3]
        jet_heatmap = jet_colors[heatmap]
        
        # We create an image with RGB colorized heatmap
        jet_heatmap = keras.preprocessing.image.array_to_img(jet_heatmap)
        jet_heatmap = jet_heatmap.resize((img.shape[1], img.shape[0]))
        jet_heatmap = keras.preprocessing.image.img_to_array(jet_heatmap)

        # Superimpose the heatmap on original image
        superimposed_img = jet_heatmap * 0.4 + img
        superimposed_img = keras.preprocessing.image.array_to_img(superimposed_img)
        
        # Save the superimposed image to firebase cloud storage
        extension = ".jpg"
        generateImageName = str(uuid.uuid4())
        fileName = generateImageName + extension
        folderName = "superimposedImages"
        save_local_path = "superimposedImages/" + generateImageName + extension
        superimposed_img.save(save_local_path)

        # storing the image from local path to the firebase cloud storage
        firebase_storage.child(folderName + "/" + fileName).put(save_local_path)
        
        # returning the file name of the image I have stored inside the firebase cloud storage
        return save_local_path


    # Predict using the model
    def model_predictLung(self, img_path, model):
        IMG_SIZE = 224
        img_array = cv2.imread(img_path)
        new_array = cv2.resize(img_array, (IMG_SIZE, IMG_SIZE), 3)
        new_array = new_array.reshape(1, 224, 224, 3)
        prediction = model.predict([new_array])
        return prediction

    # Calculate Prediction Percentage
    def calculatePredictionPercentLung(self, image_path, model):
        prediction = model_predictLung(image_path, model)
        return str(np.amax(prediction[0][1] * 100))

    # Get image download URL based on the image file name
    def getImageUrlLung(self, imagePathName, firebase, firebase_storage):
        auth = firebase.auth()
        e = "onconashml@gmail.com"
        p = "onconashml12345"
        user = auth.sign_in_with_email_and_password(e, p)
        url = firebase_storage.child(imagePathName).get_url(user["idToken"])
        print(url)
        return url
        