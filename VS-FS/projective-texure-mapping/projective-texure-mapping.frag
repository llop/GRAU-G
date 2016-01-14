#version 330 core

in vec3 N;
in vec2 vtexCoord;
out vec4 fragColor;

uniform sampler2D sampler;

void main() {
  fragColor=texture(sampler, vtexCoord)*N.z;
}
