#version 330 core

layout (location=0) in vec3 vertex;
layout (location=2) in vec3 color;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

uniform float time;

void main() {
  float a=0.4*vertex.y*sin(time);
  mat3 Ry=mat3(vec3(cos(a), 0.0, -sin(a)), 
    vec3(0.0, 1.0, 0.0), 
    vec3(sin(a), 0.0, cos(a)));
  frontColor=vec4(color, 1);
  vec3 V=Ry*vertex;
  gl_Position=modelViewProjectionMatrix*vec4(V, 1);
}
