import io
import os
#from picamera import PiCamera
from time import sleep
from google.cloud import storage
from google.cloud import vision
from google.cloud.vision import types

client = vision.ImageAnnotatorClient()
storage_client=storage.Client()
bucketname="tech-squad-c7be9.appspot.com"
bucket=storage_client.get_bucket(bucketname)
#camera = PiCamera()
#camera.start_preview()
for i in range(5):
    sleep(5)
    #camera.capture('/home/pi/Desktop/image%s.jpg' % i)
    file='C:/Users/dhaval/Downloads\crowd.jpg'
    with io.open(file,'rb') as image_file:
        content=image_file.read()
    image = types.Image(content=content)
    #response=client.label_detection(image=image)
#print(response.face_annotations)
blob=bucket.blob("A")
blob.upload_from_filename(file)
#camera.stop_preview()

