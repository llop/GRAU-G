#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;
layout (location=2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main() {
  frontColor=vec4(color, 1)*normalize(normalMatrix*normal).z;
  gl_Position=modelViewProjectionMatrix*vec4(normalize(vertex), 1);
}
