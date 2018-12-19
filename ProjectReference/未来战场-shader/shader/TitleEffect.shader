Shader "VX/FX/Title Effect" {
Properties {
 _MainTex ("Color Map(RGB)", 2D) = "white" {}
 _FXTex ("Distortion Map(Normal)", 2D) = "black" {}
 _DScale ("Distortion Scale", Float) = 0.3
 _DPower ("Distortion Power", Float) = 0.02
}
SubShader { 
 Pass {
  ZWrite Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _FXTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp float _DPower;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float Pow_1;
  mediump vec2 ColMapUV_2;
  lowp vec4 DScaleMap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FXTex, xlv_TEXCOORD1);
  DScaleMap_3.w = tmpvar_4.w;
  DScaleMap_3.xyz = ((tmpvar_4.xyz * 2.0) - 1.0);
  DScaleMap_3.xyz = normalize(DScaleMap_3.xyz);
  lowp vec2 tmpvar_5;
  tmpvar_5 = DScaleMap_3.xy;
  ColMapUV_2 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = (_DPower * texture2D (_MainTex, xlv_TEXCOORD0).w);
  Pow_1 = tmpvar_6;
  mediump vec2 P_7;
  P_7 = ((ColMapUV_2 * Pow_1) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, P_7);
  gl_FragData[0] = tmpvar_8;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp float _DScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _FXTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _FXTex_ST.xy) + _FXTex_ST.zw) * _DScale);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _FXTex;
uniform lowp float _DPower;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float Pow_1;
  mediump vec2 ColMapUV_2;
  lowp vec4 DScaleMap_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_FXTex, xlv_TEXCOORD1);
  DScaleMap_3.w = tmpvar_4.w;
  DScaleMap_3.xyz = ((tmpvar_4.xyz * 2.0) - 1.0);
  DScaleMap_3.xyz = normalize(DScaleMap_3.xyz);
  lowp vec2 tmpvar_5;
  tmpvar_5 = DScaleMap_3.xy;
  ColMapUV_2 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = (_DPower * texture (_MainTex, xlv_TEXCOORD0).w);
  Pow_1 = tmpvar_6;
  mediump vec2 P_7;
  P_7 = ((ColMapUV_2 * Pow_1) + xlv_TEXCOORD0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, P_7);
  _glesFragData[0] = tmpvar_8;
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