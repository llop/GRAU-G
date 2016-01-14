#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

uniform mat4 modelViewProjectionMatrix;
uniform mat4 modelViewProjectionMatrixInverse;
uniform vec3 boundingBoxMin;

in vec4 vfrontColor[];
out vec4 gfrontColor;

const vec4 BLACK=vec4(0, 0, 0, 1);

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
}
