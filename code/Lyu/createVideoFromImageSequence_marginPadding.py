#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jul 18 17:29:56 2022

@author: dianlyu
"""

import cv2
import numpy as np
import glob
import os
from PIL import Image 

# Folder which contains all the images
# from which video is to be generated

path = '/Users/dl577/Seagate-WORK_DL/Dropbox_backup/Stanford_Matters/data/THAL/CCEP/Plots/explore6/render1'
os.chdir(path)
files0 = np.array(glob.glob('*.jpg'))
time_seq = [];
for t,f in enumerate(files0):
    wordlist = f.split('_')
    time_seq.append(float(wordlist[2][0:-6]))
    
correct_order = np.argsort(time_seq)
files = files0[correct_order].tolist()



# Checking the current directory path
print(os.getcwd()) 
  
  
num_of_images = len(files)
# print(num_of_images)

all_widths = []
all_heights = []
for file in files:
    im = Image.open(os.path.join(path, file))
    width, height = im.size
    all_widths.append( width)
    all_heights.append(height)
    # im.show()   # uncomment this for displaying the image
  
# Finding the mean height and width of all images.
# This is required because the video frame needs
# to be set with same width and height. Otherwise
# images not equal to that width height will not get 
# embedded into the video
max_width = np.max(all_widths)
max_height = np.max(all_heights)
  
print(max_height)
print(max_width)

def add_margin(pil_img, top, right, bottom, left, color=(255,255,255)):
    width, height = pil_img.size
    new_width = width + right + left
    new_height = height + top + bottom
    result = Image.new(pil_img.mode, (new_width, new_height), color)
    result.paste(pil_img, (left, top))
    return result


# add marginal pudding to the right (or bottom) to make all images same size
for file in files:
    if file.endswith(".jpg") or file.endswith(".jpeg") or file.endswith("png"):
        # opening image using PIL Image
        im = Image.open(os.path.join(path, file)) 
   
        # im.size includes the height and width of image
        width, height = im.size   
        print(width, height)
  
        # add padding
        top = 0
        right = max_width - width
        bottom = max_height - height
        left = 0
        imResize = add_margin(im, top, right, bottom, left)
        imResize.save( file, 'JPEG', quality = 95) # setting quality
        # printing each resized image name
        print(im.filename.split('/')[-1], " is resized") 
  

# Video Generating function
def generate_video():
    image_folder = path # make sure to use your folder
    video_name = 'OutflowCCEP.mp4'
    os.chdir(path)
      
    images = files #[img for img in os.listdir(image_folder)
             # if img.endswith(".jpg") or
              #   img.endswith(".jpeg") or
               #  img.endswith("png")]
     
    # Array images should only consider
    # the image files ignoring others if any
    print(images) 
  
    frame = cv2.imread(os.path.join(image_folder, images[0]))
  
    # setting the frame width, height width
    # the width, height of first image
    height, width, layers = frame.shape  
    size = (width,height)
    video = cv2.VideoWriter(video_name, cv2.VideoWriter_fourcc('m','p','4','v'), 12, size) 
  
    # Appending the images to the video one by one
    for image in images: 
        video.write(cv2.imread(os.path.join(image_folder, image))) 
      
    # Deallocating memories taken for window creation
   # cv2.destroyAllWindows() 
    video.release()  # releasing the video generated
  
  
# Calling the generate_video function
generate_video()                              