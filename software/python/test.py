# %% Cell 1
import time
import numpy as np

# %% Cell 2
import matplotlib.pyplot as plt
from matplotlib import style
from requests.sessions import Request
x = [1, 2, 3, 4, 5]
y = [2, 4, 6, 8, 10]
plt.plot(x, y)
plt.show()

# %% Cell 3
radius = 2
circumference = 2 * np.pi * radius
print(circumference)

# %% Cell 4
import requests
from requests import get
r = requests.get('https://heuzef.com')
print(r.status_code)

# %% Cell 5
from fastapi import FastAPI
app = FastAPI()
print(app.version)
