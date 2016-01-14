#version 330 core

in vec3 P;
out vec4 fragColor;

uniform mat4 modelViewProjectionMatrixInverse;

uniform vec3 origin=vec3(0, 0, 0);
uniform vec3 axis=vec3(0, 0, 1);
uniform float slice=0.05;

const vec4 BLUE=vec4(0, 0, 1, 1);
const vec4 CYAN=vec4(0, 1, 1, 1);

void main() {
  vec3 A=normalize(axis);
  vec3 Q=origin+A*dot(P, A);
  int x=int(length(P-Q)/slice);
  if (mod(x, 2)==1) fragColor=BLUE;
  else fragColor=CYAN;
}
