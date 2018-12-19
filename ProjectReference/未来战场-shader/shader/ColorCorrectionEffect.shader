Shader "Hidden/Color Correction Effect" {
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
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2.x = (texture2D (_RampTex, tmpvar_1.xx).x + 1e-05);
  tmpvar_2.y = (texture2D (_RampTex, tmpvar_1.yy).y + 2e-05);
  tmpvar_2.z = (texture2D (_RampTex, tmpvar_1.zz).z + 3e-05);
  tmpvar_2.w = tmpvar_1.w;
  gl_FragData[0] = tmpvar_2;
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
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2.x = (texture (_RampTex, tmpvar_1.xx).x + 1e-05);
  tmpvar_2.y = (texture (_RampTex, tmpvar_1.yy).y + 2e-05);
  tmpvar_2.z = (texture (_RampTex, tmpvar_1.zz).z + 3e-05);
  tmpvar_2.w = tmpvar_1.w;
  _glesFragData[0] = tmpvar_2;
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