#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;

out vec3 N;  // normal object space
out vec3 V;  // posicio object space

uniform mat4 modelViewProjectionMatrix;

void main() {
  N=normal;
  V=vertex;
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
}
