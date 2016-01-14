#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;
layout (location = 2) in vec3 color;
layout (location = 3) in vec2 texCoord;

out vec4 frontColor;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;

uniform vec3 boundingBoxMin;
uniform vec3 boundingBoxMax;

vec4 RED=vec4(1,0,0,1);
vec4 YELLOW=vec4(1,1,0,1);
vec4 GREEN=vec4(0,1,0,1);
vec4 CYAN=vec4(0,1,1,1);
vec4 BLUE=vec4(0,0,1,1);

void main() {
  float y=4*(vertex.y-boundingBoxMin.y)/(boundingBoxMax.y-boundingBoxMin.y);
	if (y==0) frontColor=RED;
	else if (y<1) frontColor=mix(RED, YELLOW, fract(y));
	else if (y<2) frontColor=mix(YELLOW, GREEN, fract(y));
	else if (y<3) frontColor=mix(GREEN, CYAN, fract(y));
	else if (y<4) frontColor=mix(CYAN, BLUE, fract(y));
	else frontColor=BLUE;
  gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
}
