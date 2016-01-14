#version 330 core

uniform sampler2D colorMap;

in vec2 vtexCoord;
out vec4 fragColor;

void main() {
  fragColor=texture(colorMap,vtexCoord);
}
