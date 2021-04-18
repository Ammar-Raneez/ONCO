import numpy as np
import azure.functions as func
import cv2
import json
from .app import upload
from azure.storage.blob import BlobServiceClient, BlobClient, ContentSettings
import uuid

def main(req: func.HttpRequest) -> func.HttpResponse:
    headers = {
        "Content-type": "application/json",
        "Access-Control-Allow-Origin": "*"
    }

    #fetching the file passed in through form data
    fetched_file = req.files['file']
    # make a unique filename, to avoid replacement upon same name uploads
    filename = str(uuid.uuid4()) + ".jpg"
    #converting the file into a byte stream
    filestream = fetched_file.stream
    filestream.seek(0)

    # save image to azure storage blob
    #wrap inside try and catch to prevent errors thrown upon same image trying to be saved
    try:
        blob = BlobClient.from_connection_string(conn_str= "DefaultEndpointsProtocol=https;AccountName=skinmodelsdgp;AccountKey=WugXQYizUnx2W7Apf/RQV0wVtV29nI2GhG1ZiD3SsryK887JvGj/N0zJZIy0cgOwWRNAy3ggdLCRE0X8vUN2Cg==", container_name="images", blob_name=filename)
        cnt_settings = ContentSettings(content_type="image/jpeg")
        blob.upload_blob(filestream.read(), blob_type="BlockBlob", content_settings=cnt_settings)
    except: 
        print("same image uploaded")

    which_model = req.params.get('model')
    blob_data = blob.download_blob()
    blob_data_as_bytes = blob_data.content_as_bytes()

    #convert it into a numpy array, so that it can be passed into opencv
    np_blob_array = np.fromstring(blob_data_as_bytes, dtype='uint8')
    prediction = upload(np_blob_array, which_model)

    # getting download image URL
    image_url = f"https://skinmodelsdgp.blob.core.windows.net/images/{filename}"

    return func.HttpResponse(json.dumps([{"imageDownloadURL": image_url, "result_string": prediction, "status": 200}]), status_code = 200, headers = headers)
