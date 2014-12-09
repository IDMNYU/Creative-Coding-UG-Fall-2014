#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture; // this is the first image sent in
uniform sampler2D mask; // this is the second image sent in by processing

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec4 texColor = texture2D(texture, vertTexCoord.st);
  vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, 1.0 - vertTexCoord.t));
  gl_FragColor = texColor*maskColor;
}