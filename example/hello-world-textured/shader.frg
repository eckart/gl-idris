#version 410

in vec2 passTextureCoords;
out vec4 out_Color;

uniform sampler2D textureSampler;

void main(void)
{
  out_Color = texture(textureSampler, passTextureCoords);
}
