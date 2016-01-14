#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec2 vtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform int tiles=1;

void main() {
  vtexCoord=texCoord*tiles;
  gl_Position=modelViewProjectionMatrix*vec4(vertex.xyz,1);
}
