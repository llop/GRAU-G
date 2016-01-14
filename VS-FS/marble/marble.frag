#version 330 core

uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;

uniform sampler2D noise;

in vec3 N;
in vec3 V;
out vec4 fragColor;

const vec4 WHITE=vec4(1);
const vec4 REDISH=vec4(0.5, 0.2, 0.2, 1);

const vec4 SPLANE=0.3*vec4(0, 1, -1, 0);
const vec4 TPLANE=0.3*vec4(-2, -1, 1, 0);

vec4 shading(vec3 N, vec3 V, vec4 diffuse) {
  N=normalize(N);
  V=normalize(V);
  const vec3 lightPos=vec3(0, 0, 2);
  vec3 L=normalize(lightPos-V);
  vec3 R=reflect(-L, N); 
  float NdotL=max(0, dot(N, L));
  float RdotV=max(0, dot(R, -V));
  float Ispec=pow(RdotV, 20);
  return diffuse*NdotL+Ispec;
}

void main() {
  // calculo coords textura
  vec4 vcoords=vec4(V, 1);
  float s=dot(vcoords, SPLANE);
  float t=dot(vcoords, TPLANE);
  vec2 texCoord=vec2(s, t);
  // calcular diffuse (gradiente)
  float v=2*texture(noise, texCoord).x;
  vec4 diffuse=WHITE;
  if (v<1) diffuse=mix(WHITE, REDISH, fract(v));
  else if (v<2) diffuse=mix(REDISH, WHITE, fract(v));
  // establecer color con la funcion 'shading'
  vec3 NE=normalMatrix*N;
  vec3 VE=(modelViewMatrix*vcoords).xyz;
  fragColor=shading(NE, VE, diffuse);
}
