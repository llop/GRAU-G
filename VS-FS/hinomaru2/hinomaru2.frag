#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform bool classic=true;

float aastep(float threshold, float x) {
  float width=0.7*length(vec2(dFdx(x), dFdy(x)));
  return smoothstep(threshold-width, threshold+width, x);
}

const float PI=acos(-1);

void main() {
  vec2 u=vec2(vtexCoord.x-0.5, vtexCoord.y-0.5); 
  float d=length(u);
  float c=step(0.2, d);
  if (classic && c>0.0) {
    float o=atan(u.x, u.y);
    float c2=step(mod(o/(PI/16)+0.5, 2), 1);
    fragColor=vec4(1, vec2(c2), 1);
  } else fragColor=vec4(1, vec2(c), 1);
}
