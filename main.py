#!/usr/bin/env python3

import time
import numpy as np
import matplotlib.pyplot as plt
import mandelbrot as mdb

def calc_mandelbrot():
    tm_start = time.time()
    n = mdb.mandelbrot(1000)
    tm_end = time.time()

    print(n)
    plt.figure(figsize=(10,10))
    plt.imshow(np.log(n+1))
    print("time={}".format(tm_end-tm_start))
    plt.show()

if __name__ == "__main__":
    calc_mandelbrot()
