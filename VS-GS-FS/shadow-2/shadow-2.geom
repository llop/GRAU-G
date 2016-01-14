#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;
uniform vec3 boundingBoxMax;
uniform vec3 boundingBoxMin;

in vec4 vfrontColor[];
out vec4 gfrontColor;

const vec4 BLACK=vec4(0, 0, 0, 1);
const vec4 CYAN=vec4(0, 1, 1, 1);

void floorVertex(bool x, bool z, vec3 RC, float R) {
  gfrontColor=CYAN;
  if (x) RC.x+=R;
  else RC.x-=R;
  if (z) RC.z+=R;
  else RC.z-=R;
  gl_Position=modelViewProjectionMatrix*vec4(RC, 1);
  EmitVertex();
}

// explode tests speed = 0.5
void main(void) {
  for (int i=0; i<3; ++i) {
    gfrontColor=vfrontColor[i];
    gl_Position=gl_in[i].gl_Position;
    EmitVertex();
  }
  EndPrimitive();
  for (int i=0; i<3; ++i) {
    gfrontColor=BLACK;
    vec4 V=modelViewProjectionMatrixInverse*gl_in[i].gl_Position;
    V.y=boundingBoxMin.y;
    gl_Position=modelViewProjectionMatrix*V;
    EmitVertex();
  }
  EndPrimitive();
  if (gl_PrimitiveIDIn==0) { 
    float R=length(boundingBoxMax-boundingBoxMin)/2;
    vec3 RC=(boundingBoxMax+boundingBoxMin)/2;
    RC.y=boundingBoxMin.y-0.01;
    floorVertex(false, false, RC, R);
    floorVertex(true, false, RC, R);
    floorVertex(false, true, RC, R);
    floorVertex(true, true, RC, R);
    EndPrimitive();
  }
}
