#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrixInverse;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

uniform float n=4;

void main() {
  vec3 F=(modelViewMatrixInverse*lightPosition).xyz;
  float d=distance(vertex, F);
  float w=clamp(1/(pow(d, n)), 0, 1);
  vec3 V=(1-w)*vertex+w*F;
  vec3 N=normalize(normalMatrix*normal); 
  frontColor=vec4(normalize(normalMatrix*normal).z);
  gl_Position=modelViewProjectionMatrix*vec4(V,1);
}
