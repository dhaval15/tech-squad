from picamera import PiCamera
from time import sleep
from google.cloud import storage


storage_client=storage.Client()
bucketname="Bus_seats"
bucket=storage_client.create_bucket(bucket_name)
camera = PiCamera()
camera.start_preview()
for i in range(5):
    sleep(5)
    camera.capture('/home/pi/Desktop/image%s.jpg' % i)
    blob=bucket.blob("name")
    blob.upload_from_filename('/home/pi/Desktop/image%s.jpg' % i)
camera.stop_preview()

