#version 330 core

layout (location=0) in vec3 vertex;
layout (location=2) in vec3 color;

uniform mat4 modelViewProjectionMatrix;
uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

out vec4 vFrontColor;

void main() {
  vFrontColor=vec4(color, 1);
  mat4 scale=mat4(vec4(boundingBoxMax.x-boundingBoxMin.x, 0, 0, 0),   // matriz de escalado
                  vec4(0, boundingBoxMax.y-boundingBoxMin.y, 0, 0),
                  vec4(0, 0, boundingBoxMax.z-boundingBoxMin.z, 0),
                  vec4(0, 0, 0, 1));
  vec4 BC=vec4((boundingBoxMax+boundingBoxMin)/2, 0);                 // centre capsa contenidora
  vec4 V=scale*vec4(vertex-vec3(0.5), 1);             // vertex escalat
  gl_Position=modelViewProjectionMatrix*(BC+V);       // traslacio
}

