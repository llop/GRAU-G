#version 330 core

layout (location = 0) in vec3 vertex;
layout (location = 1) in vec3 normal;

out vec3 N;
out vec3 P;

uniform mat4 modelViewProjectionMatrix;

void main() {
	gl_Position=modelViewProjectionMatrix*vec4(vertex, 1);
	N=normal;
	P=vertex;
}
