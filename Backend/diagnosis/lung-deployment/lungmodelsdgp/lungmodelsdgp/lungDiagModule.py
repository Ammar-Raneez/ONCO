import uuid
import cv2
import matplotlib.cm as cm
import numpy as np
import io
import tensorflow as tf
from azure.storage.blob import BlobServiceClient, BlobClient, ContentSettings

class LungDiagModule:
    def get_img_array(self, image_array, size):
        #this is to decode the numpy byte array, and also make it a 3 channel array (224, 224, 3)
        img_array = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        new_array = cv2.resize(img_array, (size, size), 3)
        new_array = new_array.reshape(1, 224, 224, 3)
        return new_array

    def make_gradcam_heatmap(self, img_array, model, last_conv_layer_name, classifier_layer_names):
        # First, we create a model that maps the input image to the activations
        # of the last conv layer
        last_conv_layer = model.get_layer(last_conv_layer_name)
        last_conv_layer_model = tf.keras.Model(model.inputs, last_conv_layer.output)

        # Second, we create a model that maps the activations of the last conv
        # layer to the final class predictions
        classifier_input = tf.keras.Input(shape=last_conv_layer.output.shape[1:])
        x = classifier_input
        for layer_name in classifier_layer_names:
            x = model.get_layer(layer_name)(x)
        classifier_model = tf.keras.Model(classifier_input, x)

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
    def store_gramcam_image(self, image_array, model):
        img_size = 224
        preprocess_input = tf.keras.applications.xception.preprocess_input
        decode_predictions = tf.keras.applications.xception.decode_predictions

        last_conv_layer_name = "block5_pool"
        classifier_layer_names = [
            "flatten",
            "dense",
        ]

        # Prepare image
        img_array = preprocess_input(self.get_img_array(image_array, size=img_size))
        
        # Generate class activation heatmap
        heatmap = self.make_gradcam_heatmap(
            img_array, model, last_conv_layer_name, classifier_layer_names
        )

        # We load the original image, to superimpose over
        img = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        img = cv2.resize(img, (img_size, img_size), 3)
        
        # We rescale heatmap to a range 0-255
        heatmap = np.uint8(255 * heatmap)

        # We use jet colormap to colorize heatmap
        jet = cm.get_cmap("jet")

        # We use RGB values of the colormap
        jet_colors = jet(np.arange(256))[:, :3]
        jet_heatmap = jet_colors[heatmap]
        
        # We create an image with RGB colorized heatmap
        jet_heatmap = tf.keras.preprocessing.image.array_to_img(jet_heatmap)
        jet_heatmap = jet_heatmap.resize((img.shape[1], img.shape[0]))
        jet_heatmap = tf.keras.preprocessing.image.img_to_array(jet_heatmap)

        # Superimpose the heatmap on original image
        superimposed_img = jet_heatmap * 0.4 + img
        superimposed_img = tf.keras.preprocessing.image.array_to_img(superimposed_img)

        extension = ".jpg"
        generateImageName = str(uuid.uuid4())
        filename = generateImageName + extension
        
        temp_io_bytes = io.BytesIO()
        # store the superimposed_img bytes in the temp variable
        superimposed_img.save(temp_io_bytes, format="jpeg")

        # save superimposed image to a different container
        try:
            blob = BlobClient.from_connection_string(conn_str= "DefaultEndpointsProtocol=https;AccountName=lungmodelsdgp;AccountKey=g8El0qrc+rk/+3IvYL3ir+Mqp49Qine7j1wftVFsSp+bOlqIYr0AZ23mxtLJUgZ9elDSEuiQ1ZxrXGFcu99nyA==", container_name="superimposed-images", blob_name=filename)
            cnt_settings = ContentSettings(content_type="image/jpeg")

            blob.upload_blob(temp_io_bytes.getvalue(), blob_type="BlockBlob", content_settings=cnt_settings)
        except:     
            print("same image uploaded")

        # getting download image URL
        image_url = f"https://lungmodelsdgp.blob.core.windows.net/superimposed-images/{filename}"
        return image_url

    # Predict using the model
    def model_predict_lung(self, image_array, model):
        img_size = 224
        img_array = self.get_img_array(image_array, img_size)
        prediction = model.predict([img_array])
        return prediction
