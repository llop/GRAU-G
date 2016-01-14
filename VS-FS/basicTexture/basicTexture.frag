#version 330 core

uniform sampler2D colorMap;
 
in vec4 frontColor;
in vec2 vtexCoord;
out vec4 fragColor;

void main() {
  fragColor=frontColor*texture(colorMap,vtexCoord);
}
