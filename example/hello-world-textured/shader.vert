#version 410 core

layout(location=0) in vec3 inPosition;
layout(location=1) in vec2 inTextureCoords;
layout(location=2) in vec3 inNormal;

out vec2 passTextureCoords;
out vec3 surfaceNormal;
out vec3 toLightVector;


uniform mat4 viewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 transformMatrix;

uniform vec3 lightPosition;

void main(void)
{
  vec4 worldPosition = transformMatrix * vec4(inPosition,1.0);
  gl_Position = projectionMatrix * viewMatrix * worldPosition;
  passTextureCoords = inTextureCoords;
  surfaceNormal = (transformMatrix * vec4(inNormal, 0.0)).xyz;
  toLightVector = lightPosition - worldPosition.xyz;

}
