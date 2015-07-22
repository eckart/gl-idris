#version 410

in vec2 passTextureCoords;
in vec3 surfaceNormal;
in vec3 toLightVector;
in vec3 toCameraVector;

out vec4 out_Color;

uniform sampler2D textureSampler;
uniform vec3 lightColor;

//uniform vec3 lightIntensitySpecular; // Specular light intensity - a color
uniform vec3 reflectivitySpecular;   // Specular reflectivity - a color
uniform float shininessFactor;       // Specular shininess factor

void main(void)
{
  vec3 unitNormal = normalize(surfaceNormal);

  // diffuse
  vec3 unitLightVector = normalize(toLightVector);

  float nDotl = dot(unitNormal, unitLightVector);
  float brightness = max(nDotl, 0.0);
  vec3 diffuse = brightness * lightColor;

  // specular
  vec3 unitToCamera = normalize(toCameraVector);
  vec3 lightDirection  = -unitLightVector;
  vec3 reflectedLightDirection  = reflect(lightDirection, unitNormal);
  float specularAngle  = max(dot(reflectedLightDirection, unitToCamera), 0.0);
  float specularFactor = pow(specularAngle, shininessFactor);

  vec3 specularColor = specularFactor * reflectivitySpecular * lightColor;

  // texture
  vec4 color  = texture(textureSampler, passTextureCoords);

  // mixing
  out_Color = vec4(diffuse,1.0) * color + vec4(specularColor, 1.0);
}
