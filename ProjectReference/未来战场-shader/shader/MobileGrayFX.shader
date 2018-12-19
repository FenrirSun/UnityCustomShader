Shader "Hidden/MobileGrayFX" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _RampTex ("Base (RGB)", 2D) = "grayscaleRamp" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 inUV_4;
  inUV_4 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = inUV_4;
  tmpvar_3 = (glstate_matrix_texture0 * tmpvar_5).xy;
  tmpvar_2 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform mediump float _RampOffset;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = dot (tmpvar_2.xyz, vec3(0.22, 0.707, 0.071));
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.5;
  tmpvar_4.x = (tmpvar_3 + _RampOffset);
  xlat_varoutput_1.xyz = texture2D (_RampTex, tmpvar_4).xyz;
  xlat_varoutput_1.w = tmpvar_2.w;
  gl_FragData[0] = xlat_varoutput_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture0;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 inUV_4;
  inUV_4 = tmpvar_1;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = inUV_4;
  tmpvar_3 = (glstate_matrix_texture0 * tmpvar_5).xy;
  tmpvar_2 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _RampTex;
uniform mediump float _RampOffset;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 xlat_varoutput_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = dot (tmpvar_2.xyz, vec3(0.22, 0.707, 0.071));
  mediump vec2 tmpvar_4;
  tmpvar_4.y = 0.5;
  tmpvar_4.x = (tmpvar_3 + _RampOffset);
  xlat_varoutput_1.xyz = texture (_RampTex, tmpvar_4).xyz;
  xlat_varoutput_1.w = tmpvar_2.w;
  _glesFragData[0] = xlat_varoutput_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback Off
}