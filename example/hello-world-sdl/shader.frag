#version 410 core

in vec2 passTextureCoords;

out vec4 out_Color;

uniform sampler2D textureSampler;

void main(void)
{

  // texture
  vec4 color  = texture(textureSampler, passTextureCoords);

  // mixing
  out_Color = vec4(color);
  //out_Color = vec4(1.0, 0.2, 0.2, 1.0);
}
