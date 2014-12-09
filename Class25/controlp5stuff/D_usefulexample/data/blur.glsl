// EDGE DETECTOR

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
uniform float scale; // how many pixels away to search
uniform float thresh; // threshold for noise reduction

varying vec4 vertTexCoord; // this represents the current pixel *position*


void main(void) {

  // these are all the coordinates for the 9 pixels
  vec2 tc0 = vertTexCoord.st + vec2(-texOffset.s, -texOffset.t)*scale;
  vec2 tc1 = vertTexCoord.st + vec2(         0.0, -texOffset.t)*scale;
  vec2 tc2 = vertTexCoord.st + vec2(+texOffset.s, -texOffset.t)*scale;
  vec2 tc3 = vertTexCoord.st + vec2(-texOffset.s,          0.0)*scale;
  vec2 tc4 = vertTexCoord.st + vec2(         0.0,          0.0)*scale;
  vec2 tc5 = vertTexCoord.st + vec2(+texOffset.s,          0.0)*scale;
  vec2 tc6 = vertTexCoord.st + vec2(-texOffset.s, +texOffset.t)*scale;
  vec2 tc7 = vertTexCoord.st + vec2(         0.0, +texOffset.t)*scale;
  vec2 tc8 = vertTexCoord.st + vec2(+texOffset.s, +texOffset.t)*scale;

  // these are the values of the pixels, based on the coordinates above
  vec4 col0 = texture2D(texture, tc0);
  vec4 col1 = texture2D(texture, tc1);
  vec4 col2 = texture2D(texture, tc2);
  vec4 col3 = texture2D(texture, tc3);
  vec4 col4 = texture2D(texture, tc4);
  vec4 col5 = texture2D(texture, tc5);
  vec4 col6 = texture2D(texture, tc6);
  vec4 col7 = texture2D(texture, tc7);
  vec4 col8 = texture2D(texture, tc8);

  // convolution kernel 1: add 'em up
  vec4 sum1 = (-1.0 * col0 + 0.0 * col1 + 1.0 * col2 +  
              -2.0 * col3 + 0.0 * col4 + 2.0 * col5 +
              -1.0 * col6 + 0.0 * col7 + 1.0 * col8);  
  // convolution kernel 2: add 'em up
  vec4 sum2 = (1.0 * col0 + 2.0 * col1 + 1.0 * col2 +  
               0.0 * col3 + 0.0 * col4 + 0.0 * col5 +
              -1.0 * col6 + -2.0 * col7 + -1.0 * col8); 
  vec4 sum = sqrt(sum1*sum1 + sum2*sum2); // figure out distance
  vec4 threshvec = vec4(thresh); // make a threshold vec4
  bvec4 onoroff = greaterThan(sum,threshvec); // binary operation 
  vec4 therealoutput = sum*float(onoroff); // multiply sum and binary
  // MOST IMPORTANT LINE IN THE WHOLE THING:          
  gl_FragColor = vec4(therealoutput); 
}










