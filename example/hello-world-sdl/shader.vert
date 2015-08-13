#version 410 core

layout(location=0) in vec3 inPosition;
layout(location=1) in vec3 inNormal;
layout(location=2) in vec2 inTextureCoords;

out vec2 passTextureCoords;

uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 transformMatrix;

void main(void)
{
  mat4 id =  mat4(1.0);
  vec4 worldPosition = transformMatrix * vec4(inPosition,1.0);
  gl_Position = projectionMatrix * viewMatrix * worldPosition;
  //gl_Position = id * vec4(inPosition,1.0);
  //gl_Position = viewMatrix * vec4(inPosition,1.0);

  passTextureCoords = inTextureCoords;
}
