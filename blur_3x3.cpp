/* Halide library */
#include "Halide.h"
#include "halide_image_io.h"
/* ... */
#include <stdio.h>

using namespace Halide;
using namespace Halide::Tools;

int main(int argc, const char **argv) {
  Buffer<uint8_t> input = Tools::load_image("input.png");
  Buffer<uint8_t> output(input.width() - 2, input.height() - 2, input.channels());
  Halide::Func blur_x, blur_y;
  Var x, y, xi, yi;

  blur_x(x, y) = (input(x - 1, y) + input(x, y) + input(x + 1, y)) / 3;
  blur_y(x, y) = (blur_x(x, y - 1) + blur_x(x, y) + blur_x(x, y + 1)) / 3;

  blur_y.tile(x, y, xi, yi, 256, 32).vectorize(xi, 8).parallel(y);
  blur_x.compute_at(blur_y, x).vectorize(x, 8);

  blur_y.compile_to_lowered_stmt("blur.html", {input}, HTML);

  output.set_min(1, 1);

  blur_y.realize(output);

  return 0;
}
