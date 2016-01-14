#version 330 core

in float gtop;
in vec4 gfrontColor;
in vec3 gnormal;
in vec2 gtexCoord;
out vec4 fragColor;

uniform sampler2D colorMap;

const vec4 RED=vec4(1,0,0,1);
const vec4 GREEN=vec4(0,1,0,1);
const vec4 BLUE=vec4(0,0,1,1);
const vec4 CYAN=vec4(0,1,1,1);
const vec4 YELLOW=vec4(1,1,0,1);

vec4 closestColor(vec4 C) {
  float redDis=length(C-RED);
  float greenDis=length(C-GREEN);
  float blueDis=length(C-BLUE);
  float cyanDis=length(C-CYAN);
  float yellowDis=length(C-YELLOW);
  if (redDis<=greenDis&&redDis<=blueDis&&redDis<=cyanDis&&redDis<=yellowDis) return RED;
  if (greenDis<=redDis&&greenDis<=blueDis&&greenDis<=cyanDis&&greenDis<=yellowDis) return GREEN;
  if (cyanDis<=redDis&&cyanDis<=blueDis&&cyanDis<=greenDis&&cyanDis<=yellowDis) return CYAN;
  if (blueDis<=redDis&&blueDis<=cyanDis&&blueDis<=greenDis&&blueDis<=yellowDis) return BLUE;
  return YELLOW; 
}

void main() {
  vec4 TC=texture2D(colorMap, gtexCoord); 
  vec4 C=closestColor(gfrontColor);
  if (gtop>0) fragColor=C*TC*normalize(gnormal).z;
  else fragColor=C*normalize(gnormal).z;
}
