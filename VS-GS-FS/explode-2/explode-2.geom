#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

uniform mat4 modelViewProjectionMatrix;

uniform float time;

const float speed=0.5;
const float angSpeed=8.0;

in vec4 vfrontColor[];
in vec3 vnormal[];
out vec4 gfrontColor; 

void main(void) {
  // calcul promig normal + baricentre triangle
  vec3 N=speed*time*(vnormal[0]+vnormal[1]+vnormal[2])/3;
  vec3 BT=(gl_in[0].gl_Position.xyz+
          gl_in[1].gl_Position.xyz+
          gl_in[2].gl_Position.xyz)/3;
  // matriu rotacio
  float a=time*angSpeed;
  mat3 Rz=mat3(vec3(cos(a), sin(a), 0),
              vec3(-sin(a), cos(a), 0), 
              vec3(0, 0, 1));
  for (int i=0; i<3; ++i) { 
    gfrontColor=vfrontColor[i];
    vec3 V=gl_in[i].gl_Position.xyz-BT;   // portar al centre
    V=Rz*V;                               // rotar sobre eix Z
    V+=BT+N;                              // traslladar al desti
    gl_Position=modelViewProjectionMatrix*vec4(V, 1);
    EmitVertex();
  }
  EndPrimitive();
}
