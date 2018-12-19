Shader "VX/SelfIllum/Texture_ColorMod" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _TintColor ("Main Color", Color) = (1,1,1,1)
 _ColorChangeMask ("Mask (RGB)", 2D) = "black" {}
 _ModifyColor ("Modify Color", Color) = (1,1,1,1)
}
SubShader { 
 Pass {
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
uniform sampler2D _ColorChangeMask;
uniform highp vec4 _ModifyColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 mask_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (c_3 * _TintColor);
  c_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ColorChangeMask, xlv_TEXCOORD0);
  mask_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (c_3, _ModifyColor, mask_2.xxxx);
  c_3 = tmpvar_7;
  tmpvar_1 = c_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
uniform sampler2D _ColorChangeMask;
uniform highp vec4 _ModifyColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 mask_2;
  mediump vec4 c_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  c_3 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (c_3 * _TintColor);
  c_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_ColorChangeMask, xlv_TEXCOORD0);
  mask_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (c_3, _ModifyColor, mask_2.xxxx);
  c_3 = tmpvar_7;
  tmpvar_1 = c_3;
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