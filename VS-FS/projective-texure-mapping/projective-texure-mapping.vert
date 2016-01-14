#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;

out vec3 N;
out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

void main() {
  vec4 PC=modelViewProjectionMatrix*vec4(vertex, 1);
  vec3 PN=PC.xyz/PC.w;
  vtexCoord=0.5*PN.xy+vec2(0.5, 0.5);
  N=normalize(normalMatrix*normal);
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
}
