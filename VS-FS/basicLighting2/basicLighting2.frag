#version 330 core

in vec3 N;
in vec4 frontColor;

out vec4 fragColor; 

void main() {
    fragColor=frontColor*N.z;
}
