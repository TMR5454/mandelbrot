#distutils: extra_compile_args = -fopenmp
#distutils: extra_link_args = -fopenmp
from threading import Thread
from cython.parallel import *

# cython: boundscheck=False
# cytohn: wrapround=False

import numpy as np

cdef inline double norm2(double complex z) nogil:
    return z.real * z.real + z.imag * z.imag

cdef int escape (double complex z, double complex c, double z_max, int n_max) nogil:
    cdef:
        int i = 0
        double z_max2 = z_max * z_max
    
    while norm2(z) < z_max2 and i < n_max:
        z = z * z + c
        i += 1
    return i

def mandelbrot(int resolution, double bound=1.2, double z_max=2.0, int n_max=500):
    cdef:
        double step = 2.0 * bound / resolution
        int i,j
        double complex w
        double real, imag
        int [:,:] counts

    counts = np.zeros((resolution+1,resolution+1), dtype=np.int32)

    for i in prange(resolution+1, nogil=True, schedule="static", chunksize=1):
        imag = bound - i * step
        for j in range(resolution+1):
            real = -bound + j * step - 0.5
            w = real + imag * 1j
            counts[i,j] = escape(w,w,z_max,n_max)
    
    return np.asarray(counts)
