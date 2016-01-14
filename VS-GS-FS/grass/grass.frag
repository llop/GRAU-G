#version 330 core

in vec3 gNormal;
in vec3 gPos;
out vec4 fragColor;

uniform sampler2D grass_top0, grass_side1;

uniform float d=0.1;

void main() {
  // grass side
  vec2 grassSideST=vec2(4*(gPos.x-gPos.y), 1.0-gPos.z/d);
  vec4 TGS=texture2D(grass_side1, grassSideST);
  // grass top
  vec2 grassTopST=4*gPos.xy;
  vec4 TGT=texture2D(grass_top0, grassTopST);
  if (gNormal.z==0) {
    // vertical
    if (TGS.a<0.1) discard;
    else fragColor=TGS;
  } else {
    // horitzontal
    fragColor=TGT;
  }
}
