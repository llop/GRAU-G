#version 330 core

layout (location=0) in vec3 vertex; 
layout (location=2) in vec3 color;

out vec4 vfrontColor;

void main() {
  vfrontColor=vec4(color, 1);
  gl_Position=vec4(vertex, 1);
}
