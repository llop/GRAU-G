#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewMatrix;

const vec4 RED=vec4(1,0,0,1);
const vec4 YELLOW=vec4(1,1,0,1);

const float areamax=0.0005; 

out vec4 gfrontColor;

void main(void) {
  vec3 V1=(modelViewMatrix*gl_in[0].gl_Position).xyz;
  vec3 V2=(modelViewMatrix*gl_in[1].gl_Position).xyz;
  vec3 V3=(modelViewMatrix*gl_in[2].gl_Position).xyz;
  vec3 U=V2-V1;
  vec3 V=V3-V1;
  float a=length(cross(U, V))/2;  // modul producte vectorial
  a/=areamax;                     // normalitza valor
  vec4 frontColor=mix(RED, YELLOW, fract(a));
  if (a>=1.0) frontColor=YELLOW;
  for (int i=0; i<3; ++i) {
    gfrontColor=frontColor;
    gl_Position=modelViewProjectionMatrix*gl_in[i].gl_Position;
    EmitVertex();
  }
  EndPrimitive();
}
