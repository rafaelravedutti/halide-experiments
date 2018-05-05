# Halide path
HALIDE_PATH=/home/rafael/hdd/repositories/Halide

all: blur_3x3

blur_3x3:
	g++ blur_3x3.cpp -g -I ${HALIDE_PATH}/include -I ${HALIDE_PATH}/tools -L ${HALIDE_PATH}/bin -lHalide -lpthread -ljpeg `libpng-config --cflags --ldflags` -ldl -o blur_3x3 -std=c++11

clean:
	rm blur_3x3
