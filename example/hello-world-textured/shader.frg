#version 410

in vec2 passTextureCoords;
out vec4 out_Color;

uniform sampler2D textureSampler;

void main(void)
{
  vec4 color  = texture(textureSampler, passTextureCoords);
  if (color.a < 0.5) {
     discard;
  } 
  out_Color = color;
}
