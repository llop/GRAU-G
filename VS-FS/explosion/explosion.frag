#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D explosion;
uniform sampler2D frameMap1;

uniform float time;

void main() {
  float slice=1.0/30;
  int frame=int(mod(time/slice, 48));
  int x=frame%8;
  int y=5-frame/8;

  vec2 texCoord=vtexCoord*vec2(1.0/8, 1.0/6);
  texCoord.x+=x/8.0;
  texCoord.y+=y/6.0;
  fragColor=texture(explosion, texCoord);
  fragColor*=fragColor.w;
}
