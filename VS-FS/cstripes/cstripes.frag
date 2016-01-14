#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float nstripes=16;
uniform vec2 origin=vec2(0, 0);

const vec4 RED=vec4(1, 0, 0, 1);
const vec4 YELLOW=vec4(1, 1, 0, 1);

void main() {
  int x=int(length(vtexCoord-origin)*nstripes);
  if (mod(x, 2)==1) fragColor=YELLOW;
  else fragColor=RED;
}
