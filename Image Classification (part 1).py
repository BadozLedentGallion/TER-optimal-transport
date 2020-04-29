#!/usr/bin/env python
# coding: utf-8

# In[2]:


#inspired by Julie Delon code: https://github.com/judelo/gmmot/blob/master/python/GMM_OT_color_transfer.ipynb

#library
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image
from mpl_toolkits.mplot3d import Axes3D
import scipy.linalg as spl
import scipy.stats as sps 
import sklearn.mixture    # for EM
from sklearn.cluster import KMeans  # for kmeans
import ot
from PIL import Image
import numpy as np


# In[6]:


# we must have the same number of pixels
#import picture 1
a = plt.imread("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/94393153_224384178893560_8797248239561605120_n.jpg")/255
#import picture 2
b = plt.imread("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/94397047_218192139469964_11714021647659827202_n.jpg")/255
#import picture 3
c = plt.imread("C:/Users/Guillaume GALLION/Documents/cours/MASTER/SEMESTRE 2/TER/application/2e application/GROUPAMA-STADIUM-NAMER-J2-3638-Modifier-ModifierHD-iloveimg-resized-iloveimg-cropped.jpg")/255

#dimensions of the picture
aheight,awidth,adim = a.shape
bheight,bwidth,bdim = b.shape
cheight,cwidth,cdim = c.shape

#display of 3 images
images, axes = plt.subplots(nrows=1, ncols=3, figsize=(20, 20))

axes[0].imshow(a)
axes[0].set_title('ISFA')
axes[1].imshow(b)
axes[1].set_title('LYON')
axes[2].imshow(c)
axes[2].set_title('GROUPAMA STADIUM')
images.tight_layout()


# In[36]:


#pixel display in RGB in 3d
A = a.reshape((aheight*awidth,3))
B = b.reshape((bheight*bwidth,3))
C = c.reshape((cheight*cwidth,3))

#constructs a random number generator
r    = np.random.RandomState(42)
nb   = 3000
ISFA = r.randint(A.shape[0], size=(nb,))
LYON = r.randint(B.shape[0], size=(nb,))
STADE = r.randint(C.shape[0], size=(nb,))
ISFA = A[ISFA, :]
LYON = B[LYON, :]
STADE = C[STADE, :]

#display pixels in 3d
image  = plt.figure(3, figsize=(20, 5))

axis = image.add_subplot(1, 3, 1, projection="3d")
axis.scatter(ISFA[:, 0], ISFA[:,1],ISFA[:, 2], c=ISFA,s=70)
axis.set_xlabel("Red"), axis.set_ylabel("Green"), axis.set_zlabel("Blue");

axis = image.add_subplot(1, 3, 2, projection="3d")
axis.scatter(LYON[:, 0], LYON[:,1],LYON[:, 2], c=LYON,s=70)
axis.set_xlabel("Red"), axis.set_ylabel("Green"), axis.set_zlabel("Blue");

axis = image.add_subplot(1, 3, 3, projection="3d")
axis.scatter(STADE[:, 0], STADE[:,1],STADE[:, 2], c=STADE,s=70)
axis.set_xlabel("Red"), axis.set_ylabel("Green"), axis.set_zlabel("Blue");


# In[ ]:


#import pixels in csv files
import csv
c = csv.writer(open("C:/Users/Documents/cours/MASTER/SEMESTRE 2/TER/ISFA.csv", "w"))
for i in range(406400):
    c.writerow([A[i][0],A[i][1],A[i][2]])
import csv
c = csv.writer(open("C:/Users/Documents/cours/MASTER/SEMESTRE 2/TER/LYON.csv", "w"))
for i in range(406400):
    c.writerow([B[i][0],B[i][1],B[i][2]])
import csv
c = csv.writer(open("C:/Users/Documents/cours/MASTER/SEMESTRE 2/TER/STADE.csv", "w"))
for i in range(406400):
    c.writerow([C[i][0],C[i][1],C[i][2]])


# In[46]:


#copy the ISFA image
aEDIT = np.copy(a)

for k in range(3):
    ak = a[:,:,k]
    ck = c[:,:,k]   
    ak_sort,index_a=np.sort(ak,axis=None),np.argsort(ak,axis=None)
    ck_sort,index_c=np.sort(ck,axis=None),np.argsort(ck,axis=None)
    uspecifw= np.zeros(aheight*awidth)
    uspecifw[index_a] = ck_sort
    uspecifw = uspecifw.reshape(aheight,awidth)
    aEDIT[:,:,k] = uspecifw

#Display ISFA's picture edit with picture of GROUPAMA STADIUM
plt.figure(figsize=(7, 7))
plt.imshow(aEDIT)


aEDIT = np.copy(a)

for k in range(3):
    ak = a[:,:,k]
    bk = b[:,:,k]   
    ak_sort,index_a=np.sort(ak,axis=None),np.argsort(ak,axis=None)
    bk_sort,index_b=np.sort(bk,axis=None),np.argsort(bk,axis=None)
    uspecifw= np.zeros(aheight*awidth)
    uspecifw[index_a] = bk_sort
    uspecifw = uspecifw.reshape(aheight,awidth)
    aEDIT[:,:,k] = uspecifw

#Display ISFA's picture edit with picture of LYON
plt.figure(figsize=(7, 7))
plt.imshow(aEDIT)


# In[20]:





# In[21]:





# In[ ]:





# In[ ]:




