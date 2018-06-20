# C and C++ compilers
CC=gcc
CXX=g++

# Halide path
HALIDE_PATH=/home/rafael/hdd/repositories/Halide

# Likwid path
LIKWID_PATH=$(dirname $(which likwid-perfctr))
LIKWID_LIB=${LIKWID_PATH}/../lib
LIKWID_INCLUDE=${LIKWID_PATH}/../include

all: blur_3x3

blur_3x3: blur_3x3.cpp
	${CXX} $^ -g -I ${HALIDE_PATH}/include -I ${HALIDE_PATH}/tools -L ${HALIDE_PATH}/bin -lHalide -lpapi -lpthread -ljpeg `libpng-config --cflags --ldflags` -ldl -o $@ -std=c++11

likwid_test: likwid_test.c
	${CC} -fopenmp -DLIKWID_PERFMON -L ${LIKWID_LIB} -I ${LIKWID_INCLUDE} $^ -o $@ -llikwid

perf_test: perf_example.c
	${CC} $^ -o $@

clean:
	rm -f blur_3x3 likwid_test perf_test
