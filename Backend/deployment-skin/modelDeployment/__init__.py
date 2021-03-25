import numpy as np
import azure.functions as func
import cv2
import json
from .app import upload, get_firebase_image
from azure.storage.blob import BlobServiceClient, BlobClient
from pyrebase import pyrebase
# import uuid

# Initializing Firebase App
firebase_config = {
    "apiKey": "AIzaSyCTCf6EWg_Mthy590c8JpkX5CsOdIlpEA4",
    "authDomain": "onco-127df.firebaseapp.com",
    "projectId": "onco-127df",
    "databaseURL": "https://onco-127df-default-rtdb.firebaseio.com",
    "storageBucket": "onco-127df.appspot.com",
    "messagingSenderId": "425803825049",
    "appId": "1:425803825049:web:3f261cd2ecf11241065d08",
    "measurementId": "G-S3DZNYJLXT"
}
# firebase will store the image to be accessed in the frontend for the report generation
firebase = pyrebase.initialize_app(firebase_config)
firebase_storage = firebase.storage()

def main(req: func.HttpRequest) -> func.HttpResponse:
    headers = {
        "Content-type": "application/json",
        "Access-Control-Allow-Origin": "*"
    }

    #fetching the file passed in through form data
    fetched_file = req.files['file']
    filename = fetched_file.filename
    # make a unique filename, to avoid replacement upon same name uploads
    # filename = str(uuid.uuid4()) + ".jpg"
    #converting the file into a byte stream
    filestream = fetched_file.stream
    filestream.seek(0)

    # save image to azure storage blob
    #wrap inside try and catch to prevent errors thrown upon same image trying to be saved
    try:
        blob = BlobClient.from_connection_string(conn_str= "DefaultEndpointsProtocol=https;AccountName=modeldeployment;AccountKey=1YZ2Ziv4zRggyRKeb9swXkznHPhdD0qIEOuV99PCTiiq9e17DDvBWnbywgZImYtOIJCO14JYNO3YmUHOGW2tFg==", container_name="images", blob_name=filename)
        blob.upload_blob(filestream.read(), blob_type="BlockBlob")
    except:                                                                                                                                                                          
        pass

    which_model = req.params.get('model')
    blob_data = blob.download_blob()
    blob_data_as_bytes = blob_data.content_as_bytes()

    #convert it into a numpy array, so that it can be passed into opencv
    np_blob_array = np.fromstring(blob_data_as_bytes, dtype='uint8')
    prediction = upload(np_blob_array, which_model)

    # getting download image URL
    image_url = get_firebase_image(filename, filestream.read(), firebase_storage, firebase)
    return func.HttpResponse(json.dumps([{"imageDownloadURL": image_url, "result_string": prediction}]), status_code = 200, headers = headers)
