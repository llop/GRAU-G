#version 330 core

uniform vec4 lightAmbient;
uniform vec4 lightDiffuse;
uniform vec4 lightSpecular;

uniform vec4 matAmbient;
uniform vec4 matDiffuse;
uniform vec4 matSpecular;
uniform float matShininess;

uniform bool world=true;

in vec3 NE;
in vec3 VE;
in vec3 LE;

in vec3 NW;
in vec3 VW;
in vec3 LW;

out vec4 fragColor; 

vec4 light(vec3 N, vec3 V, vec3 L) {
  N=normalize(N);
  V=normalize(V);
  L=normalize(L);
  vec3 R=normalize(2*dot(N, L)*N-L);
  float NdotL=max(0, dot(N, L));
  float RdotV=max(0, dot(R, V));
  float ldiff=NdotL;
  float lspec=0; 
  if (NdotL>0) lspec=pow(RdotV, matShininess); 
  return matAmbient*lightAmbient + matDiffuse*lightDiffuse*ldiff + matSpecular*lightSpecular*lspec;
}

void main() {
  if (world) fragColor=light(NW, VW, LW);
  else fragColor=light(NE, VE, LE);
}
