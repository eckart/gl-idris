#version 410

layout(location=0) in vec4 inPosition;
layout(location=1) in vec2 inTextureCoords;

out vec2 passTextureCoords;

void main(void)
{
  gl_Position = inPosition;
  passTextureCoords = inTextureCoords;

}
