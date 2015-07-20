#version 410

in vec2 passTextureCoords;
in vec3 surfaceNormal;
in vec3 toLightVector;

out vec4 out_Color;

uniform sampler2D textureSampler;
uniform vec3 lightColor;

void main(void)
{
  vec3 unitNormal = normalize(surfaceNormal);
  vec3 unitLightVector = normalize(toLightVector);

  float nDotl = dot(unitNormal, unitLightVector);
  float brightness = max(nDotl, 0.0);
  vec3 diffuse = brightness * lightColor;
  
  vec4 color  = texture(textureSampler, passTextureCoords);
  out_Color = vec4(diffuse,1.0) * color;
}
