#separate data appropriately
import os
import sys
import shutil

all_dataset_path = "all-mias/"
#benign path
benign_dataset_path = "proper-dataset/benign/"
#malignant path
malignant_dataset_path = "proper-dataset/malignant/"

with open(all_dataset_path+"details.txt", "r") as f:
    for line in f:
        if ' B ' in line:
            #get referred image location
            image_location = all_dataset_path + str(line.split(' ')[0]) + ".pgm"
            #save location
            image_destination = benign_dataset_path + str(line.split(' ')[0]) + "_benign.pgm"
            #copy file to destination
            shutil.copy2(image_location, image_destination)
            
        elif ' M ' in line:
            image_location = all_dataset_path + str(line.split(' ')[0]) + ".pgm"
            image_destination = malignant_dataset_path + str(line.split(' ')[0]) + "_malignant.pgm"
            shutil.copy2(image_location, image_destination)
    

