#version 330 core

uniform vec4 lightPosition;

uniform sampler2D map;

in vec3 N;
in vec3 P;
out vec4 fragColor;

vec4 sampleSphereMap(sampler2D sampler, vec3 R) { 
  float z=sqrt((R.z+1.0)/2.0);
  vec2 st=vec2((R.x/(2.0*z)+1.0)/2.0, (R.y/(2.0*z)+1.0)/2.0); 
  st.y=-st.y;
  return texture(sampler, st);
}

void main() {
  vec3 L=normalize(lightPosition.xyz-P);
  vec3 R=reflect(-L, N);
  //vec3 R=normalize(2*dot(N, L)*N-L);
  fragColor=sampleSphereMap(map, R);
}
