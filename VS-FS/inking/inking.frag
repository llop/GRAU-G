#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D map;

uniform int textureSize=1024;
uniform int edgeSize=2;
uniform float threshold=0.1;

void main() {
  vec2 left=vtexCoord+edgeSize*vec2(-1, 0)/textureSize;
  vec2 right=vtexCoord+edgeSize*vec2(1, 0)/textureSize;
  vec2 bottom=vtexCoord+edgeSize*vec2(0, -1)/textureSize;
  vec2 top=vtexCoord+edgeSize*vec2(0, 1)/textureSize;
  float gx=length(texture(map, right)-texture(map, left));
  float gy=length(texture(map, top)-texture(map, bottom));
  float f=length(vec2(gx, gy));
  if (f>threshold) fragColor=vec4(vec3(0), 1);
  else fragColor=texture(map, vtexCoord);
}
