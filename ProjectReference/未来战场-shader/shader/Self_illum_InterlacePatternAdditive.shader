Shader "VX/SelfIllum/InterlacePatternAdditive" {
Properties {
 _MainTex ("Base", 2D) = "white" {}
 _TintColor ("TintColor", Color) = (1,1,1,1)
 _InterlacePattern ("InterlacePattern", 2D) = "white" {}
 _Illum ("_Illum", 2D) = "white" {}
 _EmissionLM ("Emission (Lightmapper)", Float) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" "Reflection"="RenderReflectionTransparentAdd" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" "Reflection"="RenderReflectionTransparentAdd" }
  ZWrite Off
  Cull Off
  Blend One One
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _InterlacePattern_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _InterlacePattern_ST.xy) + _InterlacePattern_ST.zw) + (_Time.xx * _InterlacePattern_ST.zw));
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _InterlacePattern;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * texture2D (_InterlacePattern, xlv_TEXCOORD1));
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _InterlacePattern_ST;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = (((_glesMultiTexCoord0.xy * _InterlacePattern_ST.xy) + _InterlacePattern_ST.zw) + (_Time.xx * _InterlacePattern_ST.zw));
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _InterlacePattern;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0) * texture (_InterlacePattern, xlv_TEXCOORD1));
  _glesFragData[0] = tmpvar_1;
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