default: all

all: mandelbrot.c

mandelbrot.c: mandelbrot.pyx setup.py
	python3 setup.py build_ext --inplace

run: all
	python3 main.py

clean:
	rm -f *.o *.so *.c *.cpp
	rm -rf build __pycache__
