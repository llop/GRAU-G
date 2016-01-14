#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;
layout (location=2) in vec3 color;
layout (location=3) in vec2 texCoord;

out vec3 N;
out vec3 P;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform bool worldSpace=true;

void main() {
  if (worldSpace) {
    N=normal;
    P=vertex;
  } else {
    N=normalMatrix*normal;
    P=(modelViewMatrix*vec4(vertex, 1)).xyz;
  }
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
}
