#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

void main() {
  frontColor=vec4(color, 1);
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
}
