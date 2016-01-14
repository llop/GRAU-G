#version 330 core

in vec3 V;
out vec4 fragColor;

uniform sampler2D sampler;

void main() {
  vec3 normal=normalize(cross(dFdx(V), dFdy(V)));
  vec2 texCoord=normal.xy*normal.z;
  fragColor=texture(sampler, texCoord);
}
