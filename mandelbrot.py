#!/usr/bin/env python3

import numpy as np

def norm2(z):
    return z.real * z.real + z.imag * z.imag

def escape(z,c,z_max,n_max):
    i = 0
    z_max2 = z_max * z_max
    while norm2(z) < z_max2 and i < n_max:
        z = z * z + c
        i += 1
    return i

def mandelbrot(resolution, bound=1.2, z_max=2.0, n_max=500):
    step = 2.0 * bound / resolution
    counts = np.zeros((resolution+1,resolution+1), dtype=np.int32)

    for i in range(resolution+1):
        imag = bound - i * step
        for j in range(resolution+1):
            real = -bound + j * step - 0.5
            w = real + imag * 1j
            counts[i,j] = escape(w,w,z_max,n_max)

    return np.asaray(counts)
