#version 330 core
        
layout(triangles) in;
layout(triangle_strip, max_vertices=36) out;

in vec3 vNormal[];
out vec3 gNormal;
out vec3 gPos;

uniform mat4 modelViewProjectionMatrix;

uniform float d=0.1;

vec3 getNormal(vec3 A, vec3 B, vec3 C) {
  vec3 P=B-A;
  vec3 Q=C-A;
  return vec3(P.y*Q.z-P.z*Q.y,P.z*Q.x-P.x*Q.z,P.x*Q.y-P.y*Q.x);
}

void prismVertex(vec3 V, vec3 N) {
  // nomal in objet space, vertex in clip space
  gPos=V;
  gNormal=N;
  gl_Position=modelViewProjectionMatrix*vec4(V, 1);
  EmitVertex();
}

void drawPrism(vec3 V1, vec3 V2, vec3 V3, vec3 N0) {
  vec3 A1=V1+d*N0;   // A = top side
  vec3 A2=V2+d*N0;
  vec3 A3=V3+d*N0;
  // bottom
  vec3 N=N0;
  prismVertex(V1, N);
  prismVertex(V2, N);
  prismVertex(V3, N);
  EndPrimitive();
  // side 1 (triangle strip)
  // 3 --- 4
  // |     |
  // 1 --- 2
  N=normalize(getNormal(V1, V2, A1));
  prismVertex(V1, N);
  prismVertex(V2, N);
  prismVertex(A1, N);
  prismVertex(A2, N);
  EndPrimitive();
  // side 2
  N=normalize(getNormal(V3, V1, A3));
  prismVertex(V3, N);
  prismVertex(V1, N);
  prismVertex(A3, N);
  prismVertex(A1, N);
  EndPrimitive();
  // side 3
  N=normalize(getNormal(V2, V3, A2));
  prismVertex(V2, N);
  prismVertex(V3, N);
  prismVertex(A2, N);
  prismVertex(A3, N);
  EndPrimitive();
}

void main(void) {
  vec3 N=(normalize(vNormal[0])+
          normalize(vNormal[1])+
          normalize(vNormal[2]))/3;
  drawPrism(gl_in[0].gl_Position.xyz,
            gl_in[1].gl_Position.xyz,
            gl_in[2].gl_Position.xyz,
            normalize(N));
}
