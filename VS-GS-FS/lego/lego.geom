#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=24) out;

in vec4 vfrontColor[];
out float gtop;
out vec4 gfrontColor;
out vec3 gnormal;
out vec2 gtexCoord;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
 
uniform float Step=0.2;



void cubeVertex(float x, float y, float z, vec3 BT, vec3 N, vec4 color, bool isTop) {
  if (isTop) gtop=1;
  else gtop=0;
  gfrontColor=color;
  gnormal=N;
  gtexCoord=vec2(z, x); 
  vec3 V=vec3(x, y, z)*Step; 
  gl_Position=modelViewProjectionMatrix*vec4(V+BT, 1);
  EmitVertex();
}

void paintCube(vec3 BT, vec4 color) {
  // front
  vec3 N=normalize(normalMatrix*vec3(0, 0, 1));
  cubeVertex(0, 0, 1, BT, N, color, false);
  cubeVertex(1, 0, 1, BT, N, color, false);
  cubeVertex(0, 1, 1, BT, N, color, false);
  cubeVertex(1, 1, 1, BT, N, color, false);
  EndPrimitive();
  // back
  N=normalize(normalMatrix*vec3(0, 0, -1));
  cubeVertex(0, 1, 0, BT, N, color, false);
  cubeVertex(1, 1, 0, BT, N, color, false);
  cubeVertex(0, 0, 0, BT, N, color, false);
  cubeVertex(1, 0, 0, BT, N, color, false);
  EndPrimitive();
  // left
  N=normalize(normalMatrix*vec3(-1, 0, 0));
  cubeVertex(0, 0, 0, BT, N, color, false);
  cubeVertex(0, 0, 1, BT, N, color, false);
  cubeVertex(0, 1, 0, BT, N, color, false);
  cubeVertex(0, 1, 1, BT, N, color, false);
  EndPrimitive();
  // right
  N=normalize(normalMatrix*vec3(1, 0, 0));
  cubeVertex(1, 1, 0, BT, N, color, false);
  cubeVertex(1, 1, 1, BT, N, color, false);
  cubeVertex(1, 0, 0, BT, N, color, false);
  cubeVertex(1, 0, 1, BT, N, color, false);
  EndPrimitive();
  // top
  N=normalize(normalMatrix*vec3(0, 1, 0));
  cubeVertex(0, 1, 1, BT, N, color, true);
  cubeVertex(1, 1, 1, BT, N, color, true);
  cubeVertex(0, 1, 0, BT, N, color, true);
  cubeVertex(1, 1, 0, BT, N, color, true);
  EndPrimitive();
  // bottom
  N=normalize(normalMatrix*vec3(0, -1, 0));
  cubeVertex(1, 0, 0, BT, N, color, false);
  cubeVertex(1, 0, 1, BT, N, color, false);
  cubeVertex(0, 0, 0, BT, N, color, false);
  cubeVertex(0, 0, 1, BT, N, color, false);
  EndPrimitive();
}

void main(void) {
  // baricentro triangulo -(i, j, k) enteros
  vec3 BT=(gl_in[0].gl_Position.xyz+
          gl_in[1].gl_Position.xyz+
          gl_in[2].gl_Position.xyz)/3;
  BT/=Step;
  BT.x=floor(BT.x+0.5);
  BT.y=floor(BT.y+0.5);
  BT.z=floor(BT.z+0.5); 
  BT*=Step; 
  vec4 color=(vfrontColor[0]+vfrontColor[1]+vfrontColor[2])/3;
  paintCube(BT, color);
}
