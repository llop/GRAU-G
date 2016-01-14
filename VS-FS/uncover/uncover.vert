#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;
layout (location=2) in vec3 color;
layout (location=3) in vec2 texCoord;

uniform mat4 modelViewProjectionMatrix;

out float x;

void main() {
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
  x=gl_Position.x/gl_Position.w+1;
}
