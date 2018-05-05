# Halide path
HALIDE_PATH=/home/rafael/hdd/repositories/Halide
# Compiler
CC=g++

all: blur_3x3

blur_3x3: blur_3x3.cpp
	${CC} $^ -g -I ${HALIDE_PATH}/include -I ${HALIDE_PATH}/tools -L ${HALIDE_PATH}/bin -lHalide -lpthread -ljpeg `libpng-config --cflags --ldflags` -ldl -o $@ -std=c++11

clean:
	rm blur_3x3
