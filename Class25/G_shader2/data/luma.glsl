//
// standard-issue crap you put in every single file
//

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

//
// end standard-issue crap
//

uniform sampler2D texture; // this is the texture coming in
uniform vec2 texOffset; // how offset are we in the texture?
varying vec4 vertTexCoord; // this represents the current pixel *position*

void main(void) {

  vec2 currentpixel = vertTexCoord.st;
  vec4 color = texture2D(texture, currentpixel);

  // MOST IMPORTANT LINE IN THE WHOLE THING:  
  float luma = (color.r + color.g + color.b) / 3.; 
  gl_FragColor = vec4(luma, luma, luma, 1.0);       
}










