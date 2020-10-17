#Small script that converts the pgm files to jpg
from PIL import Image
import glob

pgm_benign_images = glob.glob("proper-dataset/benign/*pgm")
pgm_malignant_images = glob.glob("proper-dataset/malignant/*pgm")

for filename in pgm_benign_images:
    img = Image.open(filename)
    img.save(filename[:-4] + ".jpg")
    
for filename in pgm_malignant_images:
    img = Image.open(filename)
    img.save(filename[:-4] + ".jpg")

