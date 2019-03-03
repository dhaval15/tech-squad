import io
import os
from picamera import PiCamera
from time import sleep
from google.cloud import storage
from google.cloud import vision
from google.cloud.vision import types
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

client = vision.ImageAnnotatorClient()
storage_client=storage.Client()
bucketname="tech-squad-c7be9.appspot.com"
bucket=storage_client.get_bucket(bucketname)
camera = PiCamera()
camera.start_preview()

cred = credentials.Certificate('home/pi/tech.json')

# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': 'https://tech-squad-c7be9.firebaseio.com'
})

for i in range(5):
    camera.capture('/home/pi/Desktop/image%s.jpg' % i)
    file='/home/pi/Desktop/image%s.jpg' % i'
    with io.open(file,'rb') as image_file:
        content=image_file.read()
    image = types.Image(content=content)
    response=client.label_detection(image=image)
	ref = db.reference('analysed/%s' % i);
	ref.set(response);
	

