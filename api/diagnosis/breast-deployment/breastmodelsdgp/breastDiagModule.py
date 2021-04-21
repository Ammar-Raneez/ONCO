import uuid
import cv2
import matplotlib.cm as cm
import numpy as np
import io
import tensorflow as tf
from azure.storage.blob import BlobServiceClient, BlobClient, ContentSettings

class BreastDiagModule:# Predict using the model
    def get_img_array(self, img_array):
        IMG_SIZE = 100
        img = cv2.imdecode(img_array, cv2.IMREAD_GRAYSCALE)
        new_arr = cv2.resize(img, (IMG_SIZE, IMG_SIZE))
        new_arr = new_arr.reshape(-1, IMG_SIZE, IMG_SIZE, 1)
        return new_arr

    def make_gradcam_heatmap(self, img_array, model, last_conv_layer_name, classifier_layer_names):
        last_conv_layer = model.get_layer(last_conv_layer_name)
        last_conv_layer_model = tf.keras.Model(model.inputs, last_conv_layer.output)

        classifier_input = tf.keras.Input(shape=last_conv_layer.output.shape[1:])
        x = classifier_input
        for layer_name in classifier_layer_names:
            x = model.get_layer(layer_name)(x)
        classifier_model = tf.keras.Model(classifier_input, x)

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

    def store_gramcam_image(self, image_array, model):
        img_size = (100, 100)
        preprocess_input = tf.keras.applications.xception.preprocess_input
        decode_predictions = tf.keras.applications.xception.decode_predictions

        last_conv_layer_name = "max_pooling2d_14"
        classifier_layer_names = [
            "flatten_4",
            "dense_8",
        ]

        img_array = preprocess_input(self.get_img_array(image_array))
        
        heatmap = self.make_gradcam_heatmap(
            img_array, model, last_conv_layer_name, classifier_layer_names
        )

        img = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
        img = cv2.resize(img, img_size, 3)
        
        heatmap = np.uint8(255 * heatmap)

        jet = cm.get_cmap("jet")

        jet_colors = jet(np.arange(256))[:, :3]
        jet_heatmap = jet_colors[heatmap]
        
        jet_heatmap = tf.keras.preprocessing.image.array_to_img(jet_heatmap)
        jet_heatmap = jet_heatmap.resize((img.shape[1], img.shape[0]))
        jet_heatmap = tf.keras.preprocessing.image.img_to_array(jet_heatmap)

        superimposed_img = jet_heatmap * 0.4 + img
        superimposed_img = tf.keras.preprocessing.image.array_to_img(superimposed_img)
        
        extension = ".jpg"
        generateImageName = str(uuid.uuid4())
        filename = generateImageName + extension

        temp_io_bytes = io.BytesIO()
        superimposed_img.save(temp_io_bytes, format="jpeg")

        # try:
        blob = BlobClient.from_connection_string(conn_str= "DefaultEndpointsProtocol=https;AccountName=breastmodelsdgp;AccountKey=Z4feRa5pxvpxsD7MUwatkHD/977VCcUiT9g5OmqFVzp1nqmYER0wHwpLQfHxIAEF3pyntsTuB2ZWKY3YRQ8ojw==", container_name="superimposed-images", blob_name=filename)
        cnt_settings = ContentSettings(content_type="image/jpeg")

        blob.upload_blob(temp_io_bytes.getvalue(), blob_type="BlockBlob", content_settings=cnt_settings)
        # except:     
        #     print("same image uploaded")

        # getting download image URL
        image_url = f"https://breastmodelsdgp.blob.core.windows.net/superimposed-images/{filename}"
        return image_url

    def model_predict_breast(self, img_array, model):
        new_arr = self.get_img_array(img_array)
        prediction = model.predict([new_arr])
        return prediction
