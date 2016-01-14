#version 330 core

layout (location = 0) in vec3 vertex;

out vec3 V;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

uniform float time;

void main() {
  float a=0.1*time;
  mat3 Ry=mat3(vec3(cos(a), 0, -sin(a)), 
    vec3(0, 1, 0), 
    vec3(sin(a), 0, cos(a)));
  vec4 RV=vec4(Ry*vertex, 1);
  V=(modelViewMatrix*RV).xyz;
  gl_Position=modelViewProjectionMatrix*RV;
}
