#version 330 core

layout (location=0) in vec3 vertex;
layout (location=3) in vec2 texCoord;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform float time;

void main() {
  float a=-time*texCoord.x;
  mat3 R=mat3(vec3(cos(a), 0, -sin(a)),
    vec3(0, 1, 0),
    vec3(sin(a), 0, cos(a)));
  vec3 V=R*vertex;
  frontColor=vec4(0, 0, 1, 1);
  gl_Position=modelViewProjectionMatrix*vec4(V, 1);
}
