#version 330 core

layout (location=0) in vec3 vertex;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;

vec4 RED=vec4(1,0,0,1);
vec4 YELLOW=vec4(1,1,0,1);
vec4 GREEN=vec4(0,1,0,1);
vec4 CYAN=vec4(0,1,1,1);
vec4 BLUE=vec4(0,0,1,1);

void main() {
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
  float y=2*(gl_Position.y/gl_Position.w+1.0);
	if (y<0) frontColor=RED;
	else if (y<1) frontColor=mix(RED, YELLOW, fract(y));
	else if (y<2) frontColor=mix(YELLOW, GREEN, fract(y));
	else if (y<3) frontColor=mix(GREEN, CYAN, fract(y));
	else if (y<4) frontColor=mix(CYAN, BLUE, fract(y));
	else frontColor=BLUE;
}
