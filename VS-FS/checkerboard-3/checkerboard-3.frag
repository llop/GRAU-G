#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform float n=8;

const vec4 GREY=vec4(vec3(0.8), 1);
const vec4 BLACK=vec4(vec3(0), 1);

void main() {
  float x=fract(vtexCoord.x*n);
  float y=fract(vtexCoord.y*n);
  if (x>0.1 && y>0.1) fragColor=GREY;
  else fragColor=BLACK;
}
