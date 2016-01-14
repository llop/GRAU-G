#version 330 core

in vec3 N;
in vec3 P;
in vec4 frontColor;
out vec4 fragColor;

uniform float epsilon=0.1;
uniform float light=0.5;

const vec4 YELLOW=vec4(0.7, 0.6, 0, 1);

void main() {
  float c=abs(length(dot(normalize(P), normalize(N))));
  if (c<epsilon) fragColor=YELLOW;
  else fragColor=(frontColor*light)*N.z;
}
