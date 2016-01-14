#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;
layout (location=2) in vec3 color;

out vec4 vfrontColor;
out vec3 vnormal;

void main() {
  vfrontColor=vec4(color, 1);
  vnormal=normal;
  gl_Position=vec4(vertex, 1);
}
