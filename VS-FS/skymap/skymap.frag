#version 330 core

uniform vec4 lightPosition;

uniform sampler2D map;

in vec3 N;
in vec3 P;
out vec4 fragColor;

vec4 sampleSphereMap(sampler2D sampler, vec3 V) { 
  float z=sqrt((V.z+1.0)/2.0);
  vec2 st=vec2((V.x/(2.0*z)+1.0)/2.0, (V.y/(2.0*z)+1.0)/2.0);
  return texture(sampler, st);
} 

void main() {
  vec3 L=normalize(lightPosition.xyz-P);
  fragColor=sampleSphereMap(map, L);
}
