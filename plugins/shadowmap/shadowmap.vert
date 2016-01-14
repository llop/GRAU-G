#version 330 core

layout (location=0) in vec3 vertex;
layout (location=1) in vec3 normal;

uniform mat4 lightViewMatrix; 
uniform mat4 lightProjectionMatrix;
uniform mat4 biasMatrix;

uniform mat3 normalMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 modelViewProjectionMatrix;

out vec3 N;
out vec3 P;
out vec4 vtexCoord;

void main()
{
    P = (modelViewMatrix*vec4(vertex,1.0)).xyz;
    N = normalMatrix * normal;
	vtexCoord = biasMatrix*lightProjectionMatrix*lightViewMatrix*vec4(vertex,1.0);
	gl_Position    = modelViewProjectionMatrix * vec4(vertex,1.0);
}

