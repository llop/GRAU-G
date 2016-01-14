#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;
layout (location=2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

uniform float time;
uniform bool eyespace=true;

void main() {
  float r=length(boundingBoxMax-boundingBoxMin)/2;
  float y=vertex.y;
  if (eyespace) y=(modelViewMatrix*vec4(vertex, 1)).y;
  float d=(r/10)*y;
  vec3 V=vertex+normal*d*sin(time);
  frontColor=vec4(color, 1);
  gl_Position=modelViewProjectionMatrix*vec4(V, 1);
}
